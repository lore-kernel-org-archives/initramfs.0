From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/7] Look for btrfs.img in dmsquash-live-root
Date: Tue,  8 Mar 2011 18:35:16 -0500
Message-ID: <1299627317-11145-7-git-send-email-wwoods@redhat.com>
References: <1299627317-11145-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299627317-11145-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Btrfs is an excellent option for the root fs image for live systems,
especially since it does its own transparent compression.
---
 modules.d/90dmsquash-live/dmsquash-live-root |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index 95ef05d..f8aa805 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -127,6 +127,8 @@ fi
 # we might have an embedded fs image to use as rootfs (uncompressed live)
 if [ -e /dev/.initramfs/live/${live_dir}/ext3fs.img ]; then
     FSIMG="/dev/.initramfs/live/${live_dir}/ext3fs.img"
+elif [ -e /dev/.initramfs/live/${live_dir}/btrfs.img ]; then
+    FSIMG="/dev/.initramfs/live/${live_dir}/btrfs.img"
 fi
 
 if [ -n "$FSIMG" ] ; then
@@ -158,7 +160,11 @@ if [ -e "$SQUASHED" ] ; then
     mount -n -t squashfs -o ro $SQUASHED_LOOPDEV /squashfs
 
     BASE_LOOPDEV=$( losetup -f )
-    losetup -r $BASE_LOOPDEV /squashfs/LiveOS/ext3fs.img
+    if [ -f /squashfs/LiveOS/ext3fs.img ]; then
+        losetup -r $BASE_LOOPDEV /squashfs/LiveOS/ext3fs.img
+    elif [ -f /squashfs/LiveOS/btrfs.img ]; then
+        losetup -r $BASE_LOOPDEV /squashfs/LiveOS/btrfs.img
+    fi
 
     umount -l /squashfs
 
-- 
1.7.4
