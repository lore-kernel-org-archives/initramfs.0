From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] Mount /dev, /dev/shm and /run noexec
Date: Wed, 25 Mar 2015 08:19:20 +0100
Message-ID: <1427267960-6509-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nikoli <nikoli-0UDz38MK/Mo@public.gmane.org>

From: Nikoli <nikoli-0UDz38MK/Mo@public.gmane.org>

---
 modules.d/99base/init.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index 918dea5..d1bdbb6 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -38,7 +38,7 @@ RD_DEBUG=""
 setdebug
 
 if ! ismounted /dev; then
-    mount -t devtmpfs -o mode=0755,nosuid,strictatime devtmpfs /dev >/dev/null
+    mount -t devtmpfs -o mode=0755,noexec,nosuid,strictatime devtmpfs /dev >/dev/null
 fi
 
 if ! ismounted /dev; then
@@ -59,12 +59,12 @@ fi
 
 if ! ismounted /dev/shm; then
     mkdir -m 0755 /dev/shm
-    mount -t tmpfs -o mode=1777,nosuid,nodev,strictatime tmpfs /dev/shm >/dev/null
+    mount -t tmpfs -o mode=1777,noexec,nosuid,nodev,strictatime tmpfs /dev/shm >/dev/null
 fi
 
 if ! ismounted /run; then
     mkdir -m 0755 /newrun
-    mount -t tmpfs -o mode=0755,nosuid,nodev,strictatime tmpfs /newrun >/dev/null
+    mount -t tmpfs -o mode=0755,noexec,nosuid,nodev,strictatime tmpfs /newrun >/dev/null
     cp -a /run/* /newrun >/dev/null 2>&1
     mount --move /newrun /run
     rm -fr -- /newrun
-- 
2.3.3
