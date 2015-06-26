From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 4/8] mkinitrd-suse.sh: Bail out with exit 1 if initrd cannot be generated
Date: Fri, 26 Jun 2015 16:55:53 +0200
Message-ID: <1435330557-17685-5-git-send-email-trenn@suse.de>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435330557-17685-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 mkinitrd-suse.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mkinitrd-suse.sh b/mkinitrd-suse.sh
index af42cbe..c2b314f 100755
--- a/mkinitrd-suse.sh
+++ b/mkinitrd-suse.sh
@@ -280,7 +280,8 @@ done
 
 [[ $targets && $kernels ]] || default_kernel_images
 if [[ ! $targets || ! $kernels ]];then
-    error "No kernel found in $boot_dir"
+    error "No kernel found in $boot_dir or bad modules dir in /lib/modules"
+    exit 1
 fi
 
 # We can have several targets/kernels, transform the list to an array
@@ -301,6 +302,8 @@ fi
 [[ $domu_module_list ]] || domu_module_list="${DOMU_INITRD_MODULES}"
 shopt -s extglob
 
+failed=""
+
 for ((i=0 ; $i<${#targets[@]} ; i++)); do
 
     if [[ $img_vers ]];then
@@ -329,14 +332,18 @@ for ((i=0 ; $i<${#targets[@]} ; i++)); do
         # expansion magics
         if [ -n "${modules_all}" ];then
             $dracut_cmd $dracut_args --force-drivers "${modules_all}" "$target" "$kernel" &>/dev/null
+            [ $? -ne 0 ] && failed="$failed $target"
         else
             $dracut_cmd $dracut_args "$target" "$kernel" &>/dev/null
+            [ $? -ne 0 ] && failed="$failed $target"
         fi
     else
         if [ -n "${modules_all}" ];then
             $dracut_cmd $dracut_args --force-drivers "${modules_all}" "$target" "$kernel"
+            [ $? -ne 0 ] && failed="$failed $target"
         else
             $dracut_cmd $dracut_args "$target" "$kernel"
+            [ $? -ne 0 ] && failed="$failed $target"
         fi
     fi
 done
@@ -345,4 +352,12 @@ if [ "$skip_update_bootloader" ] ; then
     echo 2>&1 "Did not refresh the bootloader. You might need to refresh it manually."
 else
     update-bootloader --refresh
+    [ $? -ne 0 ] && echo "Updating bootloader failed" && exit 1
+fi
+
+if [ "$failed" != "" ]; then
+    echo "Generating $failed targets failed"
+    exit 1
 fi
+
+exit 0
-- 
2.1.4
