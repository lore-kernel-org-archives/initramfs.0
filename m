From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 2/4] 95rootfs-block/mount-root.sh: '-a' for ext? is handled in fs-lib now
Date: Thu,  2 Jun 2011 23:22:13 +0200
Message-ID: <1307049735-2345-3-git-send-email-soltys@ziu.info>
References: <1307049735-2345-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1307049735-2345-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Previously, '-a' was added for ext[234] filesystems if other
conflicting flag were not present. It's being done automatically
in fsck_drv_com() now (also for jfs and reiser).
---
 modules.d/95rootfs-block/mount-root.sh |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index 67763cf..440f1b7 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -70,10 +70,6 @@ mount_root() {
         fsckoptions="$AUTOFSCK_OPT $fsckoptions"
     fi
 
-    if ! strstr " $fsckoptions" " -y" && strstr "$rootfs" ext; then
-        fsckoptions="-a $fsckoptions"
-    fi
-
     rootopts=
     if getargbool 1 rd.fstab -n rd_NO_FSTAB \
         && ! getarg rootflags \
-- 
1.7.5.2
