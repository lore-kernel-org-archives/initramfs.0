From: Joey Boggs <jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] add readonly overlay support for dmsquash
Date: Fri, 26 Feb 2010 09:44:29 -0500
Message-ID: <1267195469-32522-1-git-send-email-jboggs@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joey Boggs <jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Adds the readonly_overlay karg for cases where the dm snapshot should be set to readonly. Use case would be a livecd that is configured to have a readonly root where filling up the dm snapshot would cause a problem.

---
 modules.d/90dmsquash-live/dmsquash-live-root |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index acec91d..f40e048 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -20,6 +20,7 @@ live_dir=$(getarg live_dir)
 [ -z "$live_dir" ] && live_dir="LiveOS"
 getarg live_ram && live_ram="yes"
 getarg reset_overlay && reset_overlay="yes"
+getarg readonly_overlay && readonly_overlay="--readonly" || readonly_overlay=""
 overlay=$(getarg overlay)
 
 # FIXME: we need to be able to hide the plymouth splash for the check really
@@ -95,7 +96,7 @@ do_live_overlay() {
     fi
 
     # set up the snapshot
-    echo 0 `blockdev --getsize $BASE_LOOPDEV` snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 | dmsetup create live-rw
+    echo 0 `blockdev --getsize $BASE_LOOPDEV` snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 | dmsetup create $readonly_overlay live-rw
 }
 
 # live cd helper function
-- 
1.6.6.1
