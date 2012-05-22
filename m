From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut-lib.sh: add find_mount()
Date: Tue, 22 May 2012 17:56:09 -0400
Message-ID: <1337723769-5412-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add a function to find the mount point for a given device.
---
 modules.d/99base/dracut-lib.sh |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 8a54a7a..b6168df 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -402,6 +402,7 @@ udevproperty() {
     fi
 }
 
+# check if a given directory is a mounted filesystem
 ismounted() {
     while read a m a; do
         [ "$m" = "$1" ] && return 0
@@ -409,6 +410,16 @@ ismounted() {
     return 1
 }
 
+# find mountpoint for the given device
+find_mount() {
+    local wanted_dev="$1"; [ -b "$1" ] && wanted_dev=$(readlink -e -q "$1")
+    local dev mnt etc
+    while read -r dev mnt etc; do
+        [ "$dev" = "$wanted_dev" ] && echo $mnt && return 0
+    done < /proc/mounts
+    return 1
+}
+
 wait_for_if_up() {
     local cnt=0
     local li
-- 
1.7.10.1
