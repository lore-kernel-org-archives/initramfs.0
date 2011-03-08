From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/7] Change EXT3FS to FSIMG
Date: Tue,  8 Mar 2011 18:35:14 -0500
Message-ID: <1299627317-11145-5-git-send-email-wwoods@redhat.com>
References: <1299627317-11145-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299627317-11145-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Change the EXT3FS variable to FSIMG, since we might want to use other
filesystems as our live root. Change comments to reflect this fact.
---
 modules.d/90dmsquash-live/dmsquash-live-root |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index e7c9626..95ef05d 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -124,19 +124,19 @@ if [ -n "$OSMINSQFS" ]; then
     umount -l /squashfs.osmin
 fi
 
-# we might have just an embedded ext3 to use as rootfs (uncompressed live)
+# we might have an embedded fs image to use as rootfs (uncompressed live)
 if [ -e /dev/.initramfs/live/${live_dir}/ext3fs.img ]; then
-    EXT3FS="/dev/.initramfs/live/${live_dir}/ext3fs.img"
+    FSIMG="/dev/.initramfs/live/${live_dir}/ext3fs.img"
 fi
 
-if [ -n "$EXT3FS" ] ; then
+if [ -n "$FSIMG" ] ; then
     BASE_LOOPDEV=$( losetup -f )
-    losetup -r $BASE_LOOPDEV $EXT3FS
+    losetup -r $BASE_LOOPDEV $FSIMG
 
     do_live_from_base_loop
 fi
 
-# we might have an embedded ext3 on squashfs to use as rootfs (compressed live)
+# we might have an embedded fs image on squashfs (compressed live)
 if [ -e /dev/.initramfs/live/${live_dir}/squashfs.img ]; then
     SQUASHED="/dev/.initramfs/live/${live_dir}/squashfs.img"
 fi
-- 
1.7.4
