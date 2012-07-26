From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 3/7] 98usrmount: print mount options
Date: Thu, 26 Jul 2012 15:05:23 +0200
Message-ID: <1343307927-17079-3-git-send-email-aidecoe@aidecoe.name>
References: <1343307927-17079-1-git-send-email-aidecoe@aidecoe.name>
 <1343307927-17079-2-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343307927-17079-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/98usrmount/mount-usr.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/98usrmount/mount-usr.sh b/modules.d/98usrmount/mount-usr.sh
index 98e08e3..f4d59b3 100755
--- a/modules.d/98usrmount/mount-usr.sh
+++ b/modules.d/98usrmount/mount-usr.sh
@@ -81,7 +81,7 @@ mount_usr()
             fi
         fi
 
-        info "Mounting /usr"
+        info "Mounting /usr with -o $_opts"
         mount "$NEWROOT/usr" 2>&1 | vinfo
 
         if ! ismounted "$NEWROOT/usr"; then
-- 
1.7.8.6
