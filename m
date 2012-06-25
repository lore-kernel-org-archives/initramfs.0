From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/4] 98usrmount: depend on fs-lib
Date: Mon, 25 Jun 2012 18:32:00 +0200
Message-ID: <1340641923-14477-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/98usrmount/module-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/98usrmount/module-setup.sh b/modules.d/98usrmount/module-setup.sh
index 5844383..69d22d8 100755
--- a/modules.d/98usrmount/module-setup.sh
+++ b/modules.d/98usrmount/module-setup.sh
@@ -8,7 +8,7 @@ check() {
 }
 
 depends() {
-    return 0
+    echo 'fs-lib'
 }
 
 install() {
-- 
1.7.8.6
