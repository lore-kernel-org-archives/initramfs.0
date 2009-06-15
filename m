From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Don't start mdmon if it isn't installed
Date: Mon, 15 Jun 2009 23:44:50 +0200
Message-ID: <4A36C0D2.6070406@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

diff --git a/modules.d/90mdraid/mdmon-pre-pivot.sh b/modules.d/90mdraid/mdmon-pre-pivot.sh
index b1f379f..db5a210 100644
--- a/modules.d/90mdraid/mdmon-pre-pivot.sh
+++ b/modules.d/90mdraid/mdmon-pre-pivot.sh
@@ -1,3 +1,3 @@
 # switch any mdmon instances to newroot
-[ -f /etc/mdadm.conf ] && /sbin/mdmon /proc/mdstat $NEWROOT
+[ -f /etc/mdadm.conf ] && [ -x /sbin/mdmon ] && /sbin/mdmon /proc/mdstat $NEWROOT
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
