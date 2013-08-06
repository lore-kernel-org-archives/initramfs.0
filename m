From: James Lee <jlee-RWYTM8lfiZY4k1Tz1RznXQC/G2K4zDHf@public.gmane.org>
Subject: [PATCH] crypt: Fix typo--/etc/crypttab not /etc/cryptab
Date: Tue,  6 Aug 2013 11:25:58 -0400
Message-ID: <1375802758-27692-1-git-send-email-jlee@thestaticvoid.com>
References: <51F918F8.7080201@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51F918F8.7080201-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: James Lee <jlee-RWYTM8lfiZY4k1Tz1RznXQC/G2K4zDHf@public.gmane.org>

1ae8b8a breaks the crypt module for those who use keyfiles due to a
typo leading to the exclusion of /etc/crypttab from the initrd.
---
 modules.d/90crypt/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90crypt/module-setup.sh b/modules.d/90crypt/module-setup.sh
index 6b32b6a..31e0e5f 100755
--- a/modules.d/90crypt/module-setup.sh
+++ b/modules.d/90crypt/module-setup.sh
@@ -57,7 +57,7 @@ install() {
         inst_hook cleanup 30 "$moddir/crypt-cleanup.sh"
     fi
 
-    if [[ $hostonly ]] && [[ -f /etc/cryptab ]]; then
+    if [[ $hostonly ]] && [[ -f /etc/crypttab ]]; then
         # filter /etc/crypttab for the devices we need
         while read _mapper _dev _rest; do
             [[ $_mapper = \#* ]] && continue
-- 
1.8.1.2
