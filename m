From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] allow ifup bring up network mannually even without netroot
Date: Thu, 29 Dec 2011 11:13:42 +0800
Message-ID: <20111229031342.GA6829@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

sometimes we need bring up network even without netroot

Here implement this by adding one param to ifup script, user can use:
/sbin/ifup $netif -m; to bring up eth0, note currently ifup will see
anything in param $2 as same.

`ifup eth0 -m` will create /tmp/net.eth0.mannual stamp file,
later dhclient-script can check this and pass $2 to netroot,
then netroot script will bring eth0 up

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/dhclient-script |    7 ++
 modules.d/40network/ifup            |   17 +++++--
 modules.d/40network/netroot         |   85 +++++++++++++++++++-----------------
 3 files changed, 67 insertions(+), 42 deletions(-)

Index: dracut/modules.d/40network/dhclient-script
===================================================================
--- dracut.orig/modules.d/40network/dhclient-script
+++ dracut/modules.d/40network/dhclient-script
@@ -74,7 +74,12 @@ case $reason in
             echo "$line"
         done >/tmp/dhclient.$netif.dhcpopts
         echo online > /sys/class/net/$netif/uevent
-        initqueue --onetime --name netroot-$netif netroot $netif
+        if [ -e /tmp/net.$netif.mannual ]; then
+            /sbin/netroot $netif -m
+            rm -f /tmp/net.$netif.mannual
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
@@ -5,6 +5,8 @@
 # We don't need to check for ip= errors here, that is handled by the
 # cmdline parser script
 #
+# without $2 means this is for real netroot case
+# or it is for mannually bring up network ie. for kdump scp vmcore
 PATH=/usr/sbin:/usr/bin:/sbin:/bin
 
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
@@ -50,7 +52,11 @@ do_ipv6auto() {
 
 
     echo online > /sys/class/net/$netif/uevent
-    initqueue --onetime --name netroot-$netif netroot $netif
+    if [ -z "$2" ]; then
+        initqueue --onetime --name netroot-$netif netroot $netif
+    else
+        /sbin/netroot $netif -m
+    fi
 }
 
 # Handle static ip configuration
@@ -77,7 +83,11 @@ do_static() {
     fi >> /tmp/net.$netif.resolv.conf
 
     echo online > /sys/class/net/$netif/uevent
-    initqueue --onetime --name netroot-$netif netroot $netif
+    if [ -z "$2" ]; then
+        initqueue --onetime --name netroot-$netif netroot $netif
+    else
+        /sbin/netroot $netif -m
+    fi
 }
 
 export PS4="ifup.$1.$$ + "
@@ -117,7 +127,8 @@ fi
 [ -f "/tmp/net.$netif.up" ] && exit 0
 [ -f "/tmp/root.info" ] || exit 0
 . /tmp/root.info
-[ -z "$netroot" ] && exit 0
+[ -z "$netroot" ] && [ -z $2 ] && exit 0
+[ -n "$2" ] && >/tmp/net.$netif.mannual
 
 # loopback is always handled the same way
 if [ "$netif" = "lo" ] ; then
Index: dracut/modules.d/40network/netroot
===================================================================
--- dracut.orig/modules.d/40network/netroot
+++ dracut/modules.d/40network/netroot
@@ -12,12 +12,16 @@ type getarg >/dev/null 2>&1 || . /lib/dr
 # Huh? No interface config?
 [ ! -e /tmp/net.$1.up ] && exit 1
 
-# There's no sense in doing something if no (net)root info is available
+# [ ! -z $2 ] means this is for mannually bringing up network
+# instead of real netroot; If It's called without $2, then there's
+# no sense in doing something if no (net)root info is available
 # or root is already there
-[ -e /tmp/root.info ] || exit 1
-. /tmp/root.info
-[ -d $NEWROOT/proc ] && exit 0
-[ -z "$netroot" ] && exit 1
+if [ -z "$2" ]; then
+    [ -e /tmp/root.info ] || exit 1
+    . /tmp/root.info
+    [ -d $NEWROOT/proc ] && exit 0
+    [ -z "$netroot" ] && exit 1
+fi
 
 # Let's see if we have to wait for other interfaces
 # Note: exit works just fine, since the last interface to be
@@ -32,42 +36,44 @@ netif=$1
 [ -e "/tmp/net.bootdev" ] && read netif < /tmp/net.bootdev
 
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
+# handlers when this is not called from mannually network bringing up.
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
@@ -122,6 +128,9 @@ if [ -n "$dest" ] && ! arping -q -f -w 6
     dinfo "Resolving $dest via ARP on $netif failed"
 fi
 
+# exit in case mannually bring up network
+[ -n $2 ] && exit 0
+
 # Source netroot hooks before we start the handler
 source_all netroot
 
