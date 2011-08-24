From: Boris Ratner <borisr-RKikMA1kHthWuorn6qtVew@public.gmane.org>
Subject: [PATCH] [RHEL-6] makes sure you can have ip address during init without defining netroot in kernel command line
Date: Wed, 24 Aug 2011 08:48:06 -0400 (EDT)
Message-ID: <a1c000a3-7bc7-44c1-9593-287107022a94@zim.netvertise.co.il>
References: <fc72d649-34e6-43a0-8d7a-65eec4a3b992@zim.netvertise.co.il>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fc72d649-34e6-43a0-8d7a-65eec4a3b992-+zCMylJcUAOCJtFe2Q0uNQMMGMOHi2eC@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From 5c6e3c4ce739926385b7160a832c5103242b5755 Mon Sep 17 00:00:00 2001
From: Boris Ratner <ratner2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 24 Aug 2011 15:40:28 +0300
Subject: [PATCH] makes sure you can have ip address during init without defining netroot in kernel command line

---
 modules.d/40network/ifup             |    3 +-
 modules.d/40network/net-genrules.sh  |    2 -
 modules.d/40network/netroot          |   52 ++++++++++++++++++---------------
 modules.d/40network/parse-bridge.sh  |    6 +--
 modules.d/40network/parse-ip-opts.sh |   17 +++--------
 5 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index ebdaa3c..c182ed4 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -84,7 +84,7 @@ export PS4="ifup.$1.$$ + "
 exec >>/dev/initlog.pipe 2>>/dev/initlog.pipe
 . /lib/dracut-lib.sh
 
-# Huh? No $1?
+# Huh? No $1? interface name (like eth0 )
 [ -z "$1" ] && exit 1
 
 # $netif reads easier than $1
@@ -103,7 +103,6 @@ fi
 [ -f "/tmp/net.$netif.up" ] && exit 0
 [ -f "/tmp/root.info" ] || exit 0
 . /tmp/root.info
-[ -z "$netroot" ] && exit 0
 
 # loopback is always handled the same way
 if [ "$netif" = "lo" ] ; then
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 1d6d604..c35ee53 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -13,8 +13,6 @@ fix_bootif() {
     echo $macaddr
 }
 
-# Don't continue if we don't need network
-[ -z "$netroot" ] && return;
 
 # Write udev rules
 {
diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 6a24d41..20a3045 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -15,7 +15,7 @@ PATH=$PATH:/sbin:/usr/sbin
 [ -e /tmp/root.info ] || exit 1
 . /tmp/root.info
 [ -d $NEWROOT/proc ] && exit 0
-[ -z "$netroot" ] && exit 1
+#[ -z "$netroot" ] && exit 1
 
 # Let's see if we have to wait for other interfaces
 # Note: exit works just fine, since the last interface to be 
@@ -60,11 +60,13 @@ fi
 [ -z "$root" ] && die "No or empty root= argument"
 [ -z "$rootok" ] && die "Don't know how to handle 'root=$root'"
 
-handler=${netroot%%:*}
-handler=${handler%%4}
-handler="/sbin/${handler}root"
-if [ -z "$netroot" ] || [ ! -e "$handler" ] ; then
-    die "No handler for netroot type '$netroot'"
+if [ ! -z $netroot ] ; then
+    handler=${netroot%%:*}
+    handler=${handler%%4}
+    handler="/sbin/${handler}root"
+    if [ -z "$netroot" ] || [ ! -e "$handler" ] ; then
+        die "No handler for netroot type '$netroot'"
+    fi
 fi
 
 # We're here, so we can assume that upping interfaces is now ok
@@ -101,27 +103,29 @@ if [ -n "$dest" ] && ! arping -q -f -w 60 -I $netif $dest ; then
 fi
 
 # Source netroot hooks before we start the handler
-source_all netroot
+[ ! -z $netroot ] && source_all netroot
 
 # Run the handler; don't store the root, it may change from device to device
 # XXX other variables to export?
-if $handler $netif $netroot $NEWROOT; then
-    # Network rootfs mount successful
-    for iface in $IFACES ; do
-	[ -f /tmp/dhclient.$iface.lease ] &&    cp /tmp/dhclient.$iface.lease    /tmp/net.$iface.lease
-	[ -f /tmp/dhclient.$iface.dhcpopts ] && cp /tmp/dhclient.$iface.dhcpopts /tmp/net.$iface.dhcpopts
-    done
-
-    # Save used netif for later use
-    [ ! -f /tmp/net.ifaces ] && echo $netif > /tmp/net.ifaces
-else 
-    warn "Mounting root via '$netif' failed"
-    # If we're trying with multiple interfaces, put that one down.
-    # ip down/flush ensures that routeing info goes away as well
-    if [ -z "$BOOTDEV" ] ; then
-	ip link set $netif down
-	ip addr flush dev $netif
-	echo "#empty" > /etc/resolv.conf
+if [ ! -z $netroot ] ; then
+    if $handler $netif $netroot $NEWROOT; then
+        # Network rootfs mount successful
+        for iface in $IFACES ; do
+            [ -f /tmp/dhclient.$iface.lease ] &&    cp /tmp/dhclient.$iface.lease    /tmp/net.$iface.lease
+            [ -f /tmp/dhclient.$iface.dhcpopts ] && cp /tmp/dhclient.$iface.dhcpopts /tmp/net.$iface.dhcpopts
+        done
+
+        # Save used netif for later use
+        [ ! -f /tmp/net.ifaces ] && echo $netif > /tmp/net.ifaces
+    else 
+        warn "Mounting root via '$netif' failed"
+        # If we're trying with multiple interfaces, put that one down.
+        # ip down/flush ensures that routeing info goes away as well
+        if [ -z "$BOOTDEV" ] ; then
+            ip link set $netif down
+            ip addr flush dev $netif
+            echo "#empty" > /etc/resolv.conf
+        fi
     fi
 fi
 exit 0
diff --git a/modules.d/40network/parse-bridge.sh b/modules.d/40network/parse-bridge.sh
index 218485a..6d48b94 100755
--- a/modules.d/40network/parse-bridge.sh
+++ b/modules.d/40network/parse-bridge.sh
@@ -10,10 +10,8 @@
 [ -n "$bridgename" ] && return
 
 # Check if bridge parameter is valid 
-if getarg bridge= >/dev/null ; then
-    if [ -z "$netroot" ] ; then
-	die "No netboot configured, bridge is invalid"
-    fi
+if ! getarg bridge= >/dev/null ; then
+    return
 fi
 
 parsebridge() {
diff --git a/modules.d/40network/parse-ip-opts.sh b/modules.d/40network/parse-ip-opts.sh
index 9f6d9f3..621179c 100755
--- a/modules.d/40network/parse-ip-opts.sh
+++ b/modules.d/40network/parse-ip-opts.sh
@@ -16,13 +16,6 @@
 
 . /lib/dracut-lib.sh
 
-# Check if ip= lines should be used
-if getarg ip= >/dev/null ; then
-    if [ -z "$netroot" ] ; then
-	echo "Warning: No netboot configured, ignoring ip= lines"
-	return;
-    fi
-fi
 
 # Don't mix BOOTIF=macaddr from pxelinux and ip= lines
 getarg ip= >/dev/null && getarg BOOTIF= >/dev/null && \
@@ -102,10 +95,10 @@ for p in $(getargs ip=); do
     # We need to have an ip= line for the specified bootdev
     [ -n "$NEEDBOOTDEV" ] && [ "$dev" = "$BOOTDEV" ] && BOOTDEVOK=1
 
-    # Empty autoconf defaults to 'dhcp'
+    # Empty autoconf defaults to none for static ips
     if [ -z "$autoconf" ] ; then
-	warn "Empty autoconf values default to dhcp"
-	autoconf="dhcp"
+	warn "Empty autoconf values default to none"
+	autoconf="none"
     fi
 
     # Error checking for autoconf in combination with other values
@@ -139,8 +132,8 @@ for p in $(getargs ip=); do
 	IFACES="$IFACES $dev"
     fi
 
-    # Small optimization for udev rules
-    [ -z "$NEEDBOOTDEV" ] && [ -n "$dev" ] && BOOTDEV=$dev
+    # Small optimization for udev rules.
+    [ -z "$NEEDBOOTDEV" ] && [ -n "$dev" ] && [ ! -z "$netroot" ] && BOOTDEV=$dev
 
     # Do we need to check for specific options?
     if [ -n "$NEEDDHCP" ] || [ -n "$DHCPORSERVER" ] ; then
-- 
1.7.4.1
