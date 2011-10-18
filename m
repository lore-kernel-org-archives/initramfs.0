From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 01/10] features: RUNDIR, imgdir, prefix, prefix_mnt and related changes
Date: Tue, 18 Oct 2011 20:33:17 +0200
Message-ID: <1318962806-24000-2-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

1) $prefix, $prefix_mnt

The prefix itself (and new prefix_mnt option) is used only during /run --move
(pre-pivot, preiously --bind), while internally - dracut files and /run are
kept _separately_ in $imgdir and $rundir.

$prefix is sanitized before use, and its final (adjusted) value is always
relative to /run (not being under /run has little point). If user provided
$prefix doesn't start with /run, or consists only of /run - it's assumed to be
/run relative. Otherwise (2 or more components and beginning with /run) it's
assumed to be absolute.

$prefix_mnt allows us to request tmpfs mount at $newrun/$prefix, before copying
dracut tree.

2) $RUNDIR (inside init only), $imgdir

The crux of changes are these two. Internal split, which previously was based
on $prefix is now based on $imgdir. All /run references from $imgdir point to
/run, which inside init is adjusted to /run -> $RUNDIR. All tmp references
point to just initramfs root's /tmp (as we don't care about the junk after
pivot).

This gives us decoupled runtime tree and dracut image tree. The latter can be
installed if $prefix is set or completely ignored. runtime is always --moved.
Furthermore, $RUNDIR is symlinked from run, so it can be easily kept fully
functional, with trivial symlink adjustment.

Everything in imgdir is symlinked from initramfs's root (similary as it's been
done until now).

All inst*() functions are aware of $imgdir; imgdir, prefix, prefix_mnt and
newroot are exported, and also available in init (after uppercasing, sourced
from simple config file).

Of course, /tmp and /run stuff has to be set differently during installation
phase (e.g. ..../var/run -> ${initdir}/run, etc.) and differenty during
initramfs execution (e.g. ..../var/run -> /run). In dracut script, it's
respectively "initial sewing pass" and "final sewing pass". The latter one also
verifies if all symlinks are valid.

This way of handling $prefix opens path to making it runtime argument (e.g.
rd.prefix).

3) /run ($RUNDIR) move

/run is moved to either $NEWROOT/run or if not possible - to /dev/.run (with
/dev/.initramfs -> .run/initramfs symlink). If $prefix is specified, contents
of $imgdir are copied to the $NEWRUN/$prefix or alternatively (if $prefix_mnt
is set), tmpfs is mounted at $NEWRUN/$prefix and then the $imgdir is copied;
init will refuse overmount, if the directory is already present.

4) udev and /dev/.udev vs /run/udev

There's possibility, that sufficiently new udev will prefer /run during
initramfs stage, while host may still be not run ready. This might lead to
losing certain db entries (e.g. lvm's). If we detect such situation, contents
of /run/udev are moved to /dev/.udev before pivoting.

5) enforcing options of premounted directories

For special directories - /proc, /sys, etc. - as we should assure that the
actual mount options are sane. Though the only realistically pre-mountable
thing is /dev (for now at least).

6) other smaller changes:

 - copying cp -a -t <dst> . after cd <src>, instead of <dst> <src>/* - as this
   also handles .* files (otherwise we would have to tinker with some crude
   globbing and/or dotglob)
 - We don't try to mimic host's directory layout anymore (if some directories
   are symlinked, which is rarely the case either way and serves little
   purpose)
 - removed certain mkdirs, that are guaranteed to be handled by dracut
---
 dracut                           |  115 +++++++++++++++++++------------
 dracut-functions                 |   50 +++++++-------
 modules.d/99base/init            |  137 ++++++++++++++++++++++++--------------
 modules.d/99base/module-setup.sh |   13 ++--
 4 files changed, 189 insertions(+), 126 deletions(-)

diff --git a/dracut b/dracut
index 205f5d1..1d5f2f4 100755
--- a/dracut
+++ b/dracut
@@ -53,7 +53,11 @@ Creates initial ramdisk images for preloading modules
   --no-kernel           Do not install kernel drivers and firmware files
   --strip               Strip binaries in the initramfs
   --nostrip             Do not strip binaries in the initramfs (default)
-  --prefix [DIR]        Prefix initramfs files with [DIR]
+  --prefix [DIR]        Prefix initramfs files with [DIR]. If DIR doesn't
+                        start with /run (or if it's the only component), it's
+                        assumed to be relative to /run.
+  --prefix_mnt          Copy initramfs into additional tmpfs mount, instead of
+                        directly into prefix subdirectory.
   --noprefix            Do not prefix initramfs files (default)
   --mdadmconf           Include local /etc/mdadm.conf
   --nomdadmconf         Do not include local /etc/mdadm.conf
@@ -222,6 +226,7 @@ while (($# > 0)); do
         --strip)       do_strip_l="yes";;
         --nostrip)     do_strip_l="no";;
         --noprefix)    prefix_l="/";;
+        --prefix_mnt)  prefix_mnt_l="yes";;
         --mdadmconf)   mdadmconf_l="yes";;
         --nomdadmconf) mdadmconf_l="no";;
         --lvmconf)     lvmconf_l="yes";;
@@ -378,8 +383,6 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 
 [[ $drivers_dir_l ]] && drivers_dir=$drivers_dir_l
 [[ $do_strip_l ]] && do_strip=$do_strip_l
-[[ $prefix_l ]] && prefix=$prefix_l
-[[ $prefix = "/" ]] && unset prefix
 [[ $hostonly_l ]] && hostonly=$hostonly_l
 [[ $use_fstab_l ]] && use_fstab=$use_fstab_l
 [[ $mdadmconf_l ]] && mdadmconf=$mdadmconf_l
@@ -390,6 +393,7 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 [[ $compress_l ]] && compress=$compress_l
 [[ $show_modules_l ]] && show_modules=$show_modules_l
 [[ $nofscks_l ]] && nofscks="yes"
+[[ $prefix_mnt_l ]] && prefix_mnt="yes"
 # eliminate IFS hackery when messing with fw_dir
 fw_dir=${fw_dir//:/ }
 
@@ -428,6 +432,19 @@ fi
 dracutfunctions=$dracutbasedir/dracut-functions
 export dracutfunctions
 
+# sanitize and handle prefix.
+# If /run is the only component, or if $prefix_l doesn't start with /run, then
+# the path is assumed to be relative to /run, otherwise it's absolute.
+# Final prefix is always set as relative to /run
+if [[ "$prefix_l" =~ [[:alnum:]] ]]; then
+    prefix=$(normalize_path "/$prefix_l")
+    prefix=${prefix#/}
+    prefix=${prefix#run/}
+else
+    unset prefix
+    unset prefix_mnt
+fi
+
 ddebug "Executing $0 $dracut_args"
 
 [[ $do_list = yes ]] && {
@@ -494,6 +511,7 @@ readonly initdir=$(mktemp --tmpdir=/var/tmp/ -d -t initramfs.XXXXXX)
     dfatal "mktemp failed."
     exit 1
 }
+readonly imgdir=/_img newroot=/sysroot
 
 # clean up after ourselves no matter how we die.
 trap 'ret=$?;[[ $keep ]] && echo "Not removing $initdir." >&2 || rm -rf "$initdir";exit $ret;' EXIT
@@ -508,48 +526,30 @@ export initdir dracutbasedir dracutmodules drivers \
     add_drivers mdadmconf lvmconf filesystems \
     use_fstab libdir usrlibdir fscks nofscks \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
-    debug
-
-# Create some directory structure first
-[[ $prefix ]] && mkdir -m 0755 -p "${initdir}${prefix}"
-
-[[ -h /lib ]] || mkdir -m 0755 -p "${initdir}${prefix}/lib"
-[[ $prefix ]] && ln -sfn "${prefix#/}/lib" "$initdir/lib"
-
-if [[ $prefix ]]; then
-    for d in bin etc lib "$libdir" sbin tmp usr var; do
-        ln -sfn "${prefix#/}/${d#/}" "$initdir/$d"
-    done
-fi
+    debug imgdir prefix prefix_mnt newroot
 
+# initial directory layout + host safe symlinks
 if [[ $kernel_only != yes ]]; then
-    for d in bin etc lib "$libdir" sbin tmp usr var usr/bin usr/sbin; do
-        [[ -e "${initdir}${prefix}/$d" ]] && continue
-        if [ -h "/$d" ]; then
-            inst "/$d" "${prefix}/$d"
-        else
-            mkdir -m 0755 -p "${initdir}${prefix}/$d"
-        fi
-    done
-
-    for d in dev proc sys sysroot root run run/lock run/initramfs; do
-        if [ -h "/$d" ]; then
-            inst "/$d"
-        else
-            mkdir -m 0755 -p "$initdir/$d"
-        fi
+    mkdir -m 0755 -p \
+        "${initdir}${imgdir}"/{bin,etc,lib,${libdir#/},sbin,var,usr/{bin,sbin}} \
+        "${initdir}"/{dev,proc,sys,${newroot#/},root,run/{lock,initramfs},tmp}
+
+    # host safe symlinks (will be adjusted later), needed during inst*() calls
+    ln -sfn "${initdir}"/tmp      "${initdir}${imgdir}"/tmp
+    ln -sfn "${initdir}"/tmp      "${initdir}${imgdir}"/var/tmp
+    ln -sfn "${initdir}"/run      "${initdir}${imgdir}"/run
+    ln -sfn "${initdir}"/run      "${initdir}${imgdir}"/var/run
+    ln -sfn "${initdir}"/run/lock "${initdir}${imgdir}"/var/lock
+    # initial sewing pass
+    for d in bin etc lib "${libdir#/}" sbin var usr; do
+        ln -sfn "${imgdir#/}/$d" "${initdir}/$d"
     done
-
-    ln -sfn /run "$initdir/var/run"
-    ln -sfn /run/lock "$initdir/var/lock"
 else
-    for d in lib "$libdir"; do
-        [[ -e "${initdir}${prefix}/$d" ]] && continue
-        if [ -h "/$d" ]; then
-            inst "/$d" "${prefix}/$d"
-        else
-            mkdir -m 0755 -p "${initdir}${prefix}/$d"
-        fi
+    mkdir -m 0755 -p "${initdir}${imgdir}/"{lib,${libdir#/}}
+
+    # initial sewing pass
+    for d in lib "${libdir#/}"; do
+        ln -sfn "${imgdir#/}/$d" "${initdir}/$d"
     done
 fi
 
@@ -593,18 +593,20 @@ while pop include_src src && pop include_target tgt; do
             inst $src $tgt
         else
             ddebug "Including directory: $src"
-            mkdir -p "${initdir}/${tgt}"
+            mkdir -p "${initdir}${imgdir}/${tgt}"
             # check for preexisting symlinks, so we can cope with the
             # symlinks to $prefix
             for i in "$src"/*; do
                 [[ -e "$i" || -h "$i" ]] || continue
-                s=${initdir}/${tgt}/${i#$src/}
+                s=${initdir}${imgdir}/${tgt}/${i#$src/}
                 if [[ -d "$i" ]]; then
                     if ! [[ -e "$s" ]]; then
                         mkdir -m 0755 -p "$s"
                         chmod --reference="$i" "$s"
                     fi
-                    cp -a -t "$s" "$i"/*
+                    pushd "$i" &>/dev/null
+                    cp -a -t "$s" .
+                    popd &>/dev/null
                 else
                     cp -a -t "$s" "$i"
                 fi
@@ -620,7 +622,6 @@ while pop install_items items; do
 done
 unset item
 
-
 if [[ $kernel_only != yes ]]; then
     # make sure that library links are correct and up to date
     for f in /etc/ld.so.conf /etc/ld.so.conf.d/*; do
@@ -672,6 +673,30 @@ if strstr "$modules_loaded" " fips " && command -v prelink >/dev/null; then
     done
 fi
 
+# final sewing pass
+# remove helper /run & /tmp links, set symlinks to match initramfs's root, link
+# remaining directories (if any)
+if [[ $kernel_only != yes ]]; then
+    rm -f             "${initdir}${imgdir}"/{run,tmp}
+    ln -sfn /tmp      "${initdir}${imgdir}"/var/tmp
+    ln -sfn /run      "${initdir}${imgdir}"/var/run
+    ln -sfn /run/lock "${initdir}${imgdir}"/var/lock
+fi
+for d in "${initdir}${imgdir}"/*; do
+    s="${initdir}/${d##*/}"
+    if [[ -h ${s} ]]; then
+        # verify if everything is fine
+        t=$(readlink -e "${s}")
+        if [[ $t != $d ]]; then
+            dfatal "dracut: symlink mismatch ${d##*/} -/-> ${d#${initdir}/}"
+            exit 1
+        fi
+    else
+        ln -sfn "${imgdir#/}/${d##*/}" "${s}"
+    fi
+done
+
+# create the image
 if ! ( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet| \
     $compress > "$outfile"; ); then
     dfatal "dracut: creation of $outfile failed"
diff --git a/dracut-functions b/dracut-functions
index 1ef5269..3b971c7 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -269,13 +269,13 @@ check_vol_slaves() {
 
 # Install a directory, keeping symlinks as on the original system.
 # Example: if /lib points to /lib64 on the host, "inst_dir /lib/file"
-# will create ${initdir}/lib64, ${initdir}/lib64/file,
-# and a symlink ${initdir}/lib -> lib64.
+# will create ${initdir}${imgdir}/lib64, ${initdir}${imgdir}/lib64/file,
+# and a symlink ${initdir}${imgdir}/lib -> lib64.
 inst_dir() {
-    [[ -e ${initdir}"$1" ]] && return 0  # already there
+    [[ -e ${initdir}${imgdir}"$1" ]] && return 0  # already there
 
     local _dir="$1" _part="${1%/*}" _file
-    while [[ "$_part" != "${_part%/*}" ]] && ! [[ -e "${initdir}${_part}" ]]; do
+    while [[ "$_part" != "${_part%/*}" ]] && ! [[ -e "${initdir}${imgdir}${_part}" ]]; do
         _dir="$_part $_dir"
         _part=${_part%/*}
     done
@@ -290,12 +290,12 @@ inst_dir() {
             inst_dir "$target"
             inst_symlink "$_file"
         else
-            [[ -h ${initdir}$_file ]] && _file=$(readlink "${initdir}$_file")
+            [[ -h ${initdir}${imgdir}$_file ]] && _file=$(readlink "${initdir}${imgdir}$_file")
             # create directory
-            mkdir -m 0755 -p "${initdir}$_file" || return 1
+            mkdir -m 0755 -p "${initdir}${imgdir}$_file" || return 1
             if [[ -d "$_file" ]]; then
-                chmod --reference="$_file" "${initdir}$_file"
-                chmod u+w "${initdir}$_file"
+                chmod --reference="$_file" "${initdir}${imgdir}$_file"
+                chmod u+w "${initdir}${imgdir}$_file"
             fi
         fi
     done
@@ -303,15 +303,15 @@ inst_dir() {
 
 # $1 = file to copy to ramdisk
 # $2 (optional) Name for the file on the ramdisk
-# Location of the image dir is assumed to be $initdir
+# Location of the image dir is assumed to be ${initdir}${imgdir}
 # We never overwrite the target if it exists.
 inst_simple() {
     [[ -f $1 ]] || return 1
 
     local _src=$1 target="${2:-$1}"
-    if ! [[ -d ${initdir}$target ]]; then
-        [[ -e ${initdir}$target ]] && return 0
-        [[ -h ${initdir}$target ]] && return 0
+    if ! [[ -d ${initdir}${imgdir}$target ]]; then
+        [[ -e ${initdir}${imgdir}$target ]] && return 0
+        [[ -h ${initdir}${imgdir}$target ]] && return 0
         inst_dir "${target%/*}"
     fi
     # install checksum files also
@@ -319,7 +319,7 @@ inst_simple() {
         inst "${_src%/*}/.${_src##*/}.hmac" "${target%/*}/.${target##*/}.hmac"
     fi
     ddebug "Installing $_src"
-    cp --sparse=always -pfL "$_src" "${initdir}$target" 
+    cp --sparse=always -pfL "$_src" "${initdir}${imgdir}$target"
 }
 
 # find symlinks linked to given library file
@@ -352,7 +352,7 @@ rev_lib_symlinks() {
 # is referenced.
 inst_library() {
     local _src=$1 _dest=${2:-$1} _lib _reallib _symlink
-    [[ -e $initdir$_dest ]] && return 0
+    [[ -e ${initdir}${imgdir}$_dest ]] && return 0
     if [[ -L $_src ]]; then
         # install checksum files also
         if [[ -e "${_src%/*}/.${_src##*/}.hmac" ]]; then
@@ -361,14 +361,14 @@ inst_library() {
         _reallib=$(readlink -f "$_src")
         inst_simple "$_reallib" "$_reallib"
         inst_dir "${_dest%/*}"
-        ln -sfn $(convert_abs_rel "${_dest}" "${_reallib}") "${initdir}${_dest}"
+        ln -sfn $(convert_abs_rel "${_dest}" "${_reallib}") "${initdir}${imgdir}${_dest}"
     else
         inst_simple "$_src" "$_dest"
     fi
 
     # Create additional symlinks.  See rev_symlinks description.
     for _symlink in $(rev_lib_symlinks $_src) $(rev_lib_symlinks $_reallib); do
-        [[ ! -e $initdir$_symlink ]] && {
+        [[ ! -e ${initdir}${imgdir}$_symlink ]] && {
             ddebug "Creating extra symlink: $_symlink"
             inst_symlink $_symlink
         }
@@ -396,7 +396,7 @@ inst_binary() {
     _bin=$(find_binary "$1") || return 1
     _target=${2:-$_bin}
     inst_symlink $_bin $_target && return 0
-    [[ -e $initdir$_target ]] && return 0
+    [[ -e ${initdir}${imgdir}$_target ]] && return 0
 
     # If the binary being installed is also a library, add it to the loop.
     _so_regex='([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*)'
@@ -414,7 +414,7 @@ inst_binary() {
         fi
         [[ $_line =~ $_so_regex ]] || continue
         _file=${BASH_REMATCH[1]}
-        [[ -e ${initdir}$_file ]] && continue
+        [[ -e ${initdir}${imgdir}$_file ]] && continue
 
         # See if we are loading an optimized version of a shared lib.
         if [[ $_file =~ $_lib_regex ]]; then
@@ -451,7 +451,7 @@ inst_script() {
 
 # same as above, but specialized for symlinks
 inst_symlink() {
-    local _src=$1 _target=$initdir${2:-$1} _realsrc
+    local _src=$1 _target=${initdir}${imgdir}${2:-$1} _realsrc
     [[ -L $1 ]] || return 1
     [[ -L $_target ]] && return 0
     _realsrc=$(readlink -f "$_src")
@@ -459,7 +459,7 @@ inst_symlink() {
     if [[ -d $_realsrc ]]; then
         inst_dir "$_realsrc"
     else
-        inst "$_realsrc" && mkdir -m 0755 -p "${_target%/*}" 
+        inst "$_realsrc" && mkdir -m 0755 -p "${_target%/*}"
     fi
     if [[ -e "${_src}" ]]; then
         ln -sfn $(convert_abs_rel "${_src}" "${_realsrc}") "$_target"
@@ -604,9 +604,9 @@ inst_decompress() {
             _realsrc="$(readlink -f ${_src})" # symlink target with extension
             _dst="${_src%.*}" # symlink without extension
             _realdst="${_realsrc%.*}" # symlink target without extension
-            mksubdirs "${initdir}/${_src}"
+            mksubdirs "${initdir}${imgdir}/${_src}"
             # Create symlink without extension to target without extension.
-            ln -sfn "${_realdst}" "${initdir}/${_dst}"
+            ln -sfn "${_realdst}" "${initdir}${imgdir}/${_dst}"
         fi
 
         # If the source is symlink we operate on its target.
@@ -614,7 +614,7 @@ inst_decompress() {
         inst ${_src}
         # Decompress with chosen tool.  We assume that tool changes name e.g.
         # from 'name.gz' to 'name'.
-        ${_cmd} "${initdir}${_src}"
+        ${_cmd} "${initdir}${imgdir}${_src}"
     done
 }
 
@@ -787,7 +787,7 @@ check_module_dir() {
 # $1 = full path to kernel module to install
 install_kmod_with_fw() {
     # no need to go further if the module is already installed
-    [[ -e "${initdir}/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" ]] \
+    [[ -e "${initdir}${imgdir}/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" ]] \
         && return 0
     inst_simple "$1" "/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" \
         || return $?
@@ -915,7 +915,7 @@ instmods() {
 
                 # if we are already installed, skip this module and go on
                 # to the next one.
-                [[ -f $initdir/$1 ]] && return
+                [[ -f ${initdir}${imgdir}/$1 ]] && return
 
                 # If we are building a host-specific initramfs and this
                 # module is not already loaded, move on to the next one.
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 06d61a8..0970a48 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -66,25 +66,31 @@ emergency_shell()
     fi
 }
 
-NEWROOT="/sysroot"
-[ -d $NEWROOT ] || mkdir -p -m 0755 $NEWROOT
-
 trap "emergency_shell Signal caught!" 0
 OLDPATH=$PATH
 PATH=/usr/sbin:/usr/bin:/sbin:/bin
 export PATH
 
 RD_DEBUG=""
+. /etc/dracut-init.conf
 . /lib/dracut-lib.sh
 
 [ -c /dev/null ] || mknod -m 0666 /dev/null c 1 3
 
-# mount some important things
-[ ! -d /proc/self ] && \
-    mount -t proc -o nosuid,noexec,nodev proc /proc >/dev/null 2>&1
+# mount some important things; if something is already mounted,
+# we sanitize mount options by remounting
+# note: although -t would be ignored during remount, we play
+# it safe and make sure -t is not specified in such case
+# note: at this point, only /dev can be premounted by kernel, so
+# maybe just skip those checks altogether ?
+
+_opt="-o nosuid,noexec,nodev"; _fs="-t proc"
+[ -d /proc/self ] && { _opt="$_opt,remount"; unset _fs; }
+mount $_fs $_opt proc /proc >/dev/null 2>&1
 
-[ ! -d /sys/kernel ] && \
-    mount -t sysfs -o nosuid,noexec,nodev sysfs /sys >/dev/null 2>&1
+_opt="-o nosuid,noexec,nodev"; _fs="-t sysfs"
+[ -d /sys/kernel ] && { _opt="$_opt,remount"; unset _fs; }
+mount $_fs $_opt sysfs /sys >/dev/null 2>&1
 
 if [ -x /lib/systemd/systemd-timestamp ]; then
     RD_TIMESTAMP=$(/lib/systemd/systemd-timestamp)
@@ -101,44 +107,50 @@ if [ "$RD_DEBUG" = "yes" ]; then
     [ -n "$a" ] && [ $a -ge 8 ] && unset DRACUT_QUIET
 fi
 
-if ! ismounted /dev; then
-    # try to mount devtmpfs
-    if ! mount -t devtmpfs -o mode=0755,nosuid devtmpfs /dev >/dev/null 2>&1; then
-        # if it failed fall back to normal tmpfs
-        mount -t tmpfs -o mode=0755,nosuid tmpfs /dev >/dev/null 2>&1
-        # Make some basic devices first, let udev handle the rest
-        mknod -m 0666 /dev/null c 1 3
-        mknod -m 0666 /dev/ptmx c 5 2
-        mknod -m 0600 /dev/console c 5 1
-        mknod -m 0660 /dev/kmsg c 1 11
-    fi
+_opt="-o mode=0755,nosuid,exec"; _fs="-t devtmpfs"
+ismounted /dev && { _opt="$_opt,remount"; unset _fs; }
+if ! mount $_fs $_opt devtmpfs /dev >/dev/null 2>&1; then
+    # if it failed (remount can't fail - no need to redo $_opt), fall back to
+    # normal tmpfs
+    mount -t tmpfs $_opt tmpfs /dev >/dev/null 2>&1
+    # Make some basic devices first, let udev handle the rest
+    mknod -m 0666 /dev/null c 1 3
+    mknod -m 0666 /dev/ptmx c 5 2
+    mknod -m 0600 /dev/console c 5 1
+    mknod -m 0660 /dev/kmsg c 1 11
 fi
 
-# prepare the /dev directory
+# prepare the /dev directory (note: newer udevd takes care of it automatically)
 [ ! -h /dev/fd ] && ln -s /proc/self/fd /dev/fd >/dev/null 2>&1
 [ ! -h /dev/stdin ] && ln -s /proc/self/fd/0 /dev/stdin >/dev/null 2>&1
 [ ! -h /dev/stdout ] && ln -s /proc/self/fd/1 /dev/stdout >/dev/null 2>&1
 [ ! -h /dev/stderr ] && ln -s /proc/self/fd/2 /dev/stderr >/dev/null 2>&1
 
-if ! ismounted /dev/pts; then
-    mkdir -m 0755 /dev/pts
-    mount -t devpts -o gid=5,mode=620,noexec,nosuid devpts /dev/pts >/dev/null 2>&1
-fi
-
-if ! ismounted /dev/shm; then
-    mkdir -m 0755 /dev/shm
-    mount -t tmpfs -o mode=1777,nosuid,nodev tmpfs /dev/shm >/dev/null 2>&1
-fi
-
-if ! ismounted /run; then
-    mkdir -m 0755 /newrun
-    mount -t tmpfs -o mode=0755,nosuid,nodev tmpfs /newrun >/dev/null 2>&1
-    cp -a -t /newrun /run/*
-    mount --move /newrun /run
-    rm -fr /newrun
-fi
-
-[ -d /run/initramfs ] || mkdir -p -m 0755 /run/initramfs
+_opt="-o gid=5,mode=620,noexec,nosuid"; _fs="-t devpts"
+ismounted /dev/pts && { _opt="$_opt,remount"; unset _fs; } || mkdir -m 0755 /dev/pts
+mount $_fs $_opt devpts /dev/pts >/dev/null 2>&1
+
+_opt="-o mode=1777,nosuid,nodev"; _fs="-t tmpfs"
+ismounted /dev/shm && { _opt="$_opt,remount"; unset _fs; } || mkdir -m 0755 /dev/shm
+mount $_fs $_opt tmpfs /dev/shm >/dev/null 2>&1
+
+# Prepare proper tmpfs mount for /run:
+# - /run is just a symlink to real staging area. This allows us to be
+#   independent from any mount place, with trivial symlink manipulation
+# - checking if /run is premounted, is pretty crazy in initramfs ...
+
+_opt="-o mode=0755,nosuid,nodev,exec"; _fs="-t tmpfs"
+RUNDIR=/_run
+ismounted /run && { _opt="$_opt,remount"; unset _fs; }
+mkdir -m 0755 -p $RUNDIR
+# move + remount or mount
+[ -z "$_fs" ] && mount --move /run $RUNDIR
+mount $_fs $_opt tmpfs $RUNDIR >/dev/null 2>&1
+# copy if mount
+[ -z "$_fs" ] || { cd /run; cp -a -t $RUNDIR .; cd /; }
+# set symlink
+rm -rf /run
+ln -sfn ${RUNDIR#/} /run
 
 UDEVVERSION=$(udevadm --version)
 if [ $UDEVVERSION -gt 166 ]; then
@@ -410,20 +422,43 @@ else
 fi
 [ "$RD_DEBUG" = "yes" ] && set -x
 
-if [ -d "$NEWROOT"/run ]; then
-    NEWRUN="${NEWROOT}/run"
-    mount --bind /run "$NEWRUN"
-    NEWINITRAMFSROOT="$NEWRUN/initramfs"
+# /run move, udev adjustment (if applicable), prefix handling
+if [ -d "$NEWROOT/run" ]; then
+    NEWRUN="$NEWROOT/run"
+else
+    NEWRUN=/dev/.run
+    mkdir -p -m 0755 "$NEWRUN"
+    [ -n "$PREFIX" ] && ln -sfn .run/initramfs /dev/.initramfs
+    # if initramfs's udev uses /run by default, but the host is
+    # still /run-less, we should copy udev's data to legacy
+    # /dev/.udev, so the necessary info is available for the host
+    # (e.g. lvm db entries)
+    if [ -d /run/udev/data -o -d /run/udev/db ]; then
+        mkdir -p -m 0755 /dev/.udev
+        cd /run/udev
+        cp -a -t /dev/.udev .
+        cd /
+        rm -rf /run/udev
+    fi
+fi
 
-    if [ "$NEWINITRAMFSROOT/lib" -ef "/lib" ]; then
-        for d in bin etc lib lib64 sbin tmp usr var; do
-            [ -h /$d ] && ln -fsn $NEWINITRAMFSROOT/$d /$d
-        done
+mount --move "$RUNDIR" "$NEWRUN"
+ln -sfn "${NEWRUN#/}" /run
+
+if [ -n "$PREFIX" ]; then
+    if [ -d "$NEWRUN/$PREFIX" ]; then
+        [ -n "$PREFIX_MNT" ] &&
+            warn "'$NEWRUN/$PREFIX' already exists, dracut files will be copied directly to this directory"
+        unset PREFIX_MNT
+    else
+        mkdir -p -m 0755 "$NEWRUN/$PREFIX"
     fi
-else
-    NEWRUN=/dev/.initramfs
-    mkdir -m 0755 "$NEWRUN"
-    mount --bind /run/initramfs "$NEWRUN"
+    if [ -n "$PREFIX_MNT" ]; then
+        mount -t tmpfs -o mode=0755,nosuid,nodev,exec tmpfs "$NEWRUN/$PREFIX"
+    fi
+    cd "$IMGDIR"
+    cp -a -t "$NEWRUN/$PREFIX" .
+    cd /
 fi
 
 wait_for_loginit
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index f6dc920..2a9b643 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -12,7 +12,7 @@ depends() {
 }
 
 install() {
-    local _d
+    local _d _x
     dracut_install mount mknod mkdir modprobe pidof sleep chroot \
         sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink
     dracut_install -o less
@@ -25,7 +25,6 @@ install() {
     inst "$moddir/initqueue" "/sbin/initqueue"
     inst "$moddir/loginit" "/sbin/loginit"
 
-    [ -e "${initdir}/lib" ] || mkdir -m 0755 -p ${initdir}/lib
     mkdir -m 0755 -p ${initdir}/lib/dracut
     mkdir -m 0755 -p ${initdir}/lib/dracut/hooks
     for _d in $hookdirs emergency \
@@ -33,13 +32,17 @@ install() {
         mkdir -m 0755 -p ${initdir}/lib/dracut/hooks/$_d
     done
 
-    mkdir -p ${initdir}/tmp
-
     dracut_install switch_root || dfatal "Failed to install switch_root"
 
     inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
     inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
-    mkdir -p "${initdir}/var"
+
     [ -x /lib/systemd/systemd-timestamp ] && inst /lib/systemd/systemd-timestamp
+
+    # export certain settings to init
+    for _d in newroot imgdir prefix prefix_mnt; do
+        _x=$(echo $_d | tr "a-z" "A-Z")
+        [ -n "$_d" ] && echo "${_x}=${!_d}" >>${initdir}/etc/dracut-init.conf
+    done
 }
 
-- 
1.7.5.3
