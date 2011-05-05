From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/5] .gitignore: ignore dracut.html, dracut.conf.d/*.conf files, test.log
Date: Thu,  5 May 2011 13:34:18 +0200
Message-ID: <1304595261-11077-2-git-send-email-aidecoe@aidecoe.name>
References: <1304595261-11077-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1304595261-11077-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6bcb943..3d02102 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,7 +1,10 @@
 /dracut.8
 /dracut-catimages.8
 /dracut.conf.5
+/dracut.conf.d/*.conf
 /dracut-gencmdline.8
+/dracut.html
 /dracut.kernel.7
 /modules.d/99base/switch_root
+/test/*/test.log
 test*.img
-- 
1.7.5.rc3
