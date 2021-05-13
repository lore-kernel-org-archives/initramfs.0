From: Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: [PATCH 1/2] dracut: add a new argument "--squash-input-images"
Date: Fri, 14 May 2021 02:27:49 +0530
Message-ID: <162093946954.146305.14667813856804946279.stgit@hbathini>
References: <162093940333.146305.6079089813493806819.stgit@hbathini>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=3tUd/dGpIkHd5XQUP/pYeLi9ZQ9+hBh67la4xiBGofQ=;
 b=fUCua3B+AIxFOyYLp7yzjYsj59aJuPwftqe9cju/tnTxLfAigzcJe+2KNpCuOvQCL9Kp
 21SUiB3Xy37aI7W/Yol5/Xu1pL9Fn+HIOFOplpP+oC+ixe/ZpMaHqOaPgAcQx2175sib
 EPpMIbNClz6HDPCZ+rkRXEZAj8JkaJ7aVw/uF9AdR/OTfMkS301q1/N1ql0tbGcx7fhl
 pAV3pf++ohECi83w6FWkj7jJcHyw9xj/0u4jqCKMLMOKdP65VGjnb9KYz8YvhKrVfidS
 KLQL24/GIdlfDx530fRYJZhU6Rf2N1727WwvK4FoNMKQbvYI0vEL5O+7rirL4eK4Q9ws gA== 
In-Reply-To: <162093940333.146305.6079089813493806819.stgit@hbathini>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mahesh J Salgaonkar <mahesh-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Sourabh Jain <sourabhjain-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Add "squash-input-images" option to include the squash'ed image of
space-separated list of each initramfs image provided.

    Usage: dracut --squash-input-images "image1 image2"

This option can be leveraged, to include initramfs images with varying
purposes build into a single image & to activate/mount one of those
images based on specific boot condition each.

While one squash image (/squash/root.img) is already generated based
on the current dracut options, a squash image is generated for each
initramfs image provided through this new option (/squash/root0.img,
squash/root1.img, etc.).

Signed-off-by: Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
---
 dracut.sh |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 90 insertions(+), 13 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 062ed6c1..1a84a707 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -82,6 +82,14 @@ Creates initial ramdisk images for preloading modules
   -f, --force           Overwrite existing initramfs file.
   -a, --add [LIST]      Add a space-separated list of dracut modules.
   --rebuild         Append arguments to those of existing image and rebuild
+  --squash-input-images [LIST]
+                        Include the squash'ed image of space-separated list of
+                         each initramfs image provided. This option can be
+                         leveraged, to include initramfs images with varying
+                         purposes build into a single image. /squash/root0.img,
+                         /squash/root1.img, /squash/root2.img, etc., squash
+                         images are created, one each for each input initramfs
+                         image provided, in that order.
   -m, --modules [LIST]  Specify a space-separated list of dracut modules to
                          call when building the initramfs. Modules are located
                          in /usr/lib/dracut/modules.d.
@@ -373,6 +381,7 @@ rearrange_params()
         --long compress: \
         --long prefix: \
         --long rebuild: \
+        --long squash-input-images: \
         --long force \
         --long kernel-only \
         --long no-kernel \
@@ -443,6 +452,66 @@ rearrange_params()
     fi
 }
 
+squash_setup_dir() {
+    _sqsh_dir="$1"
+
+    mkdir -m 0755 -p "$_sqsh_dir"
+    for folder in "${squash_candidate[@]}"; do
+        mv "$2/$folder" "$_sqsh_dir/$folder"
+    done
+}
+
+squash_setup_input_images() {
+    local _old_pwd="$PWD"
+
+    readonly squash_tmp_dir="$squash_dir-tmp"
+
+    mkdir -m 0755 -p "$squash_tmp_dir"
+    cd "$squash_tmp_dir"
+    _sqsh_suffix=0
+    for input_file in $squash_input_images; do
+        lsinitrd --unpack "$input_file"
+        if [[ $? != 0 ]]; then
+            dfatal "dracut: failed to unpack image file '$input_file', for squashing!"
+            exit 1
+        fi
+
+        if [[ -f "$squash_tmp_dir/squash/root.img" ]]; then
+            mv "$squash_tmp_dir/squash/root.img" "$squash_dir$_sqsh_suffix.img"
+        else
+            squash_setup_dir "$squash_dir$_sqsh_suffix" "$squash_tmp_dir"
+        fi
+        rm -rf "$squash_tmp_dir"/*
+	let _sqsh_suffix++
+    done
+
+    squash_input_suffix_max=$((--_sqsh_suffix))
+    cd "$_old_pwd"
+    rm -rf "$squash_tmp_dir"
+}
+
+squash_make_image() {
+    _sqsh_dir="$1"
+
+    if ! mksquashfs "$_sqsh_dir" "$_sqsh_dir.img" \
+        -no-xattrs -no-exports -noappend -always-use-fragments \
+        -comp xz -Xdict-size 100% -no-progress \
+        > /dev/null; then
+        dfatal "dracut: Failed making squash image"
+        exit 1
+    fi
+
+    rm -rf "$_sqsh_dir"
+}
+
+squash_make_images_for_inputfiles() {
+    for _suffix in `seq 0 $squash_input_suffix_max`; do
+        _sqsh_dir="$squash_dir$_suffix"
+        [[ -f "$_sqsh_dir.img" ]] && continue
+	squash_make_image "$_sqsh_dir"
+    done
+}
+
 verbosity_mod_l=0
 unset kernel
 unset outfile
@@ -519,7 +588,7 @@ eval set -- "$TEMP"
 
 while :; do
     if [[ $1 != "--" ]] && [[ $1 != "--rebuild" ]]; then
-        PARMS_TO_STORE+=" $1";
+        [[ $1 != "--squash-input-images" ]] && PARMS_TO_STORE+=" $1";
     fi
     case $1 in
         --kver)        kernel="$2";                           PARMS_TO_STORE+=" '$2'"; shift;;
@@ -557,6 +626,7 @@ while :; do
                        fi
                        shift
                        ;;
+        --squash-input-images)     squash_input_images_l=("$2"); shift;;
         -f|--force)    force=yes;;
         --kernel-only) kernel_only="yes"; no_kernel="no";;
         --no-kernel)   kernel_only="no"; no_kernel="yes";;
@@ -658,6 +728,17 @@ while (($# > 0)); do
     shift
 done
 
+# error check --squash-input-images & prepare squash_input_images
+unset squash_input_images
+for _input_file in $squash_input_images_l; do
+    if [[ ! -e "$_input_file" ]]; then
+        echo "dracut: image file '$_input_file', for squashing, does not exist!"
+        exit 1
+    fi
+    _abs_input_file=$(readlink -f "$_input_file") && _input_file="$_abs_input_file"
+    squash_input_images+=("$_input_file ")
+done
+
 [[ $sysroot_l ]] && dracutsysrootdir="$sysroot_l"
 
 if [[ $regenerate_all == "yes" ]]; then
@@ -1623,6 +1704,7 @@ export initdir dracutbasedir \
     systemdutildir systemdutilconfdir systemdcatalog systemdntpunits \
     systemdntpunitsconfdir systemdsystemunitdir systemdsystemconfdir \
     hostonly_cmdline loginstall \
+    squash_input_images \
     tmpfilesdir
 
 mods_to_load=""
@@ -2025,10 +2107,10 @@ if dracut_module_included "squash"; then
     readonly squash_candidate=( "usr" "etc" )
 
     # shellcheck disable=SC2174
-    mkdir -m 0755 -p "$squash_dir"
-    for folder in "${squash_candidate[@]}"; do
-        mv "$initdir/$folder" "$squash_dir/$folder"
-    done
+    squash_setup_dir "$squash_dir" "$initdir"
+    if [[ -n "$squash_input_images" ]]; then
+        squash_setup_input_images
+    fi
 
     # Move some files out side of the squash image, including:
     # - Files required to boot and mount the squashfs image
@@ -2117,15 +2199,10 @@ fi
 
 if dracut_module_included "squash"; then
     dinfo "*** Squashing the files inside the initramfs ***"
-    if ! mksquashfs "$squash_dir" "$squash_img" \
-        -no-xattrs -no-exports -noappend -always-use-fragments \
-        -comp xz -Xdict-size 100% -no-progress \
-        > /dev/null; then
-        dfatal "dracut: Failed making squash image"
-        exit 1
+    squash_make_image "$squash_dir"
+    if [[ -n "$squash_input_images" ]]; then
+        squash_make_images_for_inputfiles
     fi
-
-    rm -rf "$squash_dir"
     dinfo "*** Squashing the files inside the initramfs done ***"
 fi
 


