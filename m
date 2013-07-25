From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] crypt: Skip /etc/crypttab if not present
Date: Thu, 25 Jul 2013 23:28:44 +0200
Message-ID: <1374787724-27608-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Prevents following error message:

I: *** Including module: crypt ***
/usr/lib/dracut/modules.d/90crypt/module-setup.sh: line 31: /etc/crypttab: No such file or directory
---
 modules.d/90crypt/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90crypt/module-setup.sh b/modules.d/90crypt/module-setup.sh
index 639a77f..6b32b6a 100755
--- a/modules.d/90crypt/module-setup.sh
+++ b/modules.d/90crypt/module-setup.sh
@@ -57,7 +57,7 @@ install() {
         inst_hook cleanup 30 "$moddir/crypt-cleanup.sh"
     fi
 
-    if [[ $hostonly ]]; then
+    if [[ $hostonly ]] && [[ -f /etc/cryptab ]]; then
         # filter /etc/crypttab for the devices we need
         while read _mapper _dev _rest; do
             [[ $_mapper = \#* ]] && continue
-- 
1.8.3.2
