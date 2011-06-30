From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] crypt: dropped plymouth --has-active-vt check on passwd prompt
Date: Thu, 30 Jun 2011 23:49:20 +0200
Message-ID: <1309470560-16173-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

As Ray Strode explains, plymouth --has-active-vt may fail if the user
passes console=ttyS0 or something other not corresponding to
console=tty0, because plymouth is outputing to the serial console and
not a VT in this case.
---
 modules.d/90crypt/crypt-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
index 122d88e..3ef8482 100644
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -47,7 +47,7 @@ ask_for_password() {
 
     { flock -s 9;
         # Prompt for password with plymouth, if installed and running.
-        if [ -x /bin/plymouth ] && /bin/plymouth --has-active-vt; then
+        if [ -x /bin/plymouth ]; then
             /bin/plymouth ask-for-password \
                 --prompt "$ply_prompt" --number-of-tries=$ply_tries \
                 --command="$ply_cmd"
-- 
1.7.5.3
