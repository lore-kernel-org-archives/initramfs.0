From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 8/9] dracut: new option: -M, --show-modules - lists modules on build
Date: Fri, 25 Mar 2011 15:56:51 +0100
Message-ID: <1301065012-16356-8-git-send-email-aidecoe@aidecoe.name>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-4-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-5-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-6-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-7-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301065012-16356-7-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Module name is printed to standard output before its inclusion.
---
 dracut |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 192c5b5..2c5a813 100755
--- a/dracut
+++ b/dracut
@@ -106,6 +106,8 @@ Creates initial ramdisk images for preloading modules
   --no-compress         Do not compress the generated initramfs.  This will
                          override any other compression options.
   --list-modules        List all available dracut modules.
+  -M, --show-modules    Print included module's name to standard output during
+                         build.
 EOF
 }
 
@@ -230,6 +232,9 @@ while (($# > 0)); do
         --list-modules)
             do_list="yes";
             ;;
+        -M|--show-modules)
+                       show_modules_l="yes"
+                       ;;
         -*) printf "\nUnknown option: %s\n\n" "$1" >&2; usage; exit 1;;
         *) 
             if ! [[ $outfile ]]; then
@@ -347,6 +352,7 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 [[ $fw_dir ]] || fw_dir=/lib/firmware
 [[ $do_strip ]] || do_strip=no
 [[ $compress_l ]] && compress=$compress_l
+[[ $show_modules_l ]] && show_modules=$show_modules_l
 # eliminate IFS hackery when messing with fw_dir
 fw_dir=${fw_dir//:/ }
 
@@ -473,7 +479,8 @@ check_module_dir
 for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
     mod=${moddir##*/}; mod=${mod#[0-9][0-9]}
     if strstr "$mods_to_load" " $mod "; then
-        dinfo "*** Including module: $mod ***"
+        [[ $show_modules = yes ]] && echo "$mod" || \
+            dinfo "*** Including module: $mod ***"
         if [[ $kernel_only = yes ]]; then
             module_installkernel $mod
         else
-- 
1.7.4.1
