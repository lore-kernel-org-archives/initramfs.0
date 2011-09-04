From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut: create /dev besides /proc, /sys and so
Date: Sun,  4 Sep 2011 16:38:35 +0200
Message-ID: <1315147115-18316-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

How it worked without it?  The issue only manifests itself with
initramfs integrated into kernel.
---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index fd36805..b317d70 100755
--- a/dracut
+++ b/dracut
@@ -510,7 +510,7 @@ if [[ $kernel_only != yes ]]; then
         fi
     done
 
-    for d in proc sys sysroot root run run/lock run/initramfs; do
+    for d in dev proc sys sysroot root run run/lock run/initramfs; do
         if [ -h "/$d" ]; then
             inst "/$d"
         else
-- 
1.7.6.1
