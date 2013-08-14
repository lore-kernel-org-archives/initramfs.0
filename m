From: fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH] Boot a Live USB device as read-only after persisting some changes.
Date: Wed, 14 Aug 2013 16:38:05 -0400
Message-ID: <1376512685-4713-1-git-send-email-fgrose@gmail.com>
References: <520B4BE5.6030003@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wWN+5BXPtq/NlR0xm5r+T5OpDKPFuLLPlUFTJhNSFrY=;
        b=KsnQbZyzbK2xQihbz+U8dUAs1nFQbHIR7gycEJwaxy+5MZ2yCi8ajpn7caE8rHk35k
         wLcbYePREGiXowSeRgOrtQDacyMTDKPbjbz67b6WrxWBQOA13OagQ2rNZN/IdLsWUkbd
         tQcXxwS72BVAUQmSMUz9Qu4CSlAYYLVEeCgW+0wXwCq8JfZRT1lSV260mB/I+hjBfTGk
         2ypDvwBQPDalgfDjhBAJk/Q9ZRWtMupTs52jLwknl2ov90mI9T62801C8p3PqSOpFiEw
         mE/+rmZ/lS+ui3G5rmNifEajvc1eCWORcWwWId9xpUJ/uJCxSayL6+tJO/gV8PYZ9vk9
         JczQ==
In-Reply-To: <520B4BE5.6030003-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, livecd-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, spins-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org
Cc: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>

From: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>

commit 96ff19a87c0be1eca27860aeef5434513b0e8c61
Author: Frederick Grose <fgrose-agl9EP5VjmEgsBAKwltoeQ@public.gmane.org>

    Allow read-only mounting of the base device filesystem, livedev.
    Use read-only loop devices and non-persistent overlay targets.

---
 modules.d/90dmsquash-live/dmsquash-live-root.sh | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index 14e84e1..af0022f 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -24,7 +24,7 @@ squash_image=$(getarg rd.live.squashimg)
 
 getargbool 0 rd.live.ram -d -y live_ram && live_ram="yes"
 getargbool 0 rd.live.overlay.reset -d -y reset_overlay && reset_overlay="yes"
-getargbool 0 rd.live.overlay.readonly -d -y readonly_overlay && readonly_overlay="--readonly" || readonly_overlay=""
+getargbool 0 rd.live.overlay.readonly -d -y readonly_overlay && readonly_overlay="-r" || readonly_overlay=""
 overlay=$(getarg rd.live.overlay -d overlay)
 
 # CD/DVD media check
@@ -105,17 +105,23 @@ do_live_overlay() {
     setup=""
     if [ -n "$devspec" -a -n "$pathspec" -a -n "$overlay" ]; then
         mkdir -m 0755 /run/initramfs/overlayfs
-        mount -n -t auto $devspec /run/initramfs/overlayfs || :
-        if [ -f /run/initramfs/overlayfs$pathspec -a -w /run/initramfs/overlayfs$pathspec ]; then
-            losetup $OVERLAY_LOOPDEV /run/initramfs/overlayfs$pathspec
-            if [ -n "$reset_overlay" ]; then
-                dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1 conv=fsync 2>/dev/null
+        mount -n -t auto -o $liverw $devspec /run/initramfs/overlayfs || :
+        if [ -f /run/initramfs/overlayfs$pathspec ]; then
+            if [ "$liverw" = ro ]; then
+                readonly_overlay='-r'
+            fi
+            losetup $readonly_overlay $OVERLAY_LOOPDEV /run/initramfs/overlayfs$pathspec
+            if [ -w /run/initramfs/overlayfs$pathspec ]; then
+                if [ -n "$reset_overlay" ]; then
+                    dd if=/dev/zero of=$OVERLAY_LOOPDEV bs=64k count=1 conv=fsync 2>/dev/null
+                fi
             fi
             setup="yes"
         fi
         umount -l /run/initramfs/overlayfs || :
     fi
 
+    persistent='P'
     if [ -z "$setup" -o -n "$readonly_overlay" ]; then
         if [ -n "$setup" ]; then
             warn "Using temporary overlay."
@@ -123,6 +129,7 @@ do_live_overlay() {
             warn "Unable to find persistent overlay; using temporary"
             sleep 5
         fi
+        persistent='N'
 
         dd if=/dev/null of=/overlay bs=1024 count=1 seek=$((512*1024)) 2> /dev/null
         if [ -n "$setup" -a -n "$readonly_overlay" ]; then
@@ -136,14 +143,14 @@ do_live_overlay() {
     # set up the snapshot
     sz=$(blockdev --getsz $BASE_LOOPDEV)
     if [ -n "$readonly_overlay" ]; then
-        echo 0 $sz snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV p 8 | dmsetup create $readonly_overlay live-ro
+        echo 0 $sz snapshot $BASE_LOOPDEV $OVERLAY_LOOPDEV N 8 | dmsetup create $readonly_overlay live-ro
         base="/dev/mapper/live-ro"
         over=$RO_OVERLAY_LOOPDEV
     else
         base=$BASE_LOOPDEV
         over=$OVERLAY_LOOPDEV
     fi
-    echo 0 $sz snapshot $base $over p 8 | dmsetup create live-rw
+    echo 0 $sz snapshot $base $over $persistent 8 | dmsetup create live-rw
 }
 
 # live cd helper function
@@ -217,7 +224,7 @@ fi
 if [ -b "$OSMIN_LOOPDEV" ]; then
     # set up the devicemapper snapshot device, which will merge
     # the normal live fs image, and the delta, into a minimzied fs image
-    echo "0 $( blockdev --getsz $BASE_LOOPDEV ) snapshot $BASE_LOOPDEV $OSMIN_LOOPDEV p 8" | dmsetup create --readonly live-osimg-min
+    echo "0 $( blockdev --getsz $BASE_LOOPDEV ) snapshot $BASE_LOOPDEV $OSMIN_LOOPDEV N 8" | dmsetup create --readonly live-osimg-min
 fi
 
 ROOTFLAGS="$(getarg rootflags)"
-- 
1.8.3.1
