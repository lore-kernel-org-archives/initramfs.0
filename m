From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] apply-live-updates.sh: copy without glob
Date: Thu, 20 Oct 2011 13:57:23 -0400
Message-ID: <1319133444-27980-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

cp $SRC/* $DEST will skip dotfiles in $SRC.
( cd $SRC; cp -a -t $DEST . ) will copy everything.
---
 modules.d/90dmsquash-live/apply-live-updates.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/modules.d/90dmsquash-live/apply-live-updates.sh b/modules.d/90dmsquash-live/apply-live-updates.sh
index dfdb404..8dce5d4 100755
--- a/modules.d/90dmsquash-live/apply-live-updates.sh
+++ b/modules.d/90dmsquash-live/apply-live-updates.sh
@@ -1,7 +1,8 @@
 #!/bin/sh
 if [ -b /dev/mapper/live-rw ]; then
-    if [ "`echo /updates/*`" != "/updates/*" ]; then
+    if pushd /updates &>/dev/null; then
         echo "Applying updates to live image..."
-        /bin/cp -a /updates/* $NEWROOT
+        /bin/cp -a -t $NEWROOT .
+        popd &>/dev/null
     fi
 fi
-- 
1.7.6.4
