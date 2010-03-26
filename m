From: Joey Boggs <jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] teach dmsquash-live-root to use rootflags
Date: Fri, 26 Mar 2010 10:01:16 -0400
Message-ID: <1269612076-18504-1-git-send-email-jboggs@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joey Boggs <jboggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/90dmsquash-live/dmsquash-live-root |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index b1754dc..c98cdef 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -172,7 +172,12 @@ if [ -b "$OSMIN_LOOPDEV" ]; then
     echo "0 $( blockdev --getsz $BASE_LOOPDEV ) snapshot $BASE_LOOPDEV $OSMIN_LOOPDEV p 8" | dmsetup create --readonly live-osimg-min
 fi
 
+ROOTFLAGS="$(getarg rootflags)"
+if [ -n "$ROOTFLAGS" ]; then
+    ROOTFLAGS="-o $ROOTFLAGS"
+fi
+
 ln -s /dev/mapper/live-rw /dev/root
-printf '/bin/mount /dev/mapper/live-rw %s\n' "$NEWROOT" > /mount/01-$$-live.sh
+printf '/bin/mount %s /dev/mapper/live-rw %s\n' "$ROOTFLAGS" "$NEWROOT" > /mount/01-$$-live.sh
 
 exit 0
-- 
1.6.6.1
