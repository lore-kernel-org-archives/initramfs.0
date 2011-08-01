From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] dmsquash-live-root cleanups/mini-fixes
Date: Mon,  1 Aug 2011 16:21:07 -0400
Message-ID: <1312230069-10674-2-git-send-email-wwoods@redhat.com>
References: <1312230069-10674-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312230069-10674-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

- use last ro/rw cmdline arg rather than favoring 'rw' over 'ro'
- don't bother with useless RES variable for holding $?
- only do fs check when $livedev is a block device

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90dmsquash-live/dmsquash-live-root |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index 4d1d902..a76cbc7 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -25,7 +25,8 @@ getargbool 0 rd.live.overlay.reset -y reset_overlay && reset_overlay="yes"
 getargbool 0 rd.live.overlay.readonly -y readonly_overlay && readonly_overlay="--readonly" || readonly_overlay=""
 overlay=$(getarg rd.live.overlay overlay)
 
-[ -e $livedev ] && fs=$(blkid -s TYPE -o value $livedev)
+# CD/DVD media check
+[ -b $livedev ] && fs=$(blkid -s TYPE -o value $livedev)
 if [ "$fs" = "iso9660" -o "$fs" = "udf" ]; then
     check="yes"
 fi
@@ -40,9 +41,7 @@ if [ -n "$check" ]; then
     [ -x /bin/plymouth ] && /bin/plymouth --show-splash
 fi
 
-getarg ro && liverw=ro
-getarg rw && liverw=rw
-[ -z "$liverw" ] && liverw=ro
+for arg in $CMDLINE; do case $arg in ro|rw) liverw=$arg ;; esac; done
 # mount the backing of the live image first
 mkdir -m 0755 -p /run/initramfs/live
 if [ -f $livedev ]; then
@@ -52,9 +51,8 @@ if [ -f $livedev ]; then
         *ext3fs.img|*rootfs.img) FSIMG=$livedev ;;
     esac
 else
-    mount -n -t $fstype -o $liverw $livedev /run/initramfs/live
-    RES=$?
-    if [ "$RES" != "0" ]; then
+    mount -n -t $fstype -o ${liverw:-ro} $livedev /run/initramfs/live
+    if [ "$?" != "0" ]; then
         die "Failed to mount block device of live image"
         exit 1
     fi
-- 
1.7.6
