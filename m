From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] 90crypt: call systemd commands only if systemd binaries are there
Date: Sun,  7 Oct 2012 15:29:02 +0200
Message-ID: <1349616543-1471-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/90crypt/crypt-run-generator.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/modules.d/90crypt/crypt-run-generator.sh b/modules.d/90crypt/crypt-run-generator.sh
index 3264b29..bacdbbe 100755
--- a/modules.d/90crypt/crypt-run-generator.sh
+++ b/modules.d/90crypt/crypt-run-generator.sh
@@ -23,6 +23,9 @@ if strstr "$(cryptsetup --help)" "allow-discards"; then
 fi
 
 echo "$luks $dev none $allowdiscards" >> /etc/crypttab
-systemctl daemon-reload
-systemctl start cryptsetup.target
+
+if command -v systemctl >/dev/null; then
+    systemctl daemon-reload
+    systemctl start cryptsetup.target
+fi
 exit 0
-- 
1.7.12
