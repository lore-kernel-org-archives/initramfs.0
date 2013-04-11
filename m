From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: [PATCH 1/2] [99fs-lib] Create generic mount framework
Date: Thu, 11 Apr 2013 17:39:21 +0200
Message-ID: <1365694762-7806-1-git-send-email-devurandom@gmx.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>

* Utilises fstab.{early,late} files in /etc
* Provides fs_add_mount function to mount in pre-mount (early) and pre-pivot (late) phases
* Code to mount a fstab file is moved over from 95fstab-sys
---
 modules.d/95fstab-sys/mount-sys.sh | 22 ---------------------
 modules.d/99fs-lib/fs-lib.sh       | 39 ++++++++++++++++++++++++++++++++++++++
 modules.d/99fs-lib/module-setup.sh |  3 +++
 modules.d/99fs-lib/mount-early.sh  |  8 ++++++++
 modules.d/99fs-lib/mount-late.sh   |  8 ++++++++
 5 files changed, 58 insertions(+), 22 deletions(-)
 create mode 100755 modules.d/99fs-lib/mount-early.sh
 create mode 100755 modules.d/99fs-lib/mount-late.sh

diff --git a/modules.d/95fstab-sys/mount-sys.sh b/modules.d/95fstab-sys/mount-sys.sh
index 12711a0..d2ed7cc 100755
--- a/modules.d/95fstab-sys/mount-sys.sh
+++ b/modules.d/95fstab-sys/mount-sys.sh
@@ -5,28 +5,6 @@
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 type det_fs >/dev/null 2>&1 || . /lib/fs-lib.sh
 
-fstab_mount() {
-    local _dev _mp _fs _opts _dump _pass _rest
-    test -e "$1" || return 1
-    info "Mounting from $1"
-    while read _dev _mp _fs _opts _dump _pass _rest; do
-        [ -z "${_dev%%#*}" ] && continue # Skip comment lines
-        ismounted $_mp && continue # Skip mounted filesystem
-        if [ "$_pass" -gt 0 ] && ! strstr "$_opts" _netdev; then
-            fsck_single "$_dev" "$_fs" "$_opts"
-        fi
-        _fs=$(det_fs "$_dev" "$_fs")
-        info "Mounting $_dev"
-        if [ -d "$NEWROOT/$_mp" ]; then
-            mount -v -t $_fs -o $_opts $_dev "$NEWROOT/$_mp" 2>&1 | vinfo
-        else
-            [ -d "$_mp" ] || mkdir -p "$_mp"
-            mount -v -t $_fs -o $_opts $_dev $_mp 2>&1 | vinfo
-        fi
-    done < $1
-    return 0
-}
-
 [ -f /etc/fstab ] && fstab_mount /etc/fstab
 
 # prefer $NEWROOT/etc/fstab.sys over local /etc/fstab.sys
diff --git a/modules.d/99fs-lib/fs-lib.sh b/modules.d/99fs-lib/fs-lib.sh
index e1f3074..9e6abf6 100755
--- a/modules.d/99fs-lib/fs-lib.sh
+++ b/modules.d/99fs-lib/fs-lib.sh
@@ -248,3 +248,42 @@ write_fs_tab() {
         systemctl --no-block start initrd-root-fs.target
     fi
 }
+
+# fstab_mount FSTAB
+# go through FSTAB and mount each line
+# cannot be used to mount rootfs for 40network, because it will not create /dev/root
+fstab_mount() {
+    local _dev _mp _fs _opts _dump _pass _rest
+    test -e "$1" || return 1
+    info "Mounting from $1"
+    while read _dev _mp _fs _opts _dump _pass _rest; do
+        [ -z "${_dev%%#*}" ] && continue # Skip comment lines
+        ismounted $_mp && continue # Skip mounted filesystem
+        if [ "$_pass" -gt 0 ] && ! strstr "$_opts" _netdev; then
+            fsck_single "$_dev" "$_fs" "$_opts"
+        fi
+        _fs=$(det_fs "$_dev" "$_fs")
+        info "Mounting $_dev"
+        if [ -d "$NEWROOT/$_mp" ]; then
+            mount -v -t $_fs -o $_opts $_dev "$NEWROOT/$_mp" 2>&1 | vinfo
+        else
+            [ -d "$_mp" ] || mkdir -p "$_mp"
+            mount -v -t $_fs -o $_opts $_dev $_mp 2>&1 | vinfo
+        fi
+    done < $1
+    return 0
+}
+
+# fs_add_mount PHASE FS MOUNTPOINT FSTYPE OPTIONS DUMP PASS
+# add line to fstab used by pre-mount (PHASE=early) or pre-pivot (PHASE=late) hook
+# FS is anything that could be found in the first column of fstab
+fs_add_mount() {
+	local phase="$1" fs="$2" mountpoint="$3" fstype="$4" options="$5" dump="$6" pass="$7"
+	[ "${fs}" ] || die "FS passed to $0 is empty"
+	[ "${mountpoint}" ] || die "Mountpoint passed to $0 is empty"
+	[ "${fstype}" ] || fstype=auto
+	[ "${options}" ] || options=defaults
+	[ "${dump}" ] || dump=0
+	[ "${pass}" ] || pass=0
+	echo "${fs} ${mountpoint} ${fstype} ${options} ${dump} ${pass}" >> /etc/fstab."${phase}"
+}
diff --git a/modules.d/99fs-lib/module-setup.sh b/modules.d/99fs-lib/module-setup.sh
index 637737e..1f8d528 100755
--- a/modules.d/99fs-lib/module-setup.sh
+++ b/modules.d/99fs-lib/module-setup.sh
@@ -60,6 +60,9 @@ install() {
     inst "$moddir/fs-lib.sh" "/lib/fs-lib.sh"
     > ${initdir}/etc/fstab.empty
 
+    inst_hook pre-mount 99 "$moddir/mount-early.sh"
+    inst_hook pre-pivot 99 "$moddir/mount-late.sh"
+
     [[ "$nofscks" = "yes" ]] && return
 
     if [[ "$fscks" = "${fscks#*[^ ]*}" ]]; then
diff --git a/modules.d/99fs-lib/mount-early.sh b/modules.d/99fs-lib/mount-early.sh
new file mode 100755
index 0000000..e11774a
--- /dev/null
+++ b/modules.d/99fs-lib/mount-early.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+type det_fs >/dev/null 2>&1 || . /lib/fs-lib.sh
+
+[ -f /etc/fstab.early ] && fstab_mount /etc/fstab.early
diff --git a/modules.d/99fs-lib/mount-late.sh b/modules.d/99fs-lib/mount-late.sh
new file mode 100755
index 0000000..669fcd2
--- /dev/null
+++ b/modules.d/99fs-lib/mount-late.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+type det_fs >/dev/null 2>&1 || . /lib/fs-lib.sh
+
+[ -f /etc/fstab.late ] && fstab_mount /etc/fstab.late
-- 
1.8.1.5
