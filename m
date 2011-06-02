From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 1/4] implement fs-lib, squash a few bugs that were part of det_fs/wrap_fsck
Date: Thu,  2 Jun 2011 23:22:12 +0200
Message-ID: <1307049735-2345-2-git-send-email-soltys@ziu.info>
References: <1307049735-2345-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1307049735-2345-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

To not pollute dracut-lib.sh, all the fsck related functions were moved
to fs-lib.sh. The functions available are as follows:

- fsck_single

this will detect/verify filesystem, check if it has necessary tools and
check the filesystem respecting additional flags (if any), using
specific "driver" (or falling back to generic one). Currently
available: fsck_drv_{com,xfs,std}. 'com' is used for tools following
typical subset of options/return codes (e.g. ext, jfs), 'std' is used
for "unknown" fs and doesn't assume it can be run non-interactively.

Please see comments around the code for more info.

- fsck_batch

this will check provided list of the devices;

Both of the above functions will fake empty fstab, to make generic fsck
not complain too much (excact devices are always provided on the command
line).

"Known" filesystems currently: ext234, reiser, jfs, xfs

- det_fs

Small bug fixed - as this function is meant to be called in $(), it may
not be verbose.
Current behaviour is:
 - if detection is successful, use its result
 - if detection is not successful, and filesystem is provided, return
   the provided one; otherwise use auto
---
 modules.d/95fstab-sys/module-setup.sh    |    4 +-
 modules.d/95fstab-sys/mount-sys.sh       |    5 +-
 modules.d/95rootfs-block/module-setup.sh |    6 +-
 modules.d/95rootfs-block/mount-root.sh   |   20 ++-
 modules.d/99base/dracut-lib.sh           |   47 -------
 modules.d/99fs-lib/fs-lib.sh             |  207 ++++++++++++++++++++++++++++++
 modules.d/99fs-lib/module-setup.sh       |   22 +++
 7 files changed, 250 insertions(+), 61 deletions(-)
 create mode 100755 modules.d/99fs-lib/fs-lib.sh
 create mode 100755 modules.d/99fs-lib/module-setup.sh

diff --git a/modules.d/95fstab-sys/module-setup.sh b/modules.d/95fstab-sys/module-setup.sh
index 1fbd55b..c22b047 100755
--- a/modules.d/95fstab-sys/module-setup.sh
+++ b/modules.d/95fstab-sys/module-setup.sh
@@ -7,12 +7,10 @@ check() {
 }
 
 depends() {
-    return 0
+    echo fs-lib
 }
 
 install() {
     dracut_install /etc/fstab.sys
-    dracut_install /sbin/fsck*
-    type -P e2fsck >/dev/null && dracut_install e2fsck
     inst_hook pre-pivot 00 "$moddir/mount-sys.sh"
 }
diff --git a/modules.d/95fstab-sys/mount-sys.sh b/modules.d/95fstab-sys/mount-sys.sh
index b444071..f44351d 100755
--- a/modules.d/95fstab-sys/mount-sys.sh
+++ b/modules.d/95fstab-sys/mount-sys.sh
@@ -3,6 +3,7 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+type det_fs >/dev/null 2>&1 || . /lib/fs-lib.sh
 
 fstab_mount() {
     local _dev _mp _fs _opts _dump _pass _rest
@@ -15,9 +16,9 @@ fstab_mount() {
             continue
         fi
         if [ "$_pass" -gt 0 ] && ! strstr "$_opts" _netdev; then
-            wrap_fsck "$_dev"
+            fsck_single "$_dev" "$_fs"
         fi
-        _fs=$(det_fs "$_dev" "$_fs" /etc/fstab.sys)
+        _fs=$(det_fs "$_dev" "$_fs")
         info "Mounting $_dev"
         mount -v -t $_fs -o $_opts $_dev $NEWROOT/$_mp 2>&1 | vinfo
     done < $1
diff --git a/modules.d/95rootfs-block/module-setup.sh b/modules.d/95rootfs-block/module-setup.sh
index 419351b..243a174 100755
--- a/modules.d/95rootfs-block/module-setup.sh
+++ b/modules.d/95rootfs-block/module-setup.sh
@@ -2,10 +2,12 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
+depends() {
+    echo fs-lib
+}
+
 install() {
     dracut_install umount
-    dracut_install /sbin/fsck*
-    type -P e2fsck >/dev/null && dracut_install e2fsck
     inst_hook cmdline 95 "$moddir/parse-block.sh"
     inst_hook pre-udev 30 "$moddir/block-genrules.sh"
     inst_hook mount 99 "$moddir/mount-root.sh"
diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index eccc019..67763cf 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -3,6 +3,7 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+type det_fs >/dev/null 2>&1 || . /lib/fs-lib.sh
 
 filter_rootopts() {
     rootopts=$1
@@ -25,10 +26,10 @@ filter_rootopts() {
     echo $rootopts
 }
 
-if [ -n "$root" -a -z "${root%%block:*}" ]; then
-
+mount_root() {
+    local _ret
     # sanity - determine/fix fstype
-    rootfs=$(det_fs "${root#block:}" "$fstype" "cmdline")
+    rootfs=$(det_fs "${root#block:}" "$fstype")
     mount -t ${rootfs} -o "$rflags",ro "${root#block:}" "$NEWROOT"
 
     READONLY=
@@ -88,7 +89,7 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
 
             if [ "$mp" = "/" ]; then
                 # sanity - determine/fix fstype
-                rootfs=$(det_fs "${root#block:}" "$fs" "$NEWROOT/etc/fstab")
+                rootfs=$(det_fs "${root#block:}" "$fs")
                 rootopts=$opts
                 break
             fi
@@ -103,9 +104,10 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
     esc_root=$(echo ${root#block:} | sed 's,\\,\\\\,g')
     printf '%s %s %s %s,%s 1 1 \n' "$esc_root" "$NEWROOT" "$rootfs" "$rflags" "$rootopts"  > /etc/fstab
 
-    if [ -x "/sbin/fsck.$rootfs" -a -z "$fastboot" -a "$READONLY" != "yes" ] && ! strstr "${rflags},${rootopts}" _netdev; then
-        wrap_fsck "${root#block:}" "$fsckoptions"
-        echo $? >/run/initramfs/root-fsck
+    if [ -z "$fastboot" -a "$READONLY" != "yes" ] && ! strstr "${rflags},${rootopts}" _netdev; then
+        fsck_single "${root#block:}" "$rootfs" "$fsckoptions"
+        _ret=$?
+        [ $_ret -ne 255 ] && echo $_ret >/run/initramfs/root-fsck
     fi
 
     info "Remounting ${root#block:} with -o ${rflags},${rootopts}"
@@ -114,4 +116,8 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
 
     [ -f "$NEWROOT"/forcefsck ] && rm -f "$NEWROOT"/forcefsck 2>/dev/null
     [ -f "$NEWROOT"/.autofsck ] && rm -f "$NEWROOT"/.autofsck 2>/dev/null
+}
+
+if [ -n "$root" -a -z "${root%%block:*}" ]; then
+    mount_root
 fi
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 10025bd..e376495 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -515,50 +515,3 @@ foreach_uuid_until() (
 
     return 1
 )
-
-# Wrap fsck call for device _dev with additional fsck options _fsckopts return
-# fsck's return code
-wrap_fsck() {
-    local _ret _out _dev="$1" _fsckopts="$2"
-
-    info "Checking filesystem."
-    info fsck -T $_fsckopts "$_dev"
-    _out=$(fsck -T $_fsckopts "$_dev") ; _ret=$?
-
-    # A return of 4 or higher means there were serious problems.
-    if [ $_ret -gt 3 ]; then
-        echo $_out|vwarn
-        warn "fsck returned with error code $_ret"
-        warn "*** An error occurred during the file system check."
-        warn "*** Dropping you to a shell; the system will try"
-        warn "*** to mount the filesystem, when you leave the shell."
-        emergency_shell -n "(Repair filesystem)"
-    else
-        echo $_out|vinfo
-        [ $_ret -gt 0 ] && warn "fsck returned with $_ret"
-    fi
-
-    return $_ret
-}
-
-# Verify supplied filesystem type, fix if it's invalid, warn user if
-# appropriate
-det_fs() {
-    local _dev="$1" _fs="${2:-auto}" _inf="$3" _orig
-
-    _orig="$_fs"
-    _fs=$(udevadm info --query=env --name="$_dev" | \
-    while read line; do
-        if str_starts $line "ID_FS_TYPE="; then
-            echo ${line#ID_FS_TYPE=}
-            break
-        fi
-    done)
-    _fs=${_fs:-auto}
-    if [ "$_fs" = "auto" ]; then
-        warn "Cannon detect filesystem type for device $_dev"
-    elif [ "$_orig" != "auto" -a "$_fs" != "$_orig" ]; then
-        warn "$_inf: detected filesystem '$_fs' instead of '$_orig' for device: $_dev"
-    fi
-    echo "$_fs"
-}
diff --git a/modules.d/99fs-lib/fs-lib.sh b/modules.d/99fs-lib/fs-lib.sh
new file mode 100755
index 0000000..e64559c
--- /dev/null
+++ b/modules.d/99fs-lib/fs-lib.sh
@@ -0,0 +1,207 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+
+fsck_ask_reboot() {
+    info "note - fsck suggests reboot, if you"
+    info "leave shell, booting will continue normally"
+    emergency_shell -n "(reboot ?)"
+}
+
+fsck_ask_err() {
+    warn "*** An error occurred during the file system check."
+    warn "*** Dropping you to a shell; the system will try"
+    warn "*** to mount the filesystem(s), when you leave the shell."
+    emergency_shell -n "(Repair filesystem)"
+}
+
+# inherits: _ret _drv _out
+fsck_tail() {
+    [ $_ret -gt 0 ] && warn "$_drv returned with $_ret"
+    if [ $_ret -ge 4 ]; then
+        [ -n "$_out" ] && echo "$_out"|vwarn
+        fsck_ask_err
+    else
+        [ -n "$_out" ] && echo "$_out"|vinfo
+        [ $_ret -ge 2 ] && fsck_ask_reboot
+    fi
+}
+
+# note: this function sets _drv of the caller
+fsck_able() {
+    case "$1" in
+        xfs) {
+                type xfs_db &&
+                type xfs_repair &&
+                type xfs_check &&
+                type mount &&
+                type umount
+            } >/dev/null 2>&1 &&
+            _drv="_drv=none fsck_drv_xfs" &&
+            return 0
+            ;;
+        ext?)
+            type e2fsck >/dev/null 2>&1 &&
+            _drv="_drv=e2fsck fsck_drv_com" &&
+            return 0
+            ;;
+        jfs)
+            type jfs_fsck >/dev/null 2>&1 &&
+            _drv="_drv=jfs_fsck fsck_drv_com" &&
+            return 0
+            ;;
+        reiserfs)
+            type reiserfsck >/dev/null 2>&1 &&
+            _drv="_drv=reiserfsck fsck_drv_com" &&
+            return 0
+            ;;
+        *)
+            type fsck >/dev/null 2>&1 &&
+            _drv="_drv=fsck fsck_drv_std" &&
+            return 0
+            ;;
+    esac
+
+    return 1
+}
+
+# note: all drivers inherit: _drv _fop _dev
+
+fsck_drv_xfs() {
+    local _ret
+
+    # fs must be cleanly mounted (and umounted) first, before attempting any
+    # xfs tools - if this works, nothing else should be needed
+    # note, that user is always dropped into the shell, if the filesystem is
+    # not mountable or if -f flag is found among _fop
+    mkdir -p /tmp/.xfs
+
+    info "trying to mount $_dev"
+    if mount -t xfs "$_dev" "/tmp/.xfs" >/dev/null 2>&1; then
+        _ret=0
+        info "xfs: $_dev is clean"
+        umount "$_dev" >/dev/null 2>&1
+    else
+        _ret=4
+        warn "*** $_dev is unmountable"
+    fi
+    if [ $_ret -gt 0 ] || strstr "$_fop" "-f"; then
+        warn "*** Dropping you to a shell. You have"
+        warn "*** xfs_repair and xfs_check (xfs_db) available."
+        warn "*** Note that if xfs didn't mount properly, it's"
+        warn "*** probably pretty serious condition."
+        emergency_shell -n "(Repair filesystem)"
+    fi
+
+    rm -r /tmp/.xfs
+    return $_ret
+}
+
+# common code for checkers that follow usual subset of options and return codes
+fsck_drv_com() {
+    local _ret
+    local _out
+
+    if ! strstr "$_fop" "-[ynap]"; then
+        _fop="-a ${_fop}"
+    fi
+
+    info "issuing $_drv $_fop $_dev"
+    # we enforce non-interactive run, so $() is fine
+    _out=$($_drv $_fop "$_dev")
+    _ret=$?
+    fsck_tail
+
+    return $_ret
+}
+
+# code for generic fsck, if the filesystem checked is "unknown" to us
+fsck_drv_std() {
+    local _ret
+    local _out
+    unset _out
+
+    info "issuing fsck $_fop $_dev"
+    # note, we don't enforce -a here, thus fsck is being run (in theory)
+    # interactively; otherwise some tool might complain about lack of terminal
+    # (and using -a might not be safe)
+    fsck $_fop "$_dev" >/dev/console 2>&1
+    _ret=$?
+    fsck_tail
+
+    return $_ret
+}
+
+# checks single filesystem, relying on specific "driver"; we don't rely on
+# automatic checking based on fstab, so empty one is passed;
+# takes 3 arguments - device, filesystem, additional fsck options;
+# first 2 arguments are mandatory (fs may be auto or "")
+# returns 255 if filesystem wasn't checked at all (e.g. due to lack of
+# necessary tools or insufficient options)
+fsck_single() {
+    local FSTAB_FILE=/etc/fstab.fslib
+    local _dev="$1"
+    local _fs="${2:-auto}"
+    local _fop="$3"
+    local _drv
+
+    [ $# -lt 2 ] && return 255
+
+    _fs=$(det_fs "$_dev" "$_fs")
+    fsck_able "$_fs" || return 255
+
+    info "Checking $_fs: $_dev"
+    export FSTAB_FILE
+    eval "$_drv" "\"$_dev\"" "\"$_fop\""
+    return $?
+}
+
+# takes list of filesystems to check in parallel; we don't rely on automatic
+# checking based on fstab, so empty one is passed
+fsck_batch() {
+    local FSTAB_FILE=/etc/fstab.fslib
+    local _drv=fsck
+    local _dev
+    local _ret
+    local _out
+
+    [ $# -eq 0 ] && return 255
+
+    info "Checking filesystems (fsck -M -T -a):"
+    for _dev in "$@"; do
+        info "    $_dev"
+    done
+
+    _out="$(fsck -M -T "$@" -- -a)"
+    _ret=$?
+
+    export FSTAB_FILE
+    fsck_tail
+
+    return $_ret
+}
+
+# verify supplied filesystem type:
+# if user provided the fs and we couldn't find it, assume user is right
+# if we found the fs, assume we're right
+det_fs() {
+    local _dev="$1"
+    local _orig="${2:-auto}"
+    local _fs
+
+    _fs=$(udevadm info --query=env --name="$_dev" | \
+    while read line; do
+        if str_starts $line "ID_FS_TYPE="; then
+            echo ${line#ID_FS_TYPE=}
+            break
+        fi
+    done)
+    _fs=${_fs:-auto}
+
+    if [ "$_fs" = "auto" ]; then
+        _fs="$_orig"
+    fi
+    echo "$_fs"
+}
diff --git a/modules.d/99fs-lib/module-setup.sh b/modules.d/99fs-lib/module-setup.sh
new file mode 100755
index 0000000..a7d870c
--- /dev/null
+++ b/modules.d/99fs-lib/module-setup.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+check() {
+    return 0
+}
+
+depends() {
+    return 0
+}
+
+install() {
+    dracut_install -o umount mount xfs_db xfs_check xfs_repair
+    dracut_install -o e2fsck
+    dracut_install -o jfs_fsck
+    dracut_install -o reiserfsck
+    dracut_install -o /sbin/fsck*
+
+    inst "$moddir/fs-lib.sh" "/lib/fs-lib.sh"
+    touch ${initdir}/etc/fstab.fslib
+}
-- 
1.7.5.2
