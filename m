From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 3/8] Get rid of hostname utility
Date: Thu, 17 Sep 2009 17:16:44 +0200
Message-ID: <1253200609-31629-4-git-send-email-philippe.seewer@bfh.ch>
References: <1253200609-31629-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1253200609-31629-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

dracut doesn't really need a utility to set the hostname. It only
saves a few ks of space, but every bit is good.
---
 modules.d/40network/check           |    2 +-
 modules.d/40network/dhclient-script |    2 +-
 modules.d/40network/ifup            |    2 +-
 modules.d/40network/install         |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/modules.d/40network/check b/modules.d/40network/check
index f2b137c..cf06c74 100755
--- a/modules.d/40network/check
+++ b/modules.d/40network/check
@@ -2,7 +2,7 @@
 
 . $dracutfunctions
 
-for program in ip hostname; do 
+for program in ip; do 
   which $program >/dev/null 2>&1
   if [ $? -ne 0 ]; then
     dwarning "Could not find program \"$program\" required by network." 
diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index e3da4ea..013c8f1 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -38,7 +38,7 @@ setup_interface() {
 	done
     fi >> /tmp/resolv.conf
 
-    [ -n "$hostname" ] && echo hostname $hostname > /tmp/net.$netif.hostname
+    [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
 }
 
 PATH=$PATH:/sbin:/usr/sbin
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index ce39dcd..25cab26 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -40,7 +40,7 @@ do_static() {
     } > /tmp/net.$netif.up
 
     [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
-    [ -n "$hostname" ] && echo hostname $hostname > /tmp/net.$netif.hostname
+    [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
 
     echo online > /sys/class/net/$netif/uevent
 }
diff --git a/modules.d/40network/install b/modules.d/40network/install
index ded70da..a711cb5 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -1,5 +1,5 @@
 #!/bin/bash
-dracut_install ip dhclient hostname brctl
+dracut_install ip dhclient brctl
 inst "$moddir/ifup" "/sbin/ifup"
 inst "$moddir/netroot" "/sbin/netroot"
 inst "$moddir/dhclient-script" "/sbin/dhclient-script"
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
