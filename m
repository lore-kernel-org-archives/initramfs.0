From: apevec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH] dmsquash-live: hide plymouth while checking ISO
Date: Thu,  7 Apr 2011 01:53:51 +0200
Message-ID: <1302134031-25684-1-git-send-email-apevec@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Alan Pevec <apevec-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Fixes long-standing FIXME
Latest isomd5sum added an option to abort media check with ESC key,
but that key is taken by plymouth for switching to the detailed log
messages, making it impossible to abort checkisomd5.
Tested in text mode.
---
 modules.d/90dmsquash-live/dmsquash-live-root |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index 16262b6..cb0a050 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -25,18 +25,19 @@ getargbool 0 rd.live.overlay.reset -y reset_overlay && reset_overlay="yes"
 getargbool 0 rd.live.overlay.readonly -y readonly_overlay && readonly_overlay="--readonly" || readonly_overlay=""
 overlay=$(getarg rd.live.overlay overlay)
 
-# FIXME: we need to be able to hide the plymouth splash for the check really
 [ -e $livedev ] && fs=$(blkid -s TYPE -o value $livedev)
 if [ "$fs" = "iso9660" -o "$fs" = "udf" ]; then
     check="yes"
 fi
 getarg rd.live.check check || check=""
 if [ -n "$check" ]; then
+    [ -x /bin/plymouth ] && /bin/plymouth --hide-splash
     checkisomd5 --verbose $livedev || :
     if [ $? -ne 0 ]; then
         die "CD check failed!"
         exit 1
     fi
+    [ -x /bin/plymouth ] && /bin/plymouth --show-splash
 fi
 
 getarg ro && liverw=ro
-- 
1.7.3.4
