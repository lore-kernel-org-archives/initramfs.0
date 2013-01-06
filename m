From: dave-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org (Dave Young)
Subject: [PATCH] use linkup in dhclient-script.sh
Date: Sun, 06 Jan 2013 14:17:54 +0800
Message-ID: <20130106061754.A96B664097@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


linkup is a wrapper function for waiting interface ready and up.
change to use linkup as what we do in ifup script.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/dhclient-script.sh |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- dracut.orig/modules.d/40network/dhclient-script.sh
+++ dracut/modules.d/40network/dhclient-script.sh
@@ -25,8 +25,7 @@ setup_interface() {
         if ! ip link set $netif mtu $mtu ; then
             ip link set $netif down
             ip link set $netif mtu $mtu
-            ip link set $netif up
-            wait_for_if_up $netif
+            linkup $netif
         fi
     fi
 
@@ -62,8 +61,7 @@ netif=$interface
 case $reason in
     PREINIT)
         echo "dhcp: PREINIT $netif up"
-        ip link set $netif up
-        wait_for_if_up $netif
+        linkup $netif
         ;;
     BOUND)
         echo "dhcp: BOND setting $netif"
