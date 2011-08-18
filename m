From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] 90crypt: ask_for_password pings plymouthd
Date: Thu, 18 Aug 2011 15:55:57 +0200
Message-ID: <1313675757-18330-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

If plymouthd is not started, ask_for_password shouldn't try to prompt
for password with GUI and should use text prompt instead.
---
 modules.d/90crypt/crypt-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90crypt/crypt-lib.sh b/modules.d/90crypt/crypt-lib.sh
index 2797a7a..69f14d0 100755
--- a/modules.d/90crypt/crypt-lib.sh
+++ b/modules.d/90crypt/crypt-lib.sh
@@ -47,7 +47,7 @@ ask_for_password() {
 
     { flock -s 9;
         # Prompt for password with plymouth, if installed and running.
-        if [ -x /bin/plymouth ]; then
+        if [ -x /bin/plymouth ] && /bin/plymouth --ping; then
             /bin/plymouth ask-for-password \
                 --prompt "$ply_prompt" --number-of-tries=$ply_tries \
                 --command="$ply_cmd"
-- 
1.7.6
