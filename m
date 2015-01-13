From: Radek Vykydal <rvykydal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Add rd.live.overlay.size option
Date: Tue, 13 Jan 2015 15:14:10 +0100
Message-ID: <1421158450-15459-1-git-send-email-rvykydal@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/90dmsquash-live/dmsquash-live-root.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index d921f0c..a67fbd0 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -27,6 +27,8 @@ getargbool 0 rd.live.overlay.reset -d -y reset_overlay && reset_overlay="yes"
 getargbool 0 rd.live.overlay.readonly -d -y readonly_overlay && readonly_overlay="--readonly" || readonly_overlay=""
 overlay=$(getarg rd.live.overlay -d overlay)
 getargbool 0 rd.writable.fsimg -d -y writable_fsimg && writable_fsimg="yes"
+overlay_size=$(getarg rd.live.overlay.size=)
+[ -z "$overlay_size" ] && overlay_size=512
 
 # CD/DVD media check
 [ -b $livedev ] && fs=$(blkid -s TYPE -o value $livedev)
@@ -125,7 +127,7 @@ do_live_overlay() {
             sleep 5
         fi
 
-        dd if=/dev/null of=/overlay bs=1024 count=1 seek=$((512*1024)) 2> /dev/null
+        dd if=/dev/null of=/overlay bs=1024 count=1 seek=$((overlay_size*1024)) 2> /dev/null
         if [ -n "$setup" -a -n "$readonly_overlay" ]; then
             RO_OVERLAY_LOOPDEV=$( losetup -f )
             losetup $RO_OVERLAY_LOOPDEV /overlay
-- 
1.9.3
