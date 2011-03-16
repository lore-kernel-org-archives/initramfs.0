From: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [dracut GIT] branch, master, updated. 432196aef8002572e0a512f2d45344e181050177
Date: Wed, 16 Mar 2011 20:43:30 GMT
Message-ID: <201103162043.p2GKhUcl030581@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  432196aef8002572e0a512f2d45344e181050177 (commit)
       via  46265a9d3e0a15e4e8d21995cdf0618691d4e394 (commit)
       via  19530529946617993995c7605f3d5d79357611f7 (commit)
      from  0afae1c7cea9487a2a043d9223ef38543f7c8bba (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 432196aef8002572e0a512f2d45344e181050177
Author: Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Date:   Wed Mar 16 21:24:30 2011 +0100

    dracut: script adjusted to new logging facility; -v changed
   =20
    -v meaning has changed. Now it increases verbosity level. -q option=
 has
    been added, which decreases verbosity level. Both options might be
    specified multiple times.

diff --git a/dracut b/dracut
index aaf6485..649637d 100755
--- a/dracut
+++ b/dracut
@@ -67,8 +67,8 @@ Creates initial ramdisk images for preloading modules
                          4 - info (default)
                          5 - debug info (here starts lots of output)
                          6 - trace info (and even more)
-  -v, --verbose         Verbose output during the build process (info =
level)
-  -q, --quiet           Display only errors and fatal errors during bu=
ild
+  -v, --verbose         Increase verbosity level (default is info(4))
+  -q, --quiet           Decrease verbosity level (default is info(4))
   -c, --conf [FILE]     Specify configuration file to use.
                          Default: /etc/dracut.conf
   --confdir [DIR]       Specify configuration directory to use *.conf =
files=20
@@ -179,7 +179,7 @@ push_arg() {
 }
=20
 kernel=3D"unset"
-stdloglvl_l=3D0
+verbosity_mod_l=3D0
=20
 while (($# > 0)); do
     case ${1%%=3D*} in
@@ -205,8 +205,8 @@ while (($# > 0)); do
         --lvmconf)     lvmconf_l=3D"yes";;
         --nolvmconf)   lvmconf_l=3D"no";;
         --debug)       debug=3D"yes";;
-        -v|--verbose)  beverbose=3D"yes";;
-        -q|--quiet)    bequiet=3D"yes";;
+        -v|--verbose)  ((verbosity_mod_l++));;
+        -q|--quiet)    ((verbosity_mod_l--));;
         -l|--local)    allowlocal=3D"yes" ;;
         -H|--hostonly) hostonly_l=3D"yes" ;;
         --fstab)       use_fstab_l=3D"yes" ;;
@@ -249,12 +249,6 @@ export PATH
     set -x
 }
=20
-# For compatibility with -v behaviour. Set to info level.
-[[ $beverbose ]] && (( $stdloglvl_l < 4 )) && stdloglvl_l=3D4
-
-# When quiet, display only errors and fatal errors.
-[[ $bequiet ]] && (( $stdloglvl_l > 2 )) && stdloglvl_l=3D2
-
 [[ $dracutbasedir ]] || dracutbasedir=3D/usr/share/dracut
=20
 [[ $allowlocal && -f "$(readlink -f ${0%/*})/dracut-functions" ]] && \
@@ -331,6 +325,10 @@ if [[ ${#fw_dir_l[@]} ]]; then
 fi
=20
 [[ $stdloglvl_l ]] && stdloglvl=3D$stdloglvl_l
+stdloglvl=3D$((stdloglvl + verbosity_mod_l))
+((stdloglvl > 6)) && stdloglvl=3D6
+((stdloglvl < 0)) && stdloglvl=3D0
+
 [[ $drivers_dir_l ]] && drivers_dir=3D$drivers_dir_l
 [[ $do_strip_l ]] && do_strip=3D$do_strip_l
 [[ $hostonly_l ]] && hostonly=3D$hostonly_l
@@ -359,7 +357,7 @@ fi
 dracutfunctions=3D$dracutbasedir/dracut-functions
 export dracutfunctions
=20
-dinfo "Executing $0 $dracut_args"
+ddebug "Executing $0 $dracut_args"
=20
 [[ $do_list =3D yes ]] && {
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
=20
 # This is kinda legacy -- eventually it should go away.
 case $dracutmodules in
@@ -392,7 +391,7 @@ abs_outfile=3D$(readlink -f "$outfile") && outfile=3D=
"$abs_outfile"
 srcmods=3D"/lib/modules/$kernel/"
 [[ $drivers_dir ]] && {
     if vercmp $(modprobe --version | cut -d' ' -f3) lt 3.7; then
-        derror 'To use --kmoddir option module-init-tools >=3D 3.7 is =
required.'
+        dfatal 'To use --kmoddir option module-init-tools >=3D 3.7 is =
required.'
         exit 1
     fi
     srcmods=3D"$drivers_dir"
@@ -400,19 +399,19 @@ srcmods=3D"/lib/modules/$kernel/"
 export srcmods
=20
 if [[ -f $outfile && ! $force ]]; then
-    derror "Will not override existing initramfs ($outfile) without --=
force"
+    dfatal "Will not override existing initramfs ($outfile) without --=
force"
     exit 1
 fi
=20
 outdir=3D${outfile%/*}
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
=20
@@ -452,7 +451,7 @@ check_module_dir
 for moddir in "$dracutbasedir/modules.d"/[0-9][0-9]*; do
     mod=3D${moddir##*/}; mod=3D${mod#[0-9][0-9]}
     if strstr "$mods_to_load" " $mod "; then
-        dinfo "*** Sourcing module $mod"
+        dinfo "*** Including module: $mod ***"
         if [[ $kernel_only =3D yes ]]; then
             module_installkernel $mod
         else
@@ -465,13 +464,14 @@ for moddir in "$dracutbasedir/modules.d"/[0-9][0-=
9]*; do
     fi
 done
 unset moddir
+dinfo "*** Including modules' done ***"
=20
 ## final stuff that has to happen
=20
 # generate module dependencies for the initrd
 if [[ -d $initdir/lib/modules/$kernel ]] && \
     ! depmod -a -b "$initdir" $kernel; then
-    derror "\"depmod -a $kernel\" failed."
+    dfatal "\"depmod -a $kernel\" failed."
     exit 1
 fi
=20
@@ -480,6 +480,7 @@ while pop include_src src && pop include_target tgt=
; do
         if [[ -f $src ]]; then
             inst $src $tgt
         else
+            ddebug "Including directory: $src"
             mkdir -p "${initdir}/${tgt}"
             cp -a -t "${initdir}/${tgt}" "$src"/*
         fi
@@ -495,10 +496,18 @@ unset item
=20
 # make sure that library links are correct and up to date
 dracut_install /etc/ld.so.conf /etc/ld.so.conf.d/*
-ldconfig -r "$initdir" || [[ $UID !=3D "0" ]] && \
-    dinfo "ldconfig might need uid=3D0 (root) for chroot()"
+if ! ldconfig -r "$initdir"; then
+    if [[ $UID =3D 0 ]]; then
+        derror "ldconfig exited ungracefully"
+    else
+        derror "ldconfig might need uid=3D0 (root) for chroot()"
+    fi
+fi
=20
-[[ $beverbose =3D yes ]] && (du -c "$initdir" | sort -n)
+if (($maxloglvl >=3D 5)); then
+    ddebug "Listing sizes of included files:"
+    du -c "$initdir" | sort -n | ddebug
+fi
=20
 # strip binaries=20
 if [[ $do_strip =3D yes ]] ; then
@@ -525,10 +534,11 @@ type hardlink &>/dev/null && {
=20
 if ! ( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet | \
     $compress > "$outfile"; ); then=20
-    derror "dracut: creation of $outfile failed"
+    dfatal "dracut: creation of $outfile failed"
     exit 1
 fi=20
-dinfo "Wrote $outfile"
-dinfo $(ls -l "$outfile")
+
+dinfo "Wrote $outfile:"
+dinfo "$(ls -l "$outfile")"
=20
 exit 0
commit 46265a9d3e0a15e4e8d21995cdf0618691d4e394
Author: Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Date:   Wed Mar 16 21:24:29 2011 +0100

    dracut-logger: make $maxloglvl public
   =20
    $maxloglvl might be useful to check, if expensive informational
    operation is going to be logged at all, before executing it.

diff --git a/dracut-logger b/dracut-logger
index 0978d58..830ce1c 100755
--- a/dracut-logger
+++ b/dracut-logger
@@ -76,9 +76,9 @@ __DRACUT_LOGGER__=3D1
 #   - @var kmsgloglvl - logging level to /dev/kmsg (only for boot-time=
)
 #   - @var logfile - log file which is used when @var fileloglvl is hi=
gher
 #   than 0
-# and one global internal variable @var _maxloglvl which <b>must not</=
b> be
-# overwritten. @_maxloglvl is set by dlog_init() and holds maximum log=
ging level
-# of those three and indicates that dlog_init() was run.
+# and one global variable @var maxloglvl which <b>must not</b> be over=
written.
+# @var maxloglvl is set by dlog_init() and holds maximum logging level=
 of those
+# three and indicates that dlog_init() was run.
 #
 # Logging level set by the variable means that messages from this logg=
ing level
 # and above (FATAL is the highest) will be shown. Logging levels may b=
e set
@@ -101,11 +101,11 @@ __DRACUT_LOGGER__=3D1
 #   - @var kmsgloglvl =3D 0 (no logging)
 #   set to 0
 #
-# @warning Function sets global variable @var _maxloglvl for internal =
use. Don't
-# overwrite it.
+# @warning Function sets global variable @var maxloglvl. See file doc =
for
+# details.
 dlog_init() {
     # Skip initialization if it's already done.
-    [ -n "$_maxloglvl" ] && return 0
+    [ -n "$maxloglvl" ] && return 0
=20
     local ret=3D0; local errmsg
=20
@@ -144,12 +144,12 @@ dlog_init() {
         fi
     fi
=20
-    local lvl
-    _maxloglvl=3D0
-    for lvl in $stdloglvl $sysloglvl $fileloglvl; do
-        [ $lvl -gt $_maxloglvl ] && _maxloglvl=3D$lvl
+    local lvl; local maxloglvl_l=3D0
+    for lvl in $stdloglvl $sysloglvl $fileloglvl $kmsgloglvl; do
+        [ $lvl -gt $maxloglvl_l ] && maxloglvl_l=3D$lvl
     done
-    export _maxloglvl
+    readonly maxloglvl=3D$maxloglvl_l
+    export maxloglvl
=20
     [ -n "$errmsg" ] && derror "$errmsg"
=20
@@ -251,11 +251,11 @@ _dlvl2klvl() {
 #   - @c INFO to @c info
 #   - @c DEBUG and @c TRACE both to @c debug
 _do_dlog() {
-    [ -z "$_maxloglvl" ] && return 0
+    [ -z "$maxloglvl" ] && return 0
     local lvl=3D"$1"; shift
     local lvlc=3D$(_lvl2char "$lvl") || return 0
=20
-    [ $lvl -le $_maxloglvl ] || return 0
+    [ $lvl -le $maxloglvl ] || return 0
=20
     local msg=3D"$lvlc: $*"
=20
commit 19530529946617993995c7605f3d5d79357611f7
Author: Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Date:   Wed Mar 16 21:24:28 2011 +0100

    dracut: install ld.so.conf* with dracut_install instead of cp

diff --git a/dracut b/dracut
index 10e86d0..aaf6485 100755
--- a/dracut
+++ b/dracut
@@ -494,7 +494,7 @@ done
 unset item
=20
 # make sure that library links are correct and up to date
-cp -ar /etc/ld.so.conf* "$initdir"/etc
+dracut_install /etc/ld.so.conf /etc/ld.so.conf.d/*
 ldconfig -r "$initdir" || [[ $UID !=3D "0" ]] && \
     dinfo "ldconfig might need uid=3D0 (root) for chroot()"
=20
-----------------------------------------------------------------------

Summary of changes:
 dracut        |   66 ++++++++++++++++++++++++++++++++-----------------=
-------
 dracut-logger |   26 +++++++++++-----------
 2 files changed, 51 insertions(+), 41 deletions(-)


--=20
dracut - Initramfs generator using udev
