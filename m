From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 3/6 v3] Change to use linkup function in network scripts
Date: Wed, 12 Dec 2012 12:23:23 +0800
Message-ID: <20121212042613.676262712@redhat.com>
References: <20121212042320.618863612@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=patch3
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Update ifup.sh and fcoe-up.sh, use linkup function instead of directly
call ip command.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/ifup.sh |   17 ++++++-----------
 modules.d/95fcoe/fcoe-up.sh |    3 +--
 2 files changed, 7 insertions(+), 13 deletions(-)

--- dracut.orig/modules.d/40network/ifup.sh
+++ dracut/modules.d/40network/ifup.sh
@@ -84,8 +84,7 @@ do_ipv6auto() {
     echo 0 > /proc/sys/net/ipv6/conf/$netif/forwarding
     echo 1 > /proc/sys/net/ipv6/conf/$netif/accept_ra
     echo 1 > /proc/sys/net/ipv6/conf/$netif/accept_redirects
-    ip link set $netif up
-    wait_for_if_up $netif
+    linkup $netif
 
     [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
 
@@ -96,8 +95,7 @@ do_ipv6auto() {
 do_static() {
     strstr $ip '*:*:*' && load_ipv6
 
-    ip link set dev $netif up
-    wait_for_if_up $netif
+    linkup $netif
     [ -n "$macaddr" ] && ip link set address $macaddr dev $netif
     [ -n "$mtu" ] && ip link set mtu $mtu dev $netif
     if strstr $ip '*:*:*'; then
@@ -147,13 +145,12 @@ if [ -e /tmp/bond.info ]; then
             fi
         done
 
-        ip link set $netif up
+        linkup $netif
 
         for slave in $bondslaves ; do
             ip link set $slave down
             echo "+$slave" > /sys/class/net/$bondname/bonding/slaves
-            ip link set $slave up
-            wait_for_if_up $slave
+            linkup $slave
         done
 
         # add the bits to setup the needed post enslavement parameters
@@ -180,9 +177,8 @@ if [ -e /tmp/bridge.info ]; then
             if [ "$ethname" = "$bondname" ] ; then
                 DO_BOND_SETUP=yes ifup $bondname -m
             else
-                ip link set $ethname up
+                linkup $ethname
             fi
-            wait_for_if_up $ethname
             brctl addif $bridgename $ethname
         done
     fi
@@ -204,9 +200,8 @@ if [ "$netif" = "$vlanname" ] && [ ! -e 
     if [ "$phydevice" = "$bondname" ] ; then
         DO_BOND_SETUP=yes ifup $phydevice -m
     else
-        ip link set "$phydevice" up
+        linkup "$phydevice"
     fi
-    wait_for_if_up "$phydevice"
     ip link add dev "$vlanname" link "$phydevice" type vlan id "$(get_vid $vlanname; echo $?)"
 fi
 
--- dracut.orig/modules.d/95fcoe/fcoe-up.sh
+++ dracut/modules.d/95fcoe/fcoe-up.sh
@@ -21,8 +21,7 @@ type ip_to_var >/dev/null 2>&1 || . /lib
 netif=$1
 dcb=$2
 
-ip link set "$netif" up
-wait_for_if_up "$netif"
+linkup "$netif"
 
 netdriver=$(readlink -f /sys/class/net/$netif/device/driver)
 netdriver=${netdriver##*/}
