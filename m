From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/2] crypt: changed cmdline arg name from rd.luks.tout to rd.luks.key.tout
Date: Sun, 21 Aug 2011 10:26:40 +0200
Message-ID: <1313915200-13079-1-git-send-email-aidecoe@aidecoe.name>
References: <loom.20110818T175530-594@post.gmane.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20110818T175530-594-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/90crypt/parse-crypt.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-crypt.sh
index c76fb23..ff86700 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -11,7 +11,7 @@ else
     } > /etc/udev/rules.d/70-luks.rules.new
 
     LUKS=$(getargs rd.luks.uuid rd_LUKS_UUID)
-    tout=$(getarg rd.luks.tout)
+    tout=$(getarg rd.luks.key.tout)
 
     if [ -n "$LUKS" ]; then
         for luksid in $LUKS; do
-- 
1.7.6
