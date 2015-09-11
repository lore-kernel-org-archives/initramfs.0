From: Dangyi Liu <dliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut.sh: allow setting i18n_install_all in command options
Date: Fri, 11 Sep 2015 16:03:56 +0800
Message-ID: <1441958636-15303-1-git-send-email-dliu@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dangyi Liu <dliu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

During kdump, we need a way to disable i18n_install_all forcedly in
order to reduce memory usage, especially on PowerPC machines with 64k
pages, which would efficiently save upto 60MB memory.
---
 dracut.8.asc | 3 +++
 dracut.sh    | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/dracut.8.asc b/dracut.8.asc
index 7a7ef9d..c4838af 100644
--- a/dracut.8.asc
+++ b/dracut.8.asc
@@ -479,6 +479,9 @@ will not be able to boot.
     Specifies the kernel image, which to include in the UEFI executable. The default is
     _/lib/modules/<KERNEL-VERSION>/vmlinuz_ or _/boot/vmlinuz-<KERNEL-VERSION>_
 
+**--i18n_install_all _<yes|no>_**::
+    Force to install all i18n stuff or not.
+
 FILES
 -----
 _/var/log/dracut.log_::
diff --git a/dracut.sh b/dracut.sh
index 8ca319b..4ef12ee 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -207,6 +207,7 @@ Creates initial ramdisk images for preloading modules
                         kernel combined
   --uefi-stub [FILE]    Use the UEFI stub [FILE] to create an UEFI executable
   --kernel-image [FILE] location of the kernel image
+  --i18n_install_all [yes|no] Force to install all i18n stuff or not
 
 If [LIST] has multiple arguments, then you have to put these in quotes.
 
@@ -362,6 +363,7 @@ rearrange_params()
         --long uefi \
         --long uefi-stub: \
         --long kernel-image: \
+        --long i18n_install_all: \
         -- "$@")
 
     if (( $? != 0 )); then
@@ -552,6 +554,8 @@ while :; do
                        uefi_stub_l="$2";               PARMS_TO_STORE+=" '$2'"; shift;;
         --kernel-image)
                        kernel_image_l="$2";            PARMS_TO_STORE+=" '$2'"; shift;;
+        --i18n_install_all)
+                       i18n_install_all_l="$2";        PARMS_TO_STORE+=" '$2'"; shift;;
         --) shift; break;;
 
         *)  # should not even reach this point
@@ -736,6 +740,7 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 [[ $loginstall_l ]] && loginstall="$loginstall_l"
 [[ $uefi_stub_l ]] && uefi_stub="$uefi_stub_l"
 [[ $kernel_image_l ]] && kernel_image="$kernel_image_l"
+[[ $i18n_install_all_l ]] && i18n_install_all="$i18n_install_all_l"
 
 # eliminate IFS hackery when messing with fw_dir
 fw_dir=${fw_dir//:/ }
-- 
2.4.3
