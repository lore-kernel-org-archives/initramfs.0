From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/7] 95rootfs-block: fix left fsck rel. checks
Date: Thu, 26 Jul 2012 15:05:21 +0200
Message-ID: <1343307927-17079-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/95rootfs-block/mount-root.sh |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index 670f6e3..ef8ca3c 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -52,11 +52,11 @@ mount_root() {
         fastboot=yes
     fi
 
-    if [ -f "$NEWROOT"/fsckoptions ]; then
-        fsckoptions=$(cat "$NEWROOT"/fsckoptions)
-    fi
-
     if ! getargbool 0 rd.skipfsck; then
+        if [ -f "$NEWROOT"/fsckoptions ]; then
+            fsckoptions=$(cat "$NEWROOT"/fsckoptions)
+        fi
+
         if [ -f "$NEWROOT"/forcefsck ] || getargbool 0 forcefsck ; then
             fsckoptions="-f $fsckoptions"
         elif [ -f "$NEWROOT"/.autofsck ]; then
@@ -130,8 +130,10 @@ mount_root() {
         mount -o remount "$NEWROOT" 2>&1 | vinfo
     fi
 
-    [ -f "$NEWROOT"/forcefsck ] && rm -f "$NEWROOT"/forcefsck 2>/dev/null
-    [ -f "$NEWROOT"/.autofsck ] && rm -f "$NEWROOT"/.autofsck 2>/dev/null
+    if ! getargbool 0 rd.skipfsck; then
+        [ -f "$NEWROOT"/forcefsck ] && rm -f "$NEWROOT"/forcefsck 2>/dev/null
+        [ -f "$NEWROOT"/.autofsck ] && rm -f "$NEWROOT"/.autofsck 2>/dev/null
+    fi
 }
 
 if [ -n "$root" -a -z "${root%%block:*}" ]; then
-- 
1.7.8.6
