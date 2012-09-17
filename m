From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] update to use dir_ismounted
Date: Mon, 17 Sep 2012 16:00:39 +0800
Message-ID: <20120917080039.GA15761@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org


current user of ismounted are in fact dir_ismounted.
Because ismounted can not handle well nfs share. dev_ismounted was
seperated. Naturally move ismounted to dir_ismounted here.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95fstab-sys/mount-sys.sh      |    2 +-
 modules.d/95rootfs-block/mount-root.sh  |    2 +-
 modules.d/96securityfs/securityfs.sh    |    2 +-
 modules.d/98systemd/dracut-initqueue.sh |    4 ++--
 modules.d/98usrmount/mount-usr.sh       |    2 +-
 modules.d/99base/dracut-lib.sh          |    8 ++++----
 modules.d/99base/init.sh                |   14 +++++++-------
 7 files changed, 17 insertions(+), 17 deletions(-)

--- dracut.orig/modules.d/99base/dracut-lib.sh
+++ dracut/modules.d/99base/dracut-lib.sh
@@ -500,8 +500,8 @@ dev_ismounted() {
     return 1
 }
 
-# usage: ismounted <mountpoint>
-ismounted() {
+# usage: dir_ismounted <mountpoint>
+dir_ismounted() {
     find_mount_dev "$1" > /dev/null && return 0
     return 1
 }
@@ -815,10 +815,10 @@ wait_for_mount()
 {
     local _name
     _name="$(str_replace "$1" '/' '\\x2f')"
-    printf '. /lib/dracut-lib.sh\nismounted "%s"\n' $1 \
+    printf '. /lib/dracut-lib.sh\ndir_ismounted "%s"\n' $1 \
         >> "$hookdir/initqueue/finished/ismounted-${_name}.sh"
     {
-        printf 'ismounted "%s" || ' $1
+        printf 'dir_ismounted "%s" || ' $1
         printf 'warn "\"%s\" is not mounted"\n' $1
     } >> "$hookdir/emergency/90-${_name}.sh"
 }
--- dracut.orig/modules.d/99base/init.sh
+++ dracut/modules.d/99base/init.sh
@@ -46,11 +46,11 @@ fi
 
 setdebug
 
-if ! ismounted /dev; then
+if ! dir_ismounted /dev; then
     mount -t devtmpfs -o mode=0755,nosuid,strictatime devtmpfs /dev >/dev/null
 fi
 
-if ! ismounted /dev; then
+if ! dir_ismounted /dev; then
     echo "Cannot mount devtmpfs on /dev! Compile the kernel with CONFIG_DEVTMPFS!"
     exit 1
 fi
@@ -61,17 +61,17 @@ fi
 [ ! -h /dev/stdout ] && ln -s /proc/self/fd/1 /dev/stdout >/dev/null 2>&1
 [ ! -h /dev/stderr ] && ln -s /proc/self/fd/2 /dev/stderr >/dev/null 2>&1
 
-if ! ismounted /dev/pts; then
+if ! dir_ismounted /dev/pts; then
     mkdir -m 0755 /dev/pts
     mount -t devpts -o gid=5,mode=620,noexec,nosuid devpts /dev/pts >/dev/null 
 fi
 
-if ! ismounted /dev/shm; then
+if ! dir_ismounted /dev/shm; then
     mkdir -m 0755 /dev/shm
     mount -t tmpfs -o mode=1777,nosuid,nodev,strictatime tmpfs /dev/shm >/dev/null 
 fi
 
-if ! ismounted /run; then
+if ! dir_ismounted /run; then
     mkdir -m 0755 /newrun
     mount -t tmpfs -o mode=0755,nosuid,nodev,strictatime tmpfs /newrun >/dev/null 
     cp -a /run/* /newrun >/dev/null 2>&1
@@ -212,13 +212,13 @@ getarg 'rd.break=mount' -d 'rdbreak=moun
 # be sourced any number of times. As soon as one suceeds, no more are sourced.
 i=0
 while :; do
-    if ismounted "$NEWROOT"; then
+    if dir_ismounted "$NEWROOT"; then
         usable_root "$NEWROOT" && break;
         umount "$NEWROOT"
     fi
     for f in $hookdir/mount/*.sh; do
         [ -f "$f" ] && . "$f"
-        if ismounted "$NEWROOT"; then
+        if dir_ismounted "$NEWROOT"; then
             usable_root "$NEWROOT" && break;
             warn "$NEWROOT has no proper rootfs layout, ignoring and removing offending mount hook"
             umount "$NEWROOT"
--- dracut.orig/modules.d/95fstab-sys/mount-sys.sh
+++ dracut/modules.d/95fstab-sys/mount-sys.sh
@@ -11,7 +11,7 @@ fstab_mount() {
     info "Mounting from $1"
     while read _dev _mp _fs _opts _dump _pass _rest; do
         [ -z "${_dev%%#*}" ] && continue # Skip comment lines
-        ismounted $_mp && continue # Skip mounted filesystem
+        dir_ismounted $_mp && continue # Skip mounted filesystem
         if [ "$_pass" -gt 0 ] && ! strstr "$_opts" _netdev; then
             fsck_single "$_dev" "$_fs" "$_opts"
         fi
--- dracut.orig/modules.d/95rootfs-block/mount-root.sh
+++ dracut/modules.d/95rootfs-block/mount-root.sh
@@ -120,7 +120,7 @@ mount_root() {
 
     echo "${root#block:} $NEWROOT $rootfs ${rflags:-defaults} 0 $rootfsck" >> /etc/fstab
 
-    if ! ismounted "$NEWROOT"; then
+    if ! dir_ismounted "$NEWROOT"; then
         info "Mounting ${root#block:} with -o ${rflags}"
         mount "$NEWROOT" 2>&1 | vinfo
     elif ! are_lists_eq , "$rflags" "$_rflags_ro" defaults; then
--- dracut.orig/modules.d/96securityfs/securityfs.sh
+++ dracut/modules.d/96securityfs/securityfs.sh
@@ -5,6 +5,6 @@
 SECURITYFSDIR="/sys/kernel/security"
 export SECURITYFSDIR
 
-if ! ismounted "${SECURITYFSDIR}"; then
+if ! dir_ismounted "${SECURITYFSDIR}"; then
    mount -t securityfs -o nosuid,noexec,nodev securityfs ${SECURITYFSDIR} >/dev/null 2>&1
 fi
--- dracut.orig/modules.d/98systemd/dracut-initqueue.sh
+++ dracut/modules.d/98systemd/dracut-initqueue.sh
@@ -82,13 +82,13 @@ getarg 'rd.break=mount' -d 'rdbreak=moun
 # be sourced any number of times. As soon as one suceeds, no more are sourced.
 i=0
 while :; do
-    if ismounted "$NEWROOT"; then
+    if dir_ismounted "$NEWROOT"; then
         usable_root "$NEWROOT" && break;
         umount "$NEWROOT"
     fi
     for f in $hookdir/mount/*.sh; do
         [ -f "$f" ] && . "$f"
-        if ismounted "$NEWROOT"; then
+        if dir_ismounted "$NEWROOT"; then
             usable_root "$NEWROOT" && break;
             warn "$NEWROOT has no proper rootfs layout, ignoring and removing offending mount hook"
             umount "$NEWROOT"
--- dracut.orig/modules.d/98usrmount/mount-usr.sh
+++ dracut/modules.d/98usrmount/mount-usr.sh
@@ -84,7 +84,7 @@ mount_usr()
         info "Mounting /usr with -o $_opts"
         mount "$NEWROOT/usr" 2>&1 | vinfo
 
-        if ! ismounted "$NEWROOT/usr"; then
+        if ! dir_ismounted "$NEWROOT/usr"; then
             warn "Mounting /usr to $NEWROOT/usr failed"
             warn "*** Dropping you to a shell; the system will continue"
             warn "*** when you leave the shell."
