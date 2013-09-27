From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 4/6] mkinitrd-dracut.sh: Allow mkinitrd call without passing any parameters
Date: Fri, 27 Sep 2013 20:18:58 +0200
Message-ID: <1380305940-64410-5-git-send-email-trenn@suse.de>
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

Before this gave a "usage" error.
Now boot_dir (by default /boot) is scanned for available kernels and sane
initrd default targets get defined and the corresponding initramfs files
are generated.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 mkinitrd-dracut.sh |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index 803abc0..eeb6dda 100755
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -46,6 +46,67 @@ read_arg() {
     fi
 }
 
+# Taken over from SUSE mkinitrd
+default_kernel_images() {
+    local regex kernel_image kernel_version version_version initrd_image
+    local qf='%{NAME}-%{VERSION}-%{RELEASE}\n'
+
+    case "$(uname -m)" in
+        s390|s390x)
+            regex='image'
+            ;;
+        ppc|ppc64)
+            regex='vmlinux'
+            ;;
+        i386|x86_64)
+            regex='vmlinuz'
+            ;;
+        arm*)
+            regex='[uz]Image'
+            ;;
+        aarch64)
+            regex='Image'
+            ;;
+        *)  regex='vmlinu.'
+            ;;
+    esac
+
+    # user mode linux                                                              
+    if grep -q UML /proc/cpuinfo; then
+            regex='linux'
+    fi
+
+    kernel_images=""
+    initrd_images=""
+    for kernel_image in $(ls $boot_dir \
+            | sed -ne "\|^$regex\(-[0-9.]\+-[0-9]\+-[a-z0-9]\+$\)\?|p" \
+            | grep -v kdump$ ) ; do
+
+        # Note that we cannot check the RPM database here -- this
+        # script is itself called from within the binary kernel
+        # packages, and rpm does not allow recursive calls.
+
+        [ -L "$boot_dir/$kernel_image" ] && continue
+        [ "${kernel_image%%.gz}" != "$kernel_image" ] && continue
+        kernel_version=$(/usr/bin/get_kernel_version \
+                         $boot_dir/$kernel_image 2> /dev/null)
+        initrd_image=$(echo $kernel_image | sed -e "s|${regex}|initrd|")
+        if [ "$kernel_image" != "$initrd_image" -a \
+             -n "$kernel_version" -a \
+             -d "/lib/modules/$kernel_version" ]; then
+                kernel_images="$kernel_images $boot_dir/$kernel_image"
+                initrd_images="$initrd_images $boot_dir/$initrd_image"
+        fi
+    done
+    for kernel_image in $kernel_images;do
+	kernels="$kernels ${kernel_image#*-}"
+    done
+    for initrd_image in $initrd_images;do
+	targets="$targets $initrd_image"
+    done
+
+}
+
 while (($# > 0)); do
     case ${1%%=*} in
         --with-usb) read_arg usbmodule "$@" || shift $?
@@ -119,7 +180,8 @@ while (($# > 0)); do
     shift
 done
 
-[[ $targets && $kernels ]] || usage
+[[ $targets && $kernels ]] || default_kernel_images
+[[ $targets && $kernels ]] || (error "No kernel found in $boot_dir" && usage)
 
 # We can have several targets/kernels, transform the list to an array
 targets=( $targets )
-- 
1.7.6.1
