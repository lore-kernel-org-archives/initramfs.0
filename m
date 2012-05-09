From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Fail to boot if mediacheck fails (#817419)
Date: Wed,  9 May 2012 11:15:03 -0700
Message-ID: <1336587303-3778-1-git-send-email-bcl@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

The return value of checkisomd5 was being ignored.
---
 modules.d/90dmsquash-live/dmsquash-live-root.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index 2aaec28..fdbd6f5 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -33,7 +33,7 @@ fi
 getarg rd.live.check check || check=""
 if [ -n "$check" ]; then
     [ -x /bin/plymouth ] && /bin/plymouth --hide-splash
-    checkisomd5 --verbose $livedev || :
+    checkisomd5 --verbose $livedev
     if [ $? -ne 0 ]; then
         die "CD check failed!"
         exit 1
-- 
1.7.7.6
