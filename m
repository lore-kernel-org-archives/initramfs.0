From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 3/4] new option: rd.skipfsck to skip fsck for rootfs and /usr
Date: Fri, 29 Jun 2012 13:58:20 +0200
Message-ID: <1340971101-1729-3-git-send-email-aidecoe@aidecoe.name>
References: <1340971101-1729-1-git-send-email-aidecoe@aidecoe.name>
 <1340971101-1729-2-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340971101-1729-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.cmdline.7.asc                   |    4 ++++
 modules.d/95rootfs-block/mount-root.sh |    4 +++-
 modules.d/98usrmount/mount-usr.sh      |   15 ++++++++-------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 5669700..3bfb53a 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -75,6 +75,10 @@ resume=/dev/disk/by-uuid/3f5ad593-4546-4a94-a374-bcfb68aa11f7
 resume=UUID=3f5ad593-4546-4a94-a374-bcfb68aa11f7
 ----
 
+**rd.skipfsck**::
+    skip fsck for rootfs and _/usr_.  If you're mounting _/usr_ read-only and
+    the init system performs fsck before remount, you might want to use this
+    option to avoid duplication.
 
 **rd.usrmount.ro**:
     force mounting _/usr_ read-only.  Use this option if your init system
diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index 2cae526..9109638 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -103,7 +103,9 @@ mount_root() {
     # printf '%s %s %s %s 1 1 \n' "$esc_root" "$NEWROOT" "$rootfs" "$rflags" >/etc/fstab
 
     ran_fsck=0
-    if [ -z "$fastboot" -a "$READONLY" != "yes" ] && ! strstr "${rflags},${rootopts}" _netdev; then
+    if [ -z "$fastboot" -a "$READONLY" != "yes" ] && \
+            ! strstr "${rflags},${rootopts}" _netdev && \
+            ! getargbool 0 rd.skipfsck; then
         umount "$NEWROOT"
         fsck_single "${root#block:}" "$rootfs" "$rflags" "$fsckoptions"
         _ret=$?
diff --git a/modules.d/98usrmount/mount-usr.sh b/modules.d/98usrmount/mount-usr.sh
index 748ac01..5798777 100755
--- a/modules.d/98usrmount/mount-usr.sh
+++ b/modules.d/98usrmount/mount-usr.sh
@@ -60,14 +60,15 @@ mount_usr()
 
     if [ "x$_usr_found" != "x" ]; then
         # we have to mount /usr
-        if [ "0" != "${_passno:-0}" ]; then
-            fsck_usr "$_dev" "$_fs" "$_opts"
-        else
-            :
+        _fsck_ret=0
+        if ! getargbool 0 rd.skipfsck; then
+            if [ "0" != "${_passno:-0}" ]; then
+                fsck_usr "$_dev" "$_fs" "$_opts"
+                _fsck_ret=$?
+                echo $_fsck_ret >/run/initramfs/usr-fsck
+            fi
         fi
-        _ret=$?
-        echo $_ret >/run/initramfs/usr-fsck
-        if [ $_ret -ne 255 ]; then
+        if [ $_fsck_ret -ne 255 ]; then
             if getargbool 0 rd.usrmount.ro; then
                 info "Mounting /usr (read-only forced)"
                 mount -r "$NEWROOT/usr" 2>&1 | vinfo
-- 
1.7.8.6
