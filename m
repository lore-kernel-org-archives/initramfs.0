From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 3/3] dracut: script adjusted to new logging facility; -v changed
Date: Wed, 16 Mar 2011 21:24:30 +0100
Message-ID: <1300307070-10087-3-git-send-email-aidecoe@aidecoe.name>
References: <1300307070-10087-1-git-send-email-aidecoe@aidecoe.name>
 <1300307070-10087-2-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300307070-10087-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

-v meaning has changed. Now it increases verbosity level. -q option has
been added, which decreases verbosity level. Both options might be
specified multiple times.
---
 dracut |   64 +++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/dracut b/dracut
index 4d50472..882007e 100755
--- a/dracut
+++ b/dracut
@@ -67,8 +67,8 @@ Creates initial ramdisk images for preloading modules
                          4 - info (default)
                          5 - debug info (here starts lots of output)
                          6 - trace info (and even more)
-  -v, --verbose         Verbose output during the build process (info level)
-  -q, --quiet           Display only errors and fatal errors during build
+  -v, --verbose         Increase verbosity level (default is info(4))
+  -q, --quiet           Decrease verbosity level (default is info(4))
   -c, --conf [FILE]     Specify configuration file to use.
                          Default: /etc/dracut.conf
   --confdir [DIR]       Specify configuration directory to use *.conf files 
@@ -179,7 +179,7 @@ push_arg() {
 }
 
 kernel="unset"
-stdloglvl_l=0
+verbosity_mod_l=0
 
 while (($# > 0)); do
     case ${1%%=*} in
@@ -205,8 +205,8 @@ while (($# > 0)); do
         --lvmconf)     lvmconf_l="yes";;
         --nolvmconf)   lvmconf_l="no";;
         --debug)       debug="yes";;
-        -v|--verbose)  beverbose="yes";;
-        -q|--quiet)    bequiet="yes";;
+        -v|--verbose)  ((verbosity_mod_l++));;
+        -q|--quiet)    ((verbosity_mod_l--));;
         -l|--local)    allowlocal="yes" ;;
         -H|--hostonly) hostonly_l="yes" ;;
         --fstab)       use_fstab_l="yes" ;;
@@ -249,12 +249,6 @@ export PATH
     set -x
 }
 
-# For compatibility with -v behaviour. Set to info level.
-[[ $beverbose ]] && (( $stdloglvl_l < 4 )) && stdloglvl_l=4
-
-# When quiet, display only errors and fatal errors.
-[[ $bequiet ]] && (( $stdloglvl_l > 2 )) && stdloglvl_l=2
-
 [[ $dracutbasedir ]] || dracutbasedir=/usr/share/dracut
 
 [[ $allowlocal && -f "$(readlink -f ${0%/*})/dracut-functions" ]] && \
@@ -331,6 +325,10 @@ if [[ ${#fw_dir_l[@]} ]]; then
 fi
 
 [[ $stdloglvl_l ]] && stdloglvl=$stdloglvl_l
+stdloglvl=$((stdloglvl + verbosity_mod_l))
+((stdloglvl > 6)) && stdloglvl=6
+((stdloglvl < 0)) && stdloglvl=0
+
 [[ $drivers_dir_l ]] && drivers_dir=$drivers_dir_l
 [[ $do_strip_l ]] && do_strip=$do_strip_l
 [[ $hostonly_l ]] && hostonly=$hostonly_l
@@ -359,7 +357,7 @@ fi
 dracutfunctions=$dracutbasedir/dracut-functions
 export dracutfunctions
 
-dinfo "Executing $0 $dracut_args"
+ddebug "Executing $0 $dracut_args"
 
 [[ $do_list = yes ]] && {
     for mod in $dracutbasedir/modules.d/*; do
@@ -375,12 +373,13 @@ dinfo "Executing $0 $dracut_args"
 [[ $libdir ]] || for libdir in /lib64 /lib; do
     [[ -d $libdir ]] && break
 done || {
-    derror 'No lib directory?!!!'
+    dfatal 'No lib directory?!!!'
     exit 1
 }
+
 [[ $usrlibdir ]] || for usrlibdir in /usr/lib64 /usr/lib; do
     [[ -d $usrlibdir ]] && break
-done || dwarning 'No usr/lib directory!'
+done || dwarn 'No usr/lib directory!'
 
 # This is kinda legacy -- eventually it should go away.
 case $dracutmodules in
@@ -392,7 +391,7 @@ abs_outfile=$(readlink -f "$outfile") && outfile="$abs_outfile"
 srcmods="/lib/modules/$kernel/"
 [[ $drivers_dir ]] && {
     if vercmp $(modprobe --version | cut -d' ' -f3) lt 3.7; then
-        derror 'To use --kmoddir option module-init-tools >= 3.7 is required.'
+        dfatal 'To use --kmoddir option module-init-tools >= 3.7 is required.'
         exit 1
     fi
     srcmods="$drivers_dir"
@@ -400,19 +399,19 @@ srcmods="/lib/modules/$kernel/"
 export srcmods
 
 if [[ -f $outfile && ! $force ]]; then
-    derror "Will not override existing initramfs ($outfile) without --force"
+    dfatal "Will not override existing initramfs ($outfile) without --force"
     exit 1
 fi
 
 outdir=${outfile%/*}
 if [[ ! -d "$outdir" ]]; then
-    derror "Can't write $outfile: Directory $outdir does not exist."
+    dfatal "Can't write $outfile: Directory $outdir does not exist."
     exit 1
 elif [[ ! -w "$outdir" ]]; then
-    derror "No permission to write $outdir."
+    dfatal "No permission to write $outdir."
     exit 1
 elif [[ -f "$outfile" && ! -w "$outfile" ]]; then
-    derror "No permission to write $outfile."
+    dfatal "No permission to write $outfile."
     exit 1
 fi
 
@@ -452,7 +451,7 @@ check_module_dir
 for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
     mod=${moddir##*/}; mod=${mod#[0-9][0-9]}
     if strstr "$mods_to_load" " $mod "; then
-        dinfo "*** Sourcing module $mod"
+        dinfo "*** Including module: $mod ***"
         if [[ $kernel_only = yes ]]; then
             module_installkernel $mod
         else
@@ -465,13 +464,14 @@ for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
     fi
 done
 unset moddir
+dinfo "*** Including modules' done ***"
 
 ## final stuff that has to happen
 
 # generate module dependencies for the initrd
 if [[ -d $initdir/lib/modules/$kernel ]] && \
     ! depmod -a -b "$initdir" $kernel; then
-    derror "\"depmod -a $kernel\" failed."
+    dfatal "\"depmod -a $kernel\" failed."
     exit 1
 fi
 
@@ -480,6 +480,7 @@ while pop include_src src && pop include_target tgt; do
         if [[ -f $src ]]; then
             inst $src $tgt
         else
+            ddebug "Including directory: $src"
             mkdir -p "${initdir}/${tgt}"
             cp -a -t "${initdir}/${tgt}" "$src"/*
         fi
@@ -495,10 +496,18 @@ unset item
 
 # make sure that library links are correct and up to date
 dracut_install /etc/ld.so.conf /etc/ld.so.conf.d/*
-ldconfig -r "$initdir" || [[ $UID != "0" ]] && \
-    dinfo "ldconfig might need uid=0 (root) for chroot()"
+if ! ldconfig -r "$initdir"; then
+    if [[ $UID = 0 ]]; then
+        derror "ldconfig exited ungracefully"
+    else
+        derror "ldconfig might need uid=0 (root) for chroot()"
+    fi
+fi
 
-[[ $beverbose = yes ]] && (du -c "$initdir" | sort -n)
+if (($maxloglvl >= 5)); then
+    ddebug "Listing sizes of included files:"
+    du -c "$initdir" | sort -n | ddebug
+fi
 
 # strip binaries 
 if [[ $do_strip = yes ]] ; then
@@ -525,10 +534,11 @@ type hardlink &>/dev/null && {
 
 if ! ( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet | \
     $compress > "$outfile"; ); then 
-    derror "dracut: creation of $outfile failed"
+    dfatal "dracut: creation of $outfile failed"
     exit 1
 fi 
-dinfo "Wrote $outfile"
-dinfo $(ls -l "$outfile")
+
+dinfo "Wrote $outfile:"
+dinfo "$(ls -l "$outfile")"
 
 exit 0
-- 
1.7.4.1
