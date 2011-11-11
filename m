From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 13/10] features: RUNDIR, imgdir, ... [update 2]
Date: Fri, 11 Nov 2011 16:45:56 +0100
Message-ID: <1321026356-7606-1-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

- don't use cp -t (due to busybox's cp)
- add intermediate link to image's tree, to simplify life in init;
  this allows us to switch whole image tree with single 'ln' manipulation,
  instead of going in loop through all /bin, /sbin, ... symlinks;
  we employ that early (see the next point) and before /run move (to not
  lose access to binaries)
- create $prefix (and $prefix_mnt) early, so everything is de-facto
  started from /run/$prefix
- keep /tmp and /var/tmp inside image tree
- simplify det_lib_paths() - make it essentially the same as before
  an earlier patch, but keep it as a separate function
- add a few comments and corner cases fixups

---
 dracut                           |   31 ++++++++++--------
 dracut-functions                 |   29 ++++++----------
 modules.d/99base/init            |   64 ++++++++++++++++++++++---------------
 modules.d/99base/module-setup.sh |    2 +-
 4 files changed, 67 insertions(+), 59 deletions(-)

diff --git a/dracut b/dracut
index 72af2c0..e26e0c3 100755
--- a/dracut
+++ b/dracut
@@ -502,7 +502,7 @@ readonly initdir=$(mktemp --tmpdir=/var/tmp/ -d -t initramfs.XXXXXX)
     dfatal "mktemp failed."
     exit 1
 }
-readonly imgdir=/_img newroot=/sysroot
+readonly imgdir=/_img imglnk=/__img newroot=/sysroot
 
 # clean up after ourselves no matter how we die.
 trap 'ret=$?;[[ $keep ]] && echo "Not removing $initdir." >&2 || rm -rf "$initdir";exit $ret;' EXIT
@@ -517,34 +517,38 @@ export initdir dracutbasedir dracutmodules drivers \
     add_drivers mdadmconf lvmconf filesystems \
     use_fstab libdir usrlibdir fscks nofscks cttyhack \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
-    debug imgdir prefix prefix_mnt newroot
+    debug imgdir imglnk prefix prefix_mnt newroot
 
 # initial directory layout + host safe symlinks
 if [[ $kernel_only != yes ]]; then
-    for d in /{bin,sbin,etc,lib{,64},var,usr{,/{bin,sbin,lib{,64}}}}; do
+    # directories inside ${initdir}${imgdir}
+    for d in /{bin,sbin,etc,lib{64,},var{,/tmp},usr{,/{bin,sbin,lib{64,}}},tmp}; do
         if [[ -h $d ]]; then inst_symlink $d
         elif [[ -d $d ]]; then inst_dir $d; fi
     done
 
+    # directories inside ${initdir}
     mkdir -m 0755 -p \
-        "${initdir}"/{dev,proc,sys,${newroot#/},root,run{,/{lock,initramfs}},tmp}
+        "${initdir}"/{dev,proc,sys,run{,/{lock,initramfs}},root,${newroot#/}}
 
     # host safe symlinks (will be adjusted later), needed during inst*() calls
-    ln -sfn "${initdir}"/tmp      "${initdir}${imgdir}"/tmp
-    ln -sfn "${initdir}"/tmp      "${initdir}${imgdir}"/var/tmp
     ln -sfn "${initdir}"/run      "${initdir}${imgdir}"/run
     ln -sfn "${initdir}"/run      "${initdir}${imgdir}"/var/run
     ln -sfn "${initdir}"/run/lock "${initdir}${imgdir}"/var/lock
 else
-    for d in /lib{,64}; do
+    for d in /lib{64,}; do
         if [[ -h $d ]]; then inst_symlink $d
         elif [[ -d $d ]]; then inst_dir $d; fi
     done
 fi
+
 # initial sewing pass
+# go through intermediate symlink (${imglnk}) - this greatly simplifies our life
+# inside init
+ln -sfn "${imgdir#/}" "${initdir}${imglnk}"
 for d in "${initdir}${imgdir}"/*; do
     if [[ ! -e "${initdir}/${d##*/}" ]]; then
-        ln -sfn "${imgdir#/}/${d##*/}" "${initdir}/${d##*/}"
+        ln -sfn "${imglnk#/}/${d##*/}" "${initdir}/${d##*/}"
     fi
 done
 
@@ -669,11 +673,10 @@ if strstr "$modules_loaded" " fips " && command -v prelink >/dev/null; then
 fi
 
 # final sewing pass
-# remove helper /run & /tmp links, set symlinks to match initramfs's root, link
+# remove helper /run link, set symlinks to match initramfs's root, link
 # remaining directories (if any)
 if [[ $kernel_only != yes ]]; then
-    rm -f             "${initdir}${imgdir}"/{run,tmp}
-    ln -sfn /tmp      "${initdir}${imgdir}"/var/tmp
+    rm -f             "${initdir}${imgdir}"/run
     ln -sfn /run      "${initdir}${imgdir}"/var/run
     ln -sfn /run/lock "${initdir}${imgdir}"/var/lock
 fi
@@ -682,12 +685,12 @@ for d in "${initdir}${imgdir}"/*; do
     if [[ -h ${s} ]]; then
         # verify if everything is fine
         t=$(readlink "${s}")
-        if [[ $t != ${d#${initdir}/} ]]; then
-            dfatal "dracut: symlink mismatch ${d##*/} -/-> ${d#${initdir}/}"
+        if [[ $t != ${imglnk#/}/${d##*/} ]]; then
+            dfatal "dracut: symlink mismatch ${d##*/} -/-> ${imglnk#/}/${d##*/}"
             exit 1
         fi
     elif [[ ! -e ${s} ]]; then
-        ln -sfn "${d#${initdir}/}" "${s}"
+        ln -sfn "${imglnk#/}/${d##*/}" "${s}"
     fi
 done
 
diff --git a/dracut-functions b/dracut-functions
index 7b6aa5a..0298585 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -959,23 +959,16 @@ instmods() {
     return $?
 }
 
-# determine lib paths in specified prefix
-# if they point to the same, ignore the one that is a symlink
-# prefer lib64 over lib
+# determine lib paths in specified prefix ($1)
+# order of preference: lib64, lib, lib32
 function det_lib_paths() {
-    local _lib _d _d64
-    _d=$(readlink -e "$1/lib")
-    _d64=$(readlink -e "$1/lib64")
-    if [[ $_d = $_d64 ]]; then
-        [[ -h $1/lib ]] && unset _d
-        [[ -h $1/lib64 ]] && unset _d64
-    fi
-    if [[ -n $_d64 ]]; then
-        _lib=$1/lib64
-    elif [[ -n $_d ]]; then
-        _lib=$1/lib
-    else
-        return 1
-    fi
-    echo "$_lib"
+    local _lib
+
+    for _lib in "$1"/lib{64,}; do
+        if [[ -d $_lib ]]; then
+            echo "$_lib"
+            return 0
+        fi
+    done
+    return 1
 }
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 0397e36..00fcc27 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -81,20 +81,44 @@ mount $_fs $_opt tmpfs /dev/shm >/dev/null 2>&1
 # Prepare proper tmpfs mount for /run:
 # - /run is just a symlink to real staging area. This allows us to be
 #   independent from any mount place, with trivial symlink manipulation
-# - checking if /run is premounted, is pretty crazy in initramfs ...
-
+# - it handles both: if /run is present with content and/or if it's mounted
 _opt="-o mode=0755,nosuid,nodev,exec"; _fs="-t tmpfs"
 RUNDIR=/_run
 ismounted /run && { _opt="$_opt,remount"; unset _fs; }
-mkdir -m 0755 -p $RUNDIR
+mkdir -m 0755 -p "$RUNDIR"
 # move + remount or mount
-[ -z "$_fs" ] && mount --move /run $RUNDIR
-mount $_fs $_opt tmpfs $RUNDIR >/dev/null 2>&1
+[ -z "$_fs" ] && mount --move /run "$RUNDIR"
+mount $_fs $_opt tmpfs "$RUNDIR" >/dev/null 2>&1
 # copy if mount
-[ -z "$_fs" ] || { cd /run; cp -a -t $RUNDIR .; cd /; }
+[ -n "$_fs" ] && { cd /run; cp -a . "$RUNDIR"; cd /; }
 # set symlink
 rm -rf /run
-ln -sfn ${RUNDIR#/} /run
+ln -sfn "${RUNDIR#/}" /run
+
+# Prepare (if applicable) image tree inside $PREFIX under /run; we do it
+# here, as we want to run everything de-facto from /run/$PREFIX/...
+if [ -n "$PREFIX" ]; then
+    mkdir -p -m 0755 "/run/.prefix"
+    cd "$IMGLNK"
+    cp -a . "/run/.prefix"
+    if [ -d "/run/$PREFIX" ]; then
+        cd "/run/$PREFIX"; cp -a . "/run/.prefix"; cd /
+        umount "/run/$PREFIX" >/dev/null 2>&1
+        rm -rf "/run/$PREFIX"
+    fi
+    if [ -n "$PREFIX_MNT" ]; then
+        mkdir -p -m 0755 "/run/$PREFIX"
+        mount -t tmpfs -o mode=0755,nosuid,nodev,exec tmpfs "/run/$PREFIX"
+        cd "/run/.prefix"; cp -a . "/run/$PREFIX"; cd /
+        rm -rf "/run/.prefix"
+    else
+        _tgt="/run/$PREFIX"
+        mkdir -p -m 0755 "${_tgt%/*}"
+        mv "/run/.prefix" "$_tgt"
+    fi
+    # switch intermediary link to the image tree we actually want to use
+    ln -sfn "run/$PREFIX" "$IMGLNK"
+fi
 
 UDEVVERSION=$(udevadm --version)
 if [ $UDEVVERSION -gt 166 ]; then
@@ -374,7 +398,7 @@ else
 fi
 [ "$RD_DEBUG" = "yes" ] && set -x
 
-# /run move, udev adjustment (if applicable), prefix handling
+# /run move, udev adjustment (if applicable)
 if [ -d "$NEWROOT/run" ]; then
     NEWRUN="$NEWROOT/run"
 else
@@ -388,30 +412,18 @@ else
     if [ -d /run/udev/data -o -d /run/udev/db ]; then
         mkdir -p -m 0755 /dev/.udev
         cd /run/udev
-        cp -a -t /dev/.udev .
+        cp -a . /dev/.udev
         cd /
         rm -rf /run/udev
     fi
 fi
 
-mount --move "$RUNDIR" "$NEWRUN"
+# if we earlier moved away from IMGDIR, go back to it - or we lose access to
+# binaries briefly
+[ -n "$PREFIX" ] && ln -sfn "${IMGDIR#/}" "$IMGLNK"
 ln -sfn "${NEWRUN#/}" /run
-
-if [ -n "$PREFIX" ]; then
-    if [ -d "$NEWRUN/$PREFIX" ]; then
-        [ -n "$PREFIX_MNT" ] &&
-            warn "'$NEWRUN/$PREFIX' already exists, dracut files will be copied directly to this directory"
-        unset PREFIX_MNT
-    else
-        mkdir -p -m 0755 "$NEWRUN/$PREFIX"
-    fi
-    if [ -n "$PREFIX_MNT" ]; then
-        mount -t tmpfs -o mode=0755,nosuid,nodev,exec tmpfs "$NEWRUN/$PREFIX"
-    fi
-    cd "$IMGDIR"
-    cp -a -t "$NEWRUN/$PREFIX" .
-    cd /
-fi
+mount --move "$RUNDIR" "$NEWRUN"
+[ -n "$PREFIX" ] && ln -sfn "${NEWRUN#/}/$PREFIX" "$IMGLNK"
 
 wait_for_loginit
 
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index 4c64bca..2a59699 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -41,7 +41,7 @@ install() {
     [ -x /lib/systemd/systemd-timestamp ] && inst /lib/systemd/systemd-timestamp
 
     # export certain settings to init
-    for _d in newroot imgdir prefix prefix_mnt; do
+    for _d in newroot imgdir imglnk prefix prefix_mnt; do
         _x=$(echo $_d | tr "a-z" "A-Z")
         [ -n "$_d" ] && echo "${_x}=${!_d}" >>${initdir}/etc/dracut-init.conf
     done
-- 
1.7.7.1
