From: Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: [PATCH 2/2] dracut/99squash: make sqaush image setup flexible
Date: Fri, 14 May 2021 02:27:57 +0530
Message-ID: <162093947717.146305.16180379544252191121.stgit@hbathini>
References: <162093940333.146305.6079089813493806819.stgit@hbathini>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=+rrZ8B2RFNpiCRREWl3YZrTxPPtFjTYoaxeE3VT8Cfo=;
 b=YwH5wgncaSJiZsvro20GPRor62+Il/It7E0QhgjSL4CZXNOoBB5CAL7kkfTxoqvabhc4
 L6cIljECh6Lfwcc22B8iJzch+jQmoh7E9GqShZE6twcgiiOmZ4yOVyaj4wxeYmD8iL3X
 sOuOViFYb3qyKuioR0q6A+veayKP0GUYLTGS7FrfVEd9fm7kuYPDqJErWgxRvSqoIk4O
 r7I272nSdF8acjnQvzzjwMvco1J+ZGv0RtzbAWcpzQ2bCyKl0ETgcKUPWiFdQvzTY7tU
 6aKu5gUA6NQNs+Z/tCi8N5dFAWXyiD8DtnX5cLaWMTyBrW4L35QeV4S0qpKyxbbEZr7n 4g== 
In-Reply-To: <162093940333.146305.6079089813493806819.stgit@hbathini>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mahesh J Salgaonkar <mahesh-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Sourabh Jain <sourabhjain-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

So far, /squash/root.img was the only squash'ed file in the initramfs
image. But with the introduction of '--squash-input-images' option,
initramfs image can have more than one squash'ed images. Make squash
image setup flexible to leverage the new option.

For that purpose, add 'setup-sqaush-conditional.sh' script which is
same as 'setup-squash.sh' script except for a couple of changes.

One, it sources 'squash-image-conditional.sh' script. Two, it calls
setup_squash_image_conditional() function implemented in the sourced
script before mounting the squash image (/squash/root.img).

'squash-image-conditional.sh' script here has a dummy implementation
for setup_squash_image_conditional() function. Introduce a new dracut
option '--squash-image-conditional' to overwrite the stock script
(squash/squash-image-conditional.sh) with a custom script.

    Usage: dracut --squash-image-conditional custom-script.sh

The 'custom-script.sh' script file is expected to be implemented in
such a way that /squash/root.img file is updated appropriately, on
calling setup_squash_image_conditional() function, for every possible
boot scenario.

Signed-off-by: Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
---
 dracut.sh                                      |   26 ++++++++--
 modules.d/99squash/module-setup.sh             |   17 ++++++
 modules.d/99squash/setup-squash-conditional.sh |   65 ++++++++++++++++++++++++
 modules.d/99squash/squash-image-conditional.sh |    5 ++
 4 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100755 modules.d/99squash/setup-squash-conditional.sh
 create mode 100755 modules.d/99squash/squash-image-conditional.sh

diff --git a/dracut.sh b/dracut.sh
index 1a84a707..5fdb4104 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -90,6 +90,14 @@ Creates initial ramdisk images for preloading modules
                          /squash/root1.img, /squash/root2.img, etc., squash
                          images are created, one each for each input initramfs
                          image provided, in that order.
+  --squash-image-conditional [FILE]
+                        Install a custom script [FILE] in place of
+                         '/squash/squash-image-conditional.sh' file to override
+                         setup_squash_image_conditional() function's dummy
+                         implementation with the one that updates squash image
+                         appropriately for every possible boot scenario on the
+                         given system. (Ideally, used in combination with
+                        --squash-input-images option).
   -m, --modules [LIST]  Specify a space-separated list of dracut modules to
                          call when building the initramfs. Modules are located
                          in /usr/lib/dracut/modules.d.
@@ -382,6 +390,7 @@ rearrange_params()
         --long prefix: \
         --long rebuild: \
         --long squash-input-images: \
+        --long squash-image-conditional: \
         --long force \
         --long kernel-only \
         --long no-kernel \
@@ -588,7 +597,8 @@ eval set -- "$TEMP"
 
 while :; do
     if [[ $1 != "--" ]] && [[ $1 != "--rebuild" ]]; then
-        [[ $1 != "--squash-input-images" ]] && PARMS_TO_STORE+=" $1";
+        [[ $1 != "--squash-input-images" ]] \
+            && [[ $1 != "--squash-image-conditional" ]] && PARMS_TO_STORE+=" $1";
     fi
     case $1 in
         --kver)        kernel="$2";                           PARMS_TO_STORE+=" '$2'"; shift;;
@@ -627,6 +637,7 @@ while :; do
                        shift
                        ;;
         --squash-input-images)     squash_input_images_l=("$2"); shift;;
+	--squash-image-conditional)   squash_image_conditional="$2"; shift;;
         -f|--force)    force=yes;;
         --kernel-only) kernel_only="yes"; no_kernel="no";;
         --no-kernel)   kernel_only="no"; no_kernel="yes";;
@@ -728,7 +739,7 @@ while (($# > 0)); do
     shift
 done
 
-# error check --squash-input-images & prepare squash_input_images
+# error check squash related options & get absolute paths for the files provided.
 unset squash_input_images
 for _input_file in $squash_input_images_l; do
     if [[ ! -e "$_input_file" ]]; then
@@ -739,6 +750,12 @@ for _input_file in $squash_input_images_l; do
     squash_input_images+=("$_input_file ")
 done
 
+if [[ -n "$squash_image_conditional" ]] && [[ ! -e "$squash_image_conditional" ]]; then
+    echo "dracut: script file '$squash_image_conditional' to setup squash image, does not exist!"
+    exit 1
+fi
+_abs_sqsh_img_cond="$(readlink -f "$squash_image_conditional")" && squash_image_conditional="$_abs_sqsh_img_cond"
+
 [[ $sysroot_l ]] && dracutsysrootdir="$sysroot_l"
 
 if [[ $regenerate_all == "yes" ]]; then
@@ -1704,7 +1721,7 @@ export initdir dracutbasedir \
     systemdutildir systemdutilconfdir systemdcatalog systemdntpunits \
     systemdntpunitsconfdir systemdsystemunitdir systemdsystemconfdir \
     hostonly_cmdline loginstall \
-    squash_input_images \
+    squash_input_images squash_image_conditional \
     tmpfilesdir
 
 mods_to_load=""
@@ -2133,6 +2150,9 @@ if dracut_module_included "squash"; then
     # We have moved them inside the squashed image, but they need to be
     # accessible before mounting the image.
     inst_multiple "echo" "sh" "mount" "modprobe" "mkdir"
+    if [[ -n "$squash_input_images" ]] || [[ -f "$squash_image_conditional" ]]; then
+        inst_multiple "mv" "rm"
+    fi
     hostonly="" instmods "loop" "squashfs" "overlay"
     # Only keep systemctl outsite if we need switch root
     if [[ ! -f "$initdir/lib/dracut/no-switch-root" ]]; then
diff --git a/modules.d/99squash/module-setup.sh b/modules.d/99squash/module-setup.sh
index 9f973bda..a5d356ba 100644
--- a/modules.d/99squash/module-setup.sh
+++ b/modules.d/99squash/module-setup.sh
@@ -10,6 +10,11 @@ check() {
         fi
     done
 
+    # Include if '--squash-input-images' or '--squash-image-conditional' is used.
+    if [[ -n "$squash_input_images" ]] || [[ -f "$squash_image_conditional" ]]; then
+        return 0
+    fi
+
     return 255
 }
 
@@ -24,7 +29,17 @@ installkernel() {
 
 install() {
     inst_multiple kmod modprobe mount mkdir ln echo
-    inst "$moddir"/setup-squash.sh /squash/setup-squash.sh
+    if [[ -n "$squash_input_images" ]] || [[ -f "$squash_image_conditional" ]]; then
+        inst $moddir/setup-squash-conditional.sh /squash/setup-squash.sh
+        if [[ -f "$squash_image_conditional" ]]; then
+            inst "$squash_image_conditional" /squash/squash-image-conditional.sh
+            chmod 0755 "$initdir/squash/squash-image-conditional.sh"
+        else
+            inst $moddir/squash-image-conditional.sh /squash/squash-image-conditional.sh
+        fi
+    else
+        inst $moddir/setup-squash.sh /squash/setup-squash.sh
+    fi
     inst "$moddir"/clear-squash.sh /squash/clear-squash.sh
     inst "$moddir"/init.sh /squash/init.sh
 
diff --git a/modules.d/99squash/setup-squash-conditional.sh b/modules.d/99squash/setup-squash-conditional.sh
new file mode 100755
index 00000000..41616756
--- /dev/null
+++ b/modules.d/99squash/setup-squash-conditional.sh
@@ -0,0 +1,65 @@
+#!/bin/bash
+PATH=/bin:/sbin
+
+SQUASH_IMG=/squash/root.img
+SQUASH_MNT=/squash/root
+SQUASH_MNT_REC=/squash/mounts
+
+. /squash/squash-image-conditional.sh
+
+echo $SQUASH_MNT > $SQUASH_MNT_REC
+
+# Following mount points are neccessary for mounting a squash image
+
+[ ! -d /proc/self ] && \
+    mount -t proc -o nosuid,noexec,nodev proc /proc
+
+[ ! -d /sys/kernel ] && \
+    mount -t sysfs -o nosuid,noexec,nodev sysfs /sys
+
+[ ! -e /dev/loop-control ] && \
+    mount -t devtmpfs -o mode=0755,noexec,nosuid,strictatime devtmpfs /dev
+
+# Need a loop device backend, overlayfs, and squashfs module
+modprobe loop
+if [ $? != 0 ]; then
+    echo "Unable to setup loop module"
+fi
+
+modprobe squashfs
+if [ $? != 0 ]; then
+    echo "Unable to setup squashfs module"
+fi
+
+modprobe overlay
+if [ $? != 0 ]; then
+    echo "Unable to setup overlay module"
+fi
+
+setup_squash_image_conditional
+
+[ ! -d "$SQUASH_MNT" ] && \
+	mkdir -m 0755 -p $SQUASH_MNT
+
+# Mount the squashfs image
+mount -t squashfs -o ro,loop $SQUASH_IMG $SQUASH_MNT
+
+if [ $? != 0 ]; then
+    echo "Unable to mount squashed initramfs image"
+fi
+
+for file in $SQUASH_MNT/*; do
+	file=${file#$SQUASH_MNT/}
+	lowerdir=$SQUASH_MNT/$file
+	workdir=/squash/overlay-work/$file
+	upperdir=/$file
+	mntdir=/$file
+
+	mkdir -m 0755 -p $workdir
+	mkdir -m 0755 -p $mntdir
+
+	mount -t overlay overlay -o\
+		lowerdir=$lowerdir,upperdir=$upperdir,workdir=$workdir $mntdir
+
+	echo $mntdir >> $SQUASH_MNT_REC
+done
diff --git a/modules.d/99squash/squash-image-conditional.sh b/modules.d/99squash/squash-image-conditional.sh
new file mode 100755
index 00000000..2097b767
--- /dev/null
+++ b/modules.d/99squash/squash-image-conditional.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+
+setup_squash_image_conditional() {
+    return 0
+}


