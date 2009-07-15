From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 04/14] dmraid.rules changed comment in header
Date: Wed, 15 Jul 2009 18:50:36 +0200
Message-ID: <1247676646-3837-5-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/90dmraid/61-dmraid-imsm.rules |    4 ++--
 modules.d/90dmraid/61-dmraid.rules      |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/modules.d/90dmraid/61-dmraid-imsm.rules b/modules.d/90dmraid/61-dmraid-imsm.rules
index e06ea3f..3b3eb7f 100644
--- a/modules.d/90dmraid/61-dmraid-imsm.rules
+++ b/modules.d/90dmraid/61-dmraid-imsm.rules
@@ -1,5 +1,5 @@
-# This file causes block devices with Linux RAID (mdadm) signatures to
-# automatically cause mdadm to be run.
+# This file causes block devices with RAID (dmraid) signatures to
+# automatically cause dmraid to be run.
 # See udev(8) for syntax
 
 SUBSYSTEM!="block", GOTO="dm_end"
diff --git a/modules.d/90dmraid/61-dmraid.rules b/modules.d/90dmraid/61-dmraid.rules
index e8e9d65..c4c1717 100644
--- a/modules.d/90dmraid/61-dmraid.rules
+++ b/modules.d/90dmraid/61-dmraid.rules
@@ -1,5 +1,5 @@
-# This file causes block devices with Linux RAID (mdadm) signatures to
-# automatically cause mdadm to be run.
+# This file causes block devices with RAID (dmraid) signatures to
+# automatically cause dmraid to be run.
 # See udev(8) for syntax
 
 SUBSYSTEM!="block", GOTO="dm_end"
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
