From: Frederic Crozat <fcrozat-IBi9RG/b67k@public.gmane.org>
Subject: PATCH: add support for xfs / reiserfs separate journal device
Date: Thu, 26 Jul 2012 15:16:22 +0200
Message-ID: <1343308582.2983.31.camel@par-r81vxc7.par.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-wqXtqkHI7yZ0/EW6bLLV"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-wqXtqkHI7yZ0/EW6bLLV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

xfs and reiserfs (among other) supports storing journal data to a
separate device. Unfortunately, XFS requires this information to boot
properly (reiserfs can embed the information in its metadata but you
might want to override it).

Attached patch ensure host information are stored in initramfs and also
allows to give data over kernel commandline.


-- 
Frederic Crozat <fcrozat-IBi9RG/b67k@public.gmane.org>
SUSE

--=-wqXtqkHI7yZ0/EW6bLLV
Content-Disposition: inline; filename="separate-journal.patch"
Content-Type: text/x-patch; name="separate-journal.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From a7c592b9bb7de0d7874ae51d02944a7eee2ec75b Mon Sep 17 00:00:00 2001
From: Frederic Crozat <fcrozat-IBi9RG/b67k@public.gmane.org>
Date: Tue, 24 Jul 2012 18:52:17 +0200
Subject: [PATCH] Add support for separate journal on reiserfs and xfs

---
 modules.d/95rootfs-block/module-setup.sh |   43 ++++++++++++++++++++++++++++++
 modules.d/95rootfs-block/mount-root.sh   |   15 +++++++++++
 2 files changed, 58 insertions(+)

diff --git a/modules.d/95rootfs-block/module-setup.sh b/modules.d/95rootfs-block/module-setup.sh
index 243a174..e5212c7 100755
--- a/modules.d/95rootfs-block/module-setup.sh
+++ b/modules.d/95rootfs-block/module-setup.sh
@@ -2,6 +2,49 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
+type det_fs >/dev/null 2>&1 || . $dracutbasedir/modules.d/99fs-lib/fs-lib.sh
+
+search_option() {
+    rootopts=$1
+    option=$2
+    local OLDIFS="$IFS"
+    IFS=,
+    set -- $rootopts
+    IFS="$OLDIFS"
+    while [ $# -gt 0 ]; do
+        case $1 in
+            $option=*)
+                echo ${1#${option}=}
+                break
+        esac
+        shift
+    done
+}
+
+check() {
+        rootopts="defaults"
+        while read dev mp fs opts dump fsck; do
+            # skip comments
+            [ "${dev%%#*}" != "$dev" ] && continue
+
+            if [ "$mp" = "/" ]; then
+                # sanity - determine/fix fstype
+                rootfs=$(det_fs "${root#block:}" "$fs")
+                rootopts=$opts
+                rootfsck=$fsck
+                break
+            fi
+        done < "$NEWROOT/etc/fstab"
+
+        [ "$rootfs" = "reiserfs" ] && journaldev=$(search_option $rootopts "jdev")
+        [ "$rootfs" = "xfs" ] && journaldev=$(search_option $rootopts "logdev")
+        if [ -n "$journaldev" ]; then
+            echo "root.journaldev=$journaldev" >> "${initdir}/etc/cmdline.d/95root-journaldev.conf"
+        fi
+    return 0
+
+}
+
 depends() {
     echo fs-lib
 }
diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index e61b0e8..d4300ae 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -29,6 +29,21 @@ mount_root() {
     local _ret
     # sanity - determine/fix fstype
     rootfs=$(det_fs "${root#block:}" "$fstype")
+
+    journaldev=$(getarg root.journaldev)
+    if [ -n $journaldev ]; then
+        case "$rootfs" in
+            xfs)
+                rflags="${rflags:+${rflags},}logdev=$journaldev"
+                ;;
+            reiserfs)
+                fsckoptions="-j $journaldev $fsckoptions"
+                rflags="${rflags:+${rflags},}jdev=$journaldev"
+                ;;
+            *);;
+        esac
+    fi
+
     while ! mount -t ${rootfs} -o "$rflags",ro "${root#block:}" "$NEWROOT"; do
         warn "Failed to mount -t ${rootfs} -o $rflags,ro ${root#block:} $NEWROOT"
         fsck_ask_err
-- 
1.7.10.4


--=-wqXtqkHI7yZ0/EW6bLLV--
