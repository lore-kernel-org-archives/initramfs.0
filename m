From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 resend] allow ifup bring up network manually even
 without netroot
Date: Mon, 30 Jan 2012 14:42:18 +0800
Message-ID: <20120130064218.GA7100@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

For kdump we need scp vmcore to remote machine, the nic to be used is
not limited to netroot one. we need a feature for manually bringing up
 network interface. Also it is useful for emergency shell with
ssh-client for recovery or test purpose

I implement this by adding one argument to ifup script, user can use
`/sbin/ifup eth0 -m` to bring up eth0, note ifup will regard it a
manual operation for the nic specified in 1st argument if there's
the 2nd argument.

If same nic is used for netroot the 2nd argument will be ignored,
in this case we will leave netroot bring up it automatically to
avoid side effect. And in this case hooks such as kdump will need to
execute after netroot mounted.

`ifup eth0 -m` will create /tmp/net.eth0.manualup stamp file,
later dhclient-script can check this and pass $2 to netroot,
then netroot script will bring eth0 up

Thanks for comments and suggestions from David Dillow.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/dhclient-script |    8 ++
 modules.d/40network/ifup            |   97 ++++++++++++++++++++----------------
 modules.d/40network/netroot         |   86 ++++++++++++++++++-------------
 3 files changed, 111 insertions(+), 80 deletions(-)

Index: dracut/modules.d/40network/dhclient-script
===================================================================
--- dracut.orig/modules.d/40network/dhclient-script
+++ dracut/modules.d/40network/dhclient-script
@@ -76,7 +76,13 @@ case $reason in
             echo "$line"
         done >/tmp/dhclient.$netif.dhcpopts
         echo online > /sys/class/net/$netif/uevent
-        initqueue --onetime --name netroot-$netif netroot $netif
+
+        if [ -e /tmp/net.$netif.manualup ]; then
+            /sbin/netroot $netif -m
+            rm -f /tmp/net.$netif.manualup
+        else
+            initqueue --onetime --name netroot-$netif netroot $netif
+        fi
         ;;
     *) echo "dhcp: $reason";;
 esac
Index: dracut/modules.d/40network/ifup
===================================================================
--- dracut.orig/modules.d/40network/ifup
+++ dracut/modules.d/40network/ifup
@@ -5,9 +5,54 @@
 # We don't need to check for ip= errors here, that is handled by the
 # cmdline parser script
 #
+# without $2 means this is for real netroot case
+# or it is for manually bring up network ie. for kdump scp vmcore
 PATH=/usr/sbin:/usr/bin:/sbin:/bin
 
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+export PS4="ifup.$1.$$ + "
+exec >>/run/initramfs/loginit.pipe 2>>/run/initramfs/loginit.pipe
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+
+# Huh? No $1?
+[ -z "$1" ] && exit 1
+
+# $netif reads easier than $1
+netif=$1
+
+# enslave this interface to bond?
+if [ -e /tmp/bond.info ]; then
+    . /tmp/bond.info
+    for slave in $bondslaves ; do
+        if [ "$netif" = "$slave" ] ; then
+            netif=$bondname
+        fi
+    done
+fi
+
+# bridge this interface?
+if [ -e /tmp/bridge.info ]; then
+    . /tmp/bridge.info
+    if [ "$netif" = "$ethname" ]; then
+        if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
+            : # We need to really setup bond (recursive call)
+        else
+            netif="$bridgename"
+        fi
+    fi
+fi
+
+# bail immediately if the interface is already up
+# or we don't need the network
+[ -f "/tmp/net.$netif.up" ] && exit 0
+[ -f "/tmp/root.info" ] || exit 0
+. /tmp/root.info
+
+# disable manual ifup while netroot is set for simplifying our logic
+# in netroot case we prefer netroot to bringup $netif automaticlly
+[ -n "$2" ] && [ -z "$netroot" ] && manualup="$2"
+[ -z "$netroot" ] && [ -z "$manualup" ] && exit 0
+[ -n "$manualup" ] && >/tmp/net.$netif.manualup
 
 # Run dhclient
 do_dhcp() {
@@ -50,7 +95,11 @@ do_ipv6auto() {
 
 
     echo online > /sys/class/net/$netif/uevent
-    initqueue --onetime --name netroot-$netif netroot $netif
+    if [ -n "$manualup" ]; then
+        /sbin/netroot $netif -m
+    else
+        initqueue --onetime --name netroot-$netif netroot $netif
+    fi
 }
 
 # Handle static ip configuration
@@ -77,47 +126,12 @@ do_static() {
     fi >> /tmp/net.$netif.resolv.conf
 
     echo online > /sys/class/net/$netif/uevent
-    initqueue --onetime --name netroot-$netif netroot $netif
-}
-
-export PS4="ifup.$1.$$ + "
-exec >>/run/initramfs/loginit.pipe 2>>/run/initramfs/loginit.pipe
-type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
-
-# Huh? No $1?
-[ -z "$1" ] && exit 1
-
-# $netif reads easier than $1
-netif=$1
-
-# enslave this interface to bond?
-if [ -e /tmp/bond.info ]; then
-    . /tmp/bond.info
-    for slave in $bondslaves ; do
-        if [ "$netif" = "$slave" ] ; then
-            netif=$bondname
-        fi
-    done
-fi
-
-# bridge this interface?
-if [ -e /tmp/bridge.info ]; then
-    . /tmp/bridge.info
-    if [ "$netif" = "$ethname" ]; then
-        if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
-            : # We need to really setup bond (recursive call)
-        else
-            netif="$bridgename"
-        fi
+    if [ -n "$manualup" ]; then
+        /sbin/netroot $netif -m
+    else
+        initqueue --onetime --name netroot-$netif netroot $netif
     fi
-fi
-
-# bail immediately if the interface is already up
-# or we don't need the network
-[ -f "/tmp/net.$netif.up" ] && exit 0
-[ -f "/tmp/root.info" ] || exit 0
-. /tmp/root.info
-[ -z "$netroot" ] && exit 0
+}
 
 # loopback is always handled the same way
 if [ "$netif" = "lo" ] ; then
@@ -228,5 +242,4 @@ for p in $(getargs ip=); do
     esac
     break
 done
-
 exit 0
Index: dracut/modules.d/40network/netroot
===================================================================
--- dracut.orig/modules.d/40network/netroot
+++ dracut/modules.d/40network/netroot
@@ -3,7 +3,6 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 PATH=/usr/sbin:/usr/bin:/sbin:/bin
-
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 
 # Huh? Empty $1?
@@ -12,12 +11,16 @@ type getarg >/dev/null 2>&1 || . /lib/dr
 # Huh? No interface config?
 [ ! -e /tmp/net.$1.up ] && exit 1
 
-# There's no sense in doing something if no (net)root info is available
+# [ ! -z $2 ] means this is for manually bringing up network
+# instead of real netroot; If It's called without $2, then there's
+# no sense in doing something if no (net)root info is available
 # or root is already there
 [ -e /tmp/root.info ] || exit 1
 . /tmp/root.info
-[ -d $NEWROOT/proc ] && exit 0
-[ -z "$netroot" ] && exit 1
+if [ -z "$2" ]; then
+    [ -d $NEWROOT/proc ] && exit 0
+    [ -z "$netroot" ] && exit 1
+fi
 
 # Let's see if we have to wait for other interfaces
 # Note: exit works just fine, since the last interface to be
@@ -31,43 +34,49 @@ done
 netif=$1
 [ -e "/tmp/net.bootdev" ] && read netif < /tmp/net.bootdev
 
+if [ -e /tmp/net.$netif.manualup ]; then
+    rm -f /tmp/net.$netif.manualup
+fi
+
 # Figure out the handler for root=dhcp by recalling all netroot cmdline
-# handlers
-if [ "$netroot" = "dhcp" ] || [ "$netroot" = "dhcp6" ] ; then
-    # Unset root so we can check later
-    unset root
-
-    # Load dhcp options
-    [ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
-
-    # If we have a specific bootdev with no dhcpoptions or empty root-path,
-    # we die. Otherwise we just warn
-    if [ -z "$new_root_path" ] ; then
-        [ -n "$BOOTDEV" ] && die "No dhcp root-path received for '$BOOTDEV'"
-        warn "No dhcp root-path received for '$BOOTDEV' trying other interfaces if available"
-        exit 1
-    fi
+# handlers when this is not called from manually network bringing up.
+if [ -z "$2" ]; then
+    if [ "$netroot" = "dhcp" ] || [ "$netroot" = "dhcp6" ] ; then
+        # Unset root so we can check later
+        unset root
+
+        # Load dhcp options
+        [ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
+
+        # If we have a specific bootdev with no dhcpoptions or empty root-path,
+        # we die. Otherwise we just warn
+        if [ -z "$new_root_path" ] ; then
+            [ -n "$BOOTDEV" ] && die "No dhcp root-path received for '$BOOTDEV'"
+            warn "No dhcp root-path received for '$BOOTDEV' trying other interfaces if available"
+            exit 1
+        fi
 
-    # Set netroot to new_root_path, so cmdline parsers don't call
-    netroot=$new_root_path
+        # Set netroot to new_root_path, so cmdline parsers don't call
+        netroot=$new_root_path
 
-    # FIXME!
-    for f in $hookdir/cmdline/90*.sh; do
-        [ -f "$f" ] && . "$f";
-    done
-else
-    rootok="1"
-fi
+        # FIXME!
+        for f in $hookdir/cmdline/90*.sh; do
+            [ -f "$f" ] && . "$f";
+        done
+    else
+        rootok="1"
+    fi
 
-# Check: do we really know how to handle (net)root?
-[ -z "$root" ] && die "No or empty root= argument"
-[ -z "$rootok" ] && die "Don't know how to handle 'root=$root'"
-
-handler=${netroot%%:*}
-handler=${handler%%4}
-handler=$(command -v ${handler}root)
-if [ -z "$netroot" ] || [ ! -e "$handler" ] ; then
-    die "No handler for netroot type '$netroot'"
+    # Check: do we really know how to handle (net)root?
+    [ -z "$root" ] && die "No or empty root= argument"
+    [ -z "$rootok" ] && die "Don't know how to handle 'root=$root'"
+
+    handler=${netroot%%:*}
+    handler=${handler%%4}
+    handler=$(command -v ${handler}root)
+    if [ -z "$netroot" ] || [ ! -e "$handler" ] ; then
+        die "No handler for netroot type '$netroot'"
+    fi
 fi
 
 # We're here, so we can assume that upping interfaces is now ok
@@ -122,6 +131,9 @@ if [ -n "$dest" ] && ! arping -q -f -w 6
     dinfo "Resolving $dest via ARP on $netif failed"
 fi
 
+# exit in case manually bring up network
+[ -n "$2" ] && exit 0
+
 # Source netroot hooks before we start the handler
 source_all $hookdir/netroot
 
