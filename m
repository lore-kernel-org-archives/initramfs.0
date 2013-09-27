From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 3/6] mkinitrd-dracut.sh: Implement --quiet|-q option
Date: Fri, 27 Sep 2013 20:18:57 +0200
Message-ID: <1380305940-64410-4-git-send-email-trenn@suse.de>
References: <1380305940-64410-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380305940-64410-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

Dracut is rather verbose. This optional parameter is to limit the output
to the essential: For each generated initrd show the kernel, target and
possibly additional options passed to dracut.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 mkinitrd-dracut.sh |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index d8e92f3..803abc0 100755
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -2,6 +2,7 @@
 kver=$(uname -r)
 
 boot_dir="/boot"
+quiet=0
 
 error() { echo "$@" >&2; }
 
@@ -89,6 +90,7 @@ while (($# > 0)); do
         --looppath*) ;;
         --dsdt*) ;;
         --bootchart) ;;
+	--quiet|-q) quiet=1;;
 	-b) read_arg boot_dir "$@" || shift $?
 	    if [ ! -d $boot_dir ];then
 		error "Boot directory $boot_dir does not exist"
@@ -123,6 +125,7 @@ done
 targets=( $targets )
 [[ $kernels ]] && kernels=( $kernels )
 
+echo "Creating: target|kernel|dracut args|basicmodules "
 for ((i=0 ; $i<${#targets[@]} ; i++)); do
 
     if [[ $img_vers ]];then
@@ -132,9 +135,21 @@ for ((i=0 ; $i<${#targets[@]} ; i++)); do
     fi
     kernel="${kernels[$i]}"
 
-    if [[ $basicmodules ]]; then
-        dracut $dracut_args --add-drivers "$basicmodules" "$target" "$kernel"
+    # Duplicate code: No way found how to redirect output based on $quiet
+    if [[ $quiet == 1 ]];then
+	echo "$target|$kernel|$dracut_args|$basicmodules"
+	if [[ $basicmodules ]]; then
+            dracut $dracut_args --add-drivers "$basicmodules" "$target" \
+		"$kernel" &>/dev/null
+	else
+            dracut $dracut_args "$target" "$kernel" &>/dev/null
+	fi
     else
-        dracut $dracut_args "$target" "$kernel"
+	if [[ $basicmodules ]]; then
+            dracut $dracut_args --add-drivers "$basicmodules" "$target" \
+		"$kernel"
+	else
+            dracut $dracut_args "$target" "$kernel"
+	fi
     fi
 done
-- 
1.7.6.1
