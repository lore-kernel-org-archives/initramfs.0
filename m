From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dmsquash-live: use 'rootfs.img' for rootfs image name
Date: Fri, 11 Mar 2011 16:29:09 -0500
Message-ID: <1299878949-27941-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Every image gets handled the same way regardless of filesystem, so
let's use a filesystem-neutral name (rather than adding new
lines for every fstype anyone might want to use).
---
 modules.d/90dmsquash-live/dmsquash-live-root |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index 06893d5..16262b6 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -48,7 +48,7 @@ if [ -f $livedev ]; then
     # no mount needed - we've already got the LiveOS image in initramfs
     case $livedev in
         *squashfs.img) SQUASHED=$livedev ;;
-        *ext3fs.img|*btrfs.img) FSIMG=$livedev ;;
+        *ext3fs.img|*rootfs.img) FSIMG=$livedev ;;
     esac
 else
     mount -n -t $fstype -o $liverw $livedev /dev/.run/initramfs/live
@@ -135,8 +135,8 @@ fi
 # we might have an embedded fs image to use as rootfs (uncompressed live)
 if [ -e /dev/.run/initramfs/live/${live_dir}/ext3fs.img ]; then
     FSIMG="/dev/.run/initramfs/live/${live_dir}/ext3fs.img"
-elif [ -e /dev/.run/initramfs/live/${live_dir}/btrfs.img ]; then
-    FSIMG="/dev/.run/initramfs/live/${live_dir}/btrfs.img"
+elif [ -e /dev/.run/initramfs/live/${live_dir}/rootfs.img ]; then
+    FSIMG="/dev/.run/initramfs/live/${live_dir}/rootfs.img"
 fi
 
 if [ -n "$FSIMG" ] ; then
@@ -170,8 +170,8 @@ if [ -e "$SQUASHED" ] ; then
     BASE_LOOPDEV=$( losetup -f )
     if [ -f /squashfs/LiveOS/ext3fs.img ]; then
         losetup -r $BASE_LOOPDEV /squashfs/LiveOS/ext3fs.img
-    elif [ -f /squashfs/LiveOS/btrfs.img ]; then
-        losetup -r $BASE_LOOPDEV /squashfs/LiveOS/btrfs.img
+    elif [ -f /squashfs/LiveOS/rootfs.img ]; then
+        losetup -r $BASE_LOOPDEV /squashfs/LiveOS/rootfs.img
     fi
 
     umount -l /squashfs
-- 
1.7.4
