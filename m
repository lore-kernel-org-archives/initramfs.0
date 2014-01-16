From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: [PATCHv2] dracut-initramfs-restore,lsinitrd: add LZ4 support
Date: Thu, 16 Jan 2014 11:00:54 +0100
Message-ID: <1389866454-28426-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>

Dracut claims to have LZ4 support, but trying to use it will result in an xzcat failure at the end due to missing CAT support.

The lz4 command chokes on '--', so abstract that out into the CAT select.

Something similar will need to be done for LZO.

Signed-off-by: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
---
 dracut-initramfs-restore.sh |  2 ++
 lsinitrd.sh                 | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

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
index 584c29a..f9f243b 100755
--- a/lsinitrd.sh
+++ b/lsinitrd.sh
@@ -106,15 +106,17 @@ fi
 read -N 6 bin < "$image"
 case $bin in
     $'\x1f\x8b'*)
-        CAT="zcat";;
+        CAT="zcat --";;
     BZh*)
-        CAT="bzcat";;
+        CAT="bzcat --";;
     $'\x71\xc7'*|070701)
-        CAT="cat";;
+        CAT="cat --";;
+    $'\x04\x22'*)
+        CAT="lz4 -d -c";;
     *)
-        CAT="xzcat";
+        CAT="xzcat --";
         if echo "test"|xz|xzcat --single-stream >/dev/null 2>&1; then
-            CAT="xzcat --single-stream"
+            CAT="xzcat --single-stream --"
         fi
         ;;
 esac
@@ -126,7 +128,7 @@ if (( ${#filenames[@]} > 0 )); then
     for f in ${!filenames[@]}; do
         [[ $nofileinfo ]] || echo "initramfs:/$f"
         [[ $nofileinfo ]] || echo "========================================================================"
-        $CAT -- $image | cpio --extract --verbose --quiet --to-stdout $f 2>/dev/null
+        $CAT $image | cpio --extract --verbose --quiet --to-stdout $f 2>/dev/null
         ((ret+=$?))
         [[ $nofileinfo ]] || echo "========================================================================"
         [[ $nofileinfo ]] || echo
@@ -134,16 +136,16 @@ if (( ${#filenames[@]} > 0 )); then
 else
     echo "Image: $image: $(du -h $image | while read a b; do echo $a;done)"
     echo "========================================================================"
-    version=$($CAT -- "$image" | cpio --extract --verbose --quiet --to-stdout -- '*lib/dracut/dracut-*' 2>/dev/null)
+    version=$($CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- '*lib/dracut/dracut-*' 2>/dev/null)
     ((ret+=$?))
     echo "$version with dracut modules:"
-    $CAT -- "$image" | cpio --extract --verbose --quiet --to-stdout -- '*lib/dracut/modules.txt' 2>/dev/null
+    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- '*lib/dracut/modules.txt' 2>/dev/null
     ((ret+=$?))
     echo "========================================================================"
     if [ "$sorted" -eq 1 ]; then
-        $CAT -- "$image" | cpio --extract --verbose --quiet --list | sort -n -k5
+        $CAT "$image" | cpio --extract --verbose --quiet --list | sort -n -k5
     else
-        $CAT -- "$image" | cpio --extract --verbose --quiet --list | sort -k9
+        $CAT "$image" | cpio --extract --verbose --quiet --list | sort -k9
     fi
     ((ret+=$?))
     echo "========================================================================"
-- 
1.8.4.2
