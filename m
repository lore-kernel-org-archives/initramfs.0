From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] crypt: installing all crypto kernel modules instead of few selected
Date: Mon,  7 Mar 2011 17:16:54 +0100
Message-ID: <1299514614-10423-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/90crypt/module-setup.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/modules.d/90crypt/module-setup.sh b/modules.d/90crypt/module-setup.sh
index 5b435e5..8745477 100755
--- a/modules.d/90crypt/module-setup.sh
+++ b/modules.d/90crypt/module-setup.sh
@@ -31,8 +31,7 @@ depends() {
 }
 
 installkernel() {
-    instmods dm_crypt cbc sha256 xts aes aes_generic aesni-intel aes-x86_64 fpu
-
+    instmods dm_crypt =crypto
 }
 
 install() {
-- 
1.7.4.1
