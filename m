From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 6/6] mkinitrd-dracut.sh: Build host images for default_kernel_images and -i/-k paths
Date: Fri, 27 Sep 2013 20:19:00 +0200
Message-ID: <1380305940-64410-7-git-send-email-trenn@suse.de>
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

default_kernel_images and -i/-k paths are new (SuSE) code paths and
would have resulted in usage errors before.

There we want to build host only images for faster building and
smaller images.
Also force creation (overriding) of initrd images in these code paths.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 mkinitrd-dracut.sh |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index f7b53f1..a1519ea 100755
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -3,6 +3,8 @@ kver=$(uname -r)
 
 boot_dir="/boot"
 quiet=0
+host_only=0
+force=0
 
 error() { echo "$@" >&2; }
 
@@ -104,7 +106,8 @@ default_kernel_images() {
     for initrd_image in $initrd_images;do
 	targets="$targets $initrd_image"
     done
-
+    host_only=1
+    force=1
 }
 
 while (($# > 0)); do
@@ -119,8 +122,8 @@ while (($# > 0)); do
         --version)
             echo "mkinitrd: dracut compatibility wrapper"
             exit 0;;
-        -v|--verbose) dracut_args="${dracut_args} -v";;
-        -f|--force) dracut_args="${dracut_args} -f";;
+        -v|--verbose) dracut_args="${dracut_args} -v --keep";;
+        -f|--force) force=1;;
         --preload) read_arg modname "$@" || shift $?
             basicmodules="$basicmodules $modname";;
         --image-version) img_vers=yes;;
@@ -164,6 +167,8 @@ while (($# > 0)); do
 	    for kernel_image in $kernel_images;do
 		kernels="$kernels ${kernel_image#*-}"
 	    done
+	    host_only=1
+	    force=1
 	    ;;
 	-i) read_arg initrd_images "$@" || shift $?
 	    for initrd_image in $initrd_images;do
@@ -188,6 +193,9 @@ done
 targets=( $targets )
 [[ $kernels ]] && kernels=( $kernels )
 
+[[ $host_only == 1 ]] && dracut_args="${dracut_args} -H"
+[[ $force == 1 ]]     && dracut_args="${dracut_args} -f"
+
 echo "Creating: target|kernel|dracut args|basicmodules "
 for ((i=0 ; $i<${#targets[@]} ; i++)); do
 
-- 
1.7.6.1
