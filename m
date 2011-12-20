From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Create a symlink for the live image's base loop device
Date: Tue, 20 Dec 2011 14:22:33 -0800
Message-ID: <1324419753-14324-1-git-send-email-bcl@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

It is useful to know that loop device that the live image's / is mounted
from. Make a /dev/live-baseloop symlink that points to it.
---
 modules.d/90dmsquash-live/dmsquash-live-root |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index b704139..cb104e4 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -200,6 +200,9 @@ if [ -n "$ROOTFLAGS" ]; then
     ROOTFLAGS="-o $ROOTFLAGS"
 fi
 
+if [ -b "$BASE_LOOPDEV" ]; then
+    ln -s $BASE_LOOPDEV /dev/live-baseloop
+fi
 ln -s /dev/mapper/live-rw /dev/root
 printf '/bin/mount %s /dev/mapper/live-rw %s\n' "$ROOTFLAGS" "$NEWROOT" > $hookdir/mount/01-$$-live.sh
 
-- 
1.7.6.4
