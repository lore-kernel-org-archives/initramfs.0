From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: [PATCH] dracut-initramfs-restore,lsinitrd: add LZ4 support
Date: Thu, 16 Jan 2014 09:20:17 +0100
Message-ID: <1389860417-5000-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>

Dracut claims to have LZ4 support, but trying to use it will result in an xzcat failure at the end due to missing CAT support.

Something similar will need to be done for LZO.

Signed-off-by: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
---
 dracut-initramfs-restore.sh | 2 ++
 lsinitrd.sh                 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/dracut-initramfs-restore.sh b/dracut-initramfs-restore.sh
index ec5fe18..f29c814 100644
--- a/dracut-initramfs-restore.sh
+++ b/dracut-initramfs-restore.sh
@@ -20,6 +20,8 @@ if zcat "$IMG"  | cpio -id --quiet >/dev/null; then
     rm -f -- .need_shutdown
 elif xzcat "$IMG"  | cpio -id --quiet >/dev/null; then
     rm -f -- .need_shutdown
+elif lz4 -d -c "$IMG"  | cpio -id --quiet >/dev/null; then
+    rm -f -- .need_shutdown
 else
     # something failed, so we clean up
     echo "Unpacking of $IMG to /run/initramfs failed" >&2
diff --git a/lsinitrd.sh b/lsinitrd.sh
index 584c29a..20d5a8b 100755
--- a/lsinitrd.sh
+++ b/lsinitrd.sh
@@ -111,6 +111,8 @@ case $bin in
         CAT="bzcat";;
     $'\x71\xc7'*|070701)
         CAT="cat";;
+    $'\x04\x22'*)
+        CAT="lz4 -d -c";;
     *)
         CAT="xzcat";
         if echo "test"|xz|xzcat --single-stream >/dev/null 2>&1; then
-- 
1.8.4.2
