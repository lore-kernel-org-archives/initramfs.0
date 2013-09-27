From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/6] mkinitrd-dracut.sh: Introduce -i -k parameters
Date: Fri, 27 Sep 2013 20:18:55 +0200
Message-ID: <1380305940-64410-2-git-send-email-trenn@suse.de>
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

In SUSE, one can pass a list of kernel files via -k parameter.
For each an initrd is generated as passed via -i parameters.

Make the dracut mkinitrd wrapper compatible to those.
For now only one kernel file and initrd target can be specified.
This will get enhanced with a follow-up patch.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 mkinitrd-dracut.sh |   50 +++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 41 insertions(+), 9 deletions(-)
 mode change 100644 => 100755 mkinitrd-dracut.sh

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
old mode 100644
new mode 100755
index ffea2d1..ace7725
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -1,6 +1,8 @@
 #!/bin/bash --norc
 kver=$(uname -r)
 
+boot_dir="/boot"
+
 error() { echo "$@" >&2; }
 
 usage () {
@@ -80,10 +82,27 @@ while (($# > 0)); do
         --looppath*) ;;
         --dsdt*) ;;
         --bootchart) ;;
-        *) if [[ ! $target ]]; then
-            target=$1
-            elif [[ ! $kernel ]]; then
-            kernel=$1
+	-b) read_arg boot_dir "$@" || shift
+	    if [ ! -d $boot_dir ];then
+		error "Boot directory $boot_dir does not exist"
+		exit 1
+	    fi
+	    ;;
+	-k) # Would be nice to get a list of images here
+	    read_arg kernel_images "$@" || shift
+	    for kernel_image in $kernel_images;do
+		kernels="$kernels ${kernel_image#*-}"
+	    done
+	    ;;
+	-i) read_arg initrd_images "$@" || shift
+	    for initrd_image in $initrd_images;do
+		targets="$targets $boot_dir/$initrd_images"
+	    done
+	    ;;
+        *) if [[ ! $targets ]]; then
+            targets=$1
+            elif [[ ! $kernels ]]; then
+            kernels=$1
             else
             usage
             fi;;
@@ -91,11 +110,24 @@ while (($# > 0)); do
     shift
 done
 
-[[ $target && $kernel ]] || usage
-[[ $img_vers ]] && target="$target-$kernel"
+[[ $targets && $kernels ]] || usage
+
+# We can have several targets/kernels, transform the list to an array
+targets=( $targets )
+[[ $kernels ]] && kernels=( $kernels )
 
-if [[ $basicmodules ]]; then
+for ((i=0 ; $i<${#targets[@]} ; i++)); do
+
+    if [[ $img_vers ]];then
+	target="${targets[$i]}-${kernels[$i]}"
+    else
+	target="${targets[$i]}"
+    fi
+    kernel="${kernels[$i]}"
+
+    if [[ $basicmodules ]]; then
         dracut $dracut_args --add-drivers "$basicmodules" "$target" "$kernel"
-else
+    else
         dracut $dracut_args "$target" "$kernel"
-fi
+    fi
+done
-- 
1.7.6.1
