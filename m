From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] crypt-lib.sh: moved IFS=: from before 'read' to before 'while'
Date: Mon,  7 Mar 2011 13:48:02 +0100
Message-ID: <1299502082-13309-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Some versions of dash don't behave as expected with code like this:

while IFS=: read a b c; do
    blah
done

Thanks to Eric Mertens who identified the issue.
---
 modules.d/90crypt/crypt-lib.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
index 9083aca..09e793d 100644
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -108,7 +108,8 @@ getkey() {
     [ -z "$keys_file" -o -z "$for_dev" ] && die 'getkey: wrong usage!'
     [ -f "$keys_file" ] || return 1
 
-    while IFS=':' read luks_dev key_dev key_path; do
+    local IFS=:
+    while read luks_dev key_dev key_path; do
         if match_dev "$luks_dev" "$for_dev"; then
             echo "${key_dev}:${key_path}"
             return 0
-- 
1.7.4.1
