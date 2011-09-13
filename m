From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] rootfs-block: add mtd support
Date: Tue, 13 Sep 2011 11:22:39 +0100 (BST)
Message-ID: <20110913102239.81B619D401C@zog.reactivated.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch adds mtd support through (e.g.) root=mtd:0 parameter
recognition. These devices must be mounted with "mount mtd0 /mnt/foo" and
do not have a corresponding block device in /dev (but /dev/mtd0 is a
character device which is used here to ensure that mtd0 exists before we
mount it).

Even though mtd devices are not block devices (see
http://www.linux-mtd.infradead.org/faq/general.html#L_mtd_what )
it seems like creating a module separate from rootfs-block would end
up with a large amount of duplication.

Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>

Index: dracut-013/modules.d/95rootfs-block/parse-block.sh
===================================================================
--- dracut-013.orig/modules.d/95rootfs-block/parse-block.sh
+++ dracut-013/modules.d/95rootfs-block/parse-block.sh
@@ -15,4 +15,9 @@ case "$root" in
     /dev/*)
         root="block:${root}"
         rootok=1 ;;
+    mtd:*)
+        rootok=1 ;;
+    mtd[0-9]*)
+        root="mtd:${root#mtd}"
+        rootok=1 ;;
 esac
Index: dracut-013/modules.d/95rootfs-block/block-genrules.sh
===================================================================
--- dracut-013.orig/modules.d/95rootfs-block/block-genrules.sh
+++ dracut-013/modules.d/95rootfs-block/block-genrules.sh
@@ -2,16 +2,25 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
-if [ "${root%%:*}" = "block" ]; then
+cfg_udev_for_root() {
+    local rootdev=$1
     {
         printf 'KERNEL=="%s", SYMLINK+="root"\n' \
-            ${root#block:/dev/}
+            ${rootdev#/dev/}
         printf 'SYMLINK=="%s", SYMLINK+="root"\n' \
-            ${root#block:/dev/}
+            ${rootdev#/dev/}
     } >> $UDEVRULESD/99-root.rules
 
     printf '[ -e "%s" ] && { ln -s "%s" /dev/root 2>/dev/null; rm "$job"; }\n' \
-        "${root#block:}" "${root#block:}" > $hookdir/initqueue/settled/blocksymlink.sh
+        "$rootdev" "$rootdev" > $hookdir/initqueue/settled/blocksymlink.sh
 
     echo '[ -e /dev/root ]' > $hookdir/initqueue/finished/block.sh
+}
+
+if [ "${root%%:*}" = "block" ]; then
+    cfg_udev_for_root "${root#block:}"
+elif [ "${root%%:*}" = "mtd" ]; then
+    cfg_udev_for_root "/dev/mtd${root#mtd:}"
 fi
+
+unset cfg_udev_for_root
Index: dracut-013/modules.d/95rootfs-block/mount-root.sh
===================================================================
--- dracut-013.orig/modules.d/95rootfs-block/mount-root.sh
+++ dracut-013/modules.d/95rootfs-block/mount-root.sh
@@ -28,9 +28,9 @@ filter_rootopts() {
 
 mount_root() {
     local _ret
-    # sanity - determine/fix fstype
-    rootfs=$(det_fs "${root#block:}" "$fstype")
-    mount -t ${rootfs} -o "$rflags",ro "${root#block:}" "$NEWROOT"
+    local rootdev=$1
+    local rootfs=$2
+    mount -t $rootfs -o "$rflags",ro "$rootdev" "$NEWROOT"
 
     READONLY=
     fsckoptions=
@@ -85,7 +85,7 @@ mount_root() {
 
             if [ "$mp" = "/" ]; then
                 # sanity - determine/fix fstype
-                rootfs=$(det_fs "${root#block:}" "$fs")
+                rootfs=$(det_fs "$rootdev" "$fs")
                 rootopts=$opts
                 break
             fi
@@ -105,18 +105,22 @@ mount_root() {
     # printf '%s %s %s %s 1 1 \n' "$esc_root" "$NEWROOT" "$rootfs" "$rflags" >/etc/fstab
 
     if [ -z "$fastboot" -a "$READONLY" != "yes" ] && ! strstr "${rflags},${rootopts}" _netdev; then
-        fsck_single "${root#block:}" "$rootfs" "$fsckoptions"
+        fsck_single "$rootdev" "$rootfs" "$fsckoptions"
         _ret=$?
         [ $_ret -ne 255 ] && echo $_ret >/run/initramfs/root-fsck
     fi
 
-    info "Remounting ${root#block:} with -o ${rflags}"
-    mount -t "$rootfs" -o "$rflags" "${root#block:}" "$NEWROOT" 2>&1 | vinfo
+    info "Remounting $rootdev with -o ${rflags}"
+    mount -t "$rootfs" -o "$rflags" "$rootdev" "$NEWROOT" 2>&1 | vinfo
 
     [ -f "$NEWROOT"/forcefsck ] && rm -f "$NEWROOT"/forcefsck 2>/dev/null
     [ -f "$NEWROOT"/.autofsck ] && rm -f "$NEWROOT"/.autofsck 2>/dev/null
 }
 
-if [ -n "$root" -a -z "${root%%block:*}" ]; then
-    mount_root
+if [ "${root%%:*}" = "block" ]; then
+    # sanity - determine/fix fstype
+    rootfstype=$(det_fs "$rootdev" "$fstype")
+    mount_root "${root#block:}" $rootfstype
+elif [ "${root%%:*}" = "mtd" ]; then
+    mount_root "mtd${root#mtd:}" $fstype
 fi
