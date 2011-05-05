From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/5] .gitignore: cleanup (prefix paths with /, remove unnecessary)
Date: Thu,  5 May 2011 13:34:17 +0200
Message-ID: <1304595261-11077-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

*~ should be globally ignored anyway.  Paths were prefix with / to be
strict.
---
 .gitignore |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index a689a3e..6bcb943 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,8 +1,7 @@
+/dracut.8
+/dracut-catimages.8
+/dracut.conf.5
+/dracut-gencmdline.8
+/dracut.kernel.7
+/modules.d/99base/switch_root
 test*.img
-modules.d/99base/switch_root
-*~
-dracut.kernel.7
-dracut.conf.5
-dracut.8
-dracut-catimages.8
-dracut-gencmdline.8
-- 
1.7.5.rc3
