From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] ismounted fix
Date: Mon, 17 Sep 2012 16:00:34 +0800
Message-ID: <20120917080034.GA15753@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org


ismounted handles both find-by-dev and find-by-mnt, but there's two issues:
1. for find-by-dev, it use readlink to get the canonical dev name, but
   lvm is different with other devices, lvm use the symlinks in /proc/mounts
   without converting to canonical name.
2. for nfs mounting, just use [ -b $dev ] is not enough, it need being handled
   seperately.

grep all current ismounted() user, they are all ismounted <mntdir>, so change
to split the ismounted <dev> to another function dev_ismounted. Afterwards
ismounted() should be converted to dir_ismounted.

in dev_ismounted, fix the dev name issue by using maj:min to comparing with
items in /proc/self/mountinfo. OTOH for nfs share just compare with the 1st
field of /proc/mounts.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |   55 ++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 12 deletions(-)

--- dracut.orig/modules.d/99base/dracut-lib.sh
+++ dracut/modules.d/99base/dracut-lib.sh
@@ -452,26 +452,57 @@ udevproperty() {
     fi
 }
 
-find_mount() {
-    local dev mnt etc wanted_dev
-    wanted_dev="$(readlink -e -q $1)"
+# get_maj_min <device>
+# Prints the major and minor of a device node.
+# Example:
+# $ get_maj_min /dev/sda2
+# 8:2
+get_maj_min() {
+    local _dev
+    _dev=$(stat -L -c '$((0x%t)):$((0x%T))' "$1" 2>/dev/null)
+    _dev=$(eval "echo $_dev")
+    echo $_dev
+}
+
+find_mount_point() {
+    local _x majmin mnt wanted_majmin
+    wanted_majmin="$(get_maj_min $1)"
+    while read _x _x majmin _x mnt _x; do
+        [ "$majmin" = "$wanted_majmin" ] && echo "$mnt" && return 0
+    done < /proc/self/mountinfo
+    return 1
+}
+
+nfs_find_mount_point() {
+    local dev mnt etc
     while read dev mnt etc; do
-        [ "$dev" = "$wanted_dev" ] && echo "$dev" && return 0
+        [ "$dev" = "$1" ] && echo "$mnt" && return 0
     done < /proc/mounts
     return 1
 }
 
-# usage: ismounted <mountpoint>
-# usage: ismounted /dev/<device>
-ismounted() {
+find_mount_dev() {
+    local dev mnt etc
+    while read dev mnt etc; do
+        [ "$mnt" = "$1" ] && echo "$dev" && return 0
+    done < /proc/mounts
+    return 1
+}
+
+# usage: dev_ismounted /dev/<device>
+# usage: dev_ismounted nfs-share
+dev_ismounted() {
     if [ -b "$1" ]; then
-        find_mount "$1" > /dev/null && return 0
-        return 1
+        find_mount_point "$1" > /dev/null && return 0
+    else
+        nfs_find_mount_point "$1" > /dev/null && return 0
     fi
+    return 1
+}
 
-    while read a m a; do
-        [ "$m" = "$1" ] && return 0
-    done < /proc/mounts
+# usage: ismounted <mountpoint>
+ismounted() {
+    find_mount_dev "$1" > /dev/null && return 0
     return 1
 }
 
--- dracut.orig/modules.d/99base/module-setup.sh
+++ dracut/modules.d/99base/module-setup.sh
@@ -13,7 +13,7 @@ depends() {
 
 install() {
     local _d
-    dracut_install mount mknod mkdir pidof sleep chroot \
+    dracut_install mount mknod mkdir pidof sleep chroot stat \
         sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink setsid
     inst $(command -v modprobe) /sbin/modprobe
 
