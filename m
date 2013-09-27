From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/6] mkinitrd-dracut.sh: Enhance param parsing: Allow multiple arguments per param
Date: Fri, 27 Sep 2013 20:18:56 +0200
Message-ID: <1380305940-64410-3-git-send-email-trenn@suse.de>
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

Currently --with parameter had to be passed as: --with="mod1 mod2".
Now one can pass: --with "mod1 mod2" or even --with mod1 mod2.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 mkinitrd-dracut.sh |   43 +++++++++++++++++++++++++------------------
 1 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index ace7725..d8e92f3 100755
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -26,36 +26,43 @@ read_arg() {
     # $1 = arg name
     # $2 = arg value
     # $3 = arg parameter
-    local rematch='^[^=]*=(.*)$'
+    param="$1"
+    local rematch='^[^=]*=(.*)$' result
     if [[ $2 =~ $rematch ]]; then
-        read "$1" <<< "${BASH_REMATCH[1]}"
-    elif [[ $3 != -* ]]; then
-        # Only read next arg if it not an arg itself.
-        read "$1" <<< "$3"
-        # There is no way to shift our callers args, so
-        # return 1 to indicate they should do it instead.
-        return 1
+        read "$param" <<< "${BASH_REMATCH[1]}"
+    else
+	for ((i=3; $i <= $#; i++)); do
+            # Only read next arg if it not an arg itself.
+            if [[ ${@:$i:1} = -* ]];then
+		break
+            fi
+            result="$result ${@:$i:1}"
+            # There is no way to shift our callers args, so
+            # return "no of args" to indicate they should do it instead.
+	done
+	read "$1" <<< "$result"
+        return $(($i - 3))
     fi
 }
 
 while (($# > 0)); do
     case ${1%%=*} in
-        --with-usb) read_arg usbmodule "$@" || shift
+        --with-usb) read_arg usbmodule "$@" || shift $?
             basicmodules="$basicmodules ${usbmodule:-usb-storage}"
             unset usbmodule;;
-        --with-avail) read_arg modname "$@" || shift
+        --with-avail) read_arg modname "$@" || shift $?
             basicmodules="$basicmodules $modname";;
-        --with) read_arg modname "$@" || shift
+        --with) read_arg modname "$@" || shift $?
             basicmodules="$basicmodules $modname";;
         --version)
             echo "mkinitrd: dracut compatibility wrapper"
             exit 0;;
         -v|--verbose) dracut_args="${dracut_args} -v";;
         -f|--force) dracut_args="${dracut_args} -f";;
-        --preload) read_arg modname "$@" || shift
+        --preload) read_arg modname "$@" || shift $?
             basicmodules="$basicmodules $modname";;
         --image-version) img_vers=yes;;
-        --rootfs) read_arg rootfs "$@" || shift
+        --rootfs) read_arg rootfs "$@" || shift $?
             dracut_args="${dracut_args} --filesystems $rootfs";;
         --nocompress) dracut_args="$dracut_args --no-compress";;
         --help) usage -n;;
@@ -82,24 +89,24 @@ while (($# > 0)); do
         --looppath*) ;;
         --dsdt*) ;;
         --bootchart) ;;
-	-b) read_arg boot_dir "$@" || shift
+	-b) read_arg boot_dir "$@" || shift $?
 	    if [ ! -d $boot_dir ];then
 		error "Boot directory $boot_dir does not exist"
 		exit 1
 	    fi
 	    ;;
 	-k) # Would be nice to get a list of images here
-	    read_arg kernel_images "$@" || shift
+	    read_arg kernel_images "$@" || shift $?
 	    for kernel_image in $kernel_images;do
 		kernels="$kernels ${kernel_image#*-}"
 	    done
 	    ;;
-	-i) read_arg initrd_images "$@" || shift
+	-i) read_arg initrd_images "$@" || shift $?
 	    for initrd_image in $initrd_images;do
-		targets="$targets $boot_dir/$initrd_images"
+		targets="$targets $boot_dir/$initrd_image"
 	    done
 	    ;;
-        *) if [[ ! $targets ]]; then
+        *)  if [[ ! $targets ]]; then
             targets=$1
             elif [[ ! $kernels ]]; then
             kernels=$1
-- 
1.7.6.1
