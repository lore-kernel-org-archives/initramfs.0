From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] Added missing quotes
Date: Sun, 23 Feb 2014 17:44:48 +0100
Message-ID: <1393173888-10122-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

See bug report at https://bugs.gentoo.org/show_bug.cgi?id=502064
---
 dracut.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut.sh b/dracut.sh
index 5267af5..1e35e09 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -551,7 +551,7 @@ done
 # the old fashioned way
 
 while (($# > 0)); do
-    if [ ${1%%=*} == "++include" ]; then
+    if [ "${1%%=*}" == "++include" ]; then
         push include_src "$2"
         push include_target "$3"
         PARMS_TO_STORE+=" --include '$2' '$3'"
-- 
1.9.0
