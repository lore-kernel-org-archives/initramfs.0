From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] Take into account lib64 dirs when detecting version, modules and params
Date: Sun, 11 Jan 2015 15:12:10 +0100
Message-ID: <1420985530-5006-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 lsinitrd.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lsinitrd.sh b/lsinitrd.sh
index 4f12c2c..dc1f88f 100755
--- a/lsinitrd.sh
+++ b/lsinitrd.sh
@@ -124,7 +124,7 @@ extract_files()
 list_modules()
 {
     echo "dracut modules:"
-    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib/dracut/modules.txt' 'usr/lib/dracut/modules.txt' 2>/dev/null
+    $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib64/dracut/modules.txt' 'lib/dracut/modules.txt' 'usr/lib/dracut/modules.txt' 2>/dev/null
     ((ret+=$?))
 }
 
@@ -217,7 +217,7 @@ ret=0
 if (( ${#filenames[@]} > 0 )); then
     extract_files
 else
-    version=$($CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib/dracut/dracut-*' 'usr/lib/dracut/dracut-*' 2>/dev/null)
+    version=$($CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib64/dracut/dracut-*' 'lib/dracut/dracut-*' 'usr/lib/dracut/dracut-*' 2>/dev/null)
     ((ret+=$?))
     echo "Version: $version"
     echo
@@ -226,7 +226,7 @@ else
         echo "========================================================================"
     else
         echo -n "Arguments: "
-        $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib/dracut/build-parameter.txt' 'usr/lib/dracut/build-parameter.txt' 2>/dev/null
+        $CAT "$image" | cpio --extract --verbose --quiet --to-stdout -- 'lib64/dracut/build-parameter.txt' 'lib/dracut/build-parameter.txt' 'usr/lib/dracut/build-parameter.txt' 2>/dev/null
         echo
         list_modules
         list_files
-- 
2.2.1
