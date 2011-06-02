From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 4/4] 95rootfs-block/mount-root.sh: comment out fstab generation
Date: Thu,  2 Jun 2011 23:22:15 +0200
Message-ID: <1307049735-2345-5-git-send-email-soltys@ziu.info>
References: <1307049735-2345-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1307049735-2345-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

fsck_single() operates directly on the device, so fstab is not
necessary. fs-lib functions make sure fscks don't complain.
Code is only commented out just in case I missed something.
---
 modules.d/95rootfs-block/mount-root.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index 3a43a66..cc243d7 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -101,8 +101,8 @@ mount_root() {
     umount "$NEWROOT"
 
     # backslashes are treated as escape character in fstab
-    esc_root=$(echo ${root#block:} | sed 's,\\,\\\\,g')
-    printf '%s %s %s %s 1 1 \n' "$esc_root" "$NEWROOT" "$rootfs" "$rflags" >/etc/fstab
+    # esc_root=$(echo ${root#block:} | sed 's,\\,\\\\,g')
+    # printf '%s %s %s %s 1 1 \n' "$esc_root" "$NEWROOT" "$rootfs" "$rflags" >/etc/fstab
 
     if [ -z "$fastboot" -a "$READONLY" != "yes" ] && ! strstr "${rflags}" _netdev; then
         fsck_single "${root#block:}" "$rootfs" "$fsckoptions"
-- 
1.7.5.2
