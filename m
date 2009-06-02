From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] fixed fstype mount options
Date: Tue,  2 Jun 2009 13:43:10 +0200
Message-ID: <1243942990-5587-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/95rootfs-block/mount-root.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index a5741d1..a691ae3 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 if [ ! -s /.resume -a -n "$root" -a -z "${root%%block:*}" ]; then
-    mount ${fstype:--t auto} -o "$rflags" "${root#block:}" "$NEWROOT" && ROOTFS_MOUNTED=yes
+    mount -t ${fstype:-auto} -o "$rflags" "${root#block:}" "$NEWROOT" && ROOTFS_MOUNTED=yes
 fi
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
