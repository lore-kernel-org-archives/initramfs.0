From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] dmsquash-live-root: determine img type by contents, not name
Date: Mon,  1 Aug 2011 16:21:08 -0400
Message-ID: <1312230069-10674-3-git-send-email-wwoods@redhat.com>
References: <1312230069-10674-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312230069-10674-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Currently dmsquash-live-root requires that squashfs images be named
"squashfs.img" and all others be "ext3fs.img" or "rootfs.img".

If we've got a live image in initramfs, this patch will make dracut use
losetup and det_fs to determine the actual filesystem type of the image.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90dmsquash-live/dmsquash-live-root |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index a76cbc7..265de19 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -41,14 +41,23 @@ if [ -n "$check" ]; then
     [ -x /bin/plymouth ] && /bin/plymouth --show-splash
 fi
 
+# determine filesystem type for a filesystem image
+det_img_fs() {
+    local _img="$1" _loop=$(losetup -f) _fs
+    losetup $_loop $_img; _fs=$(det_fs $_loop); losetup -d $_loop
+    echo $_fs
+}
+
 for arg in $CMDLINE; do case $arg in ro|rw) liverw=$arg ;; esac; done
 # mount the backing of the live image first
 mkdir -m 0755 -p /run/initramfs/live
 if [ -f $livedev ]; then
     # no mount needed - we've already got the LiveOS image in initramfs
-    case $livedev in
-        *squashfs.img) SQUASHED=$livedev ;;
-        *ext3fs.img|*rootfs.img) FSIMG=$livedev ;;
+    # check filesystem type and handle accordingly
+    case `det_img_fs $livedev` in
+        squashfs) SQUASHED=$livedev ;;
+        auto) die "cannot mount live image (unknown filesystem type)" ;;
+        *) FSIMG=$livedev ;;
     esac
 else
     mount -n -t $fstype -o ${liverw:-ro} $livedev /run/initramfs/live
-- 
1.7.6
