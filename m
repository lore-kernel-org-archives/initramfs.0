From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] move get_persistent_dev to dracut-functions.sh
Date: Mon, 10 Sep 2012 16:10:46 +0800
Message-ID: <20120910081046.GA15522@dhcp-16-143.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

kdump module also need to convert dev name to udev symlinks.
So better to move function get_persistent_dev() to dracut-functions.sh

Also in this patch improvement and fix the original function:
a) use udevadm info --query=name to get the kernel name.
   This will fix the issue caused by passing symbolic link of a device.
b) fix a bug to compare $_tmp instead of $i with $_dev. Really sorry,
   should have tested more carefully.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh              |   14 ++++++++++++++
 modules.d/99base/module-setup.sh |   13 -------------
 2 files changed, 14 insertions(+), 13 deletions(-)

--- dracut.orig/dracut-functions.sh
+++ dracut/dracut-functions.sh
@@ -239,6 +239,21 @@ else
     }
 fi
 
+get_persistent_dev() {
+    local i _tmp _dev
+
+    _dev=$(udevadm info --query=name --name="$1" 2>/dev/null)
+    [ -z "$_dev" ] && return
+
+    for i in /dev/disk/by-id/*; do
+        _tmp=$(udevadm info --query=name --name="$i" 2>/dev/null)
+        if [ "$_tmp" = "$_dev" ]; then
+            echo $i
+            return
+        fi
+    done
+}
+
 # get_fs_env <device>
 # Get and set the ID_FS_TYPE and ID_FS_UUID variable from udev for a device.
 # Example:
--- dracut.orig/modules.d/99base/module-setup.sh
+++ dracut/modules.d/99base/module-setup.sh
@@ -11,19 +11,6 @@ depends() {
     return 0
 }
 
-get_persistent_dev() {
-    local i _tmp
-    local _dev=${1##*/}
-
-    for i in /dev/disk/by-id/*; do
-        _tmp=$(readlink $i)
-        if [ "$i" = "$_dev" ]; then
-            echo $i
-            return
-        fi
-    done
-}
-
 install() {
     local _d
     dracut_install mount mknod mkdir pidof sleep chroot \
