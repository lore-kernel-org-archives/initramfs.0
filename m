From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 4/7] 98usrmount: [ "x$_usr_found" != "x" ] - removed redundant 'x'
Date: Thu, 26 Jul 2012 15:05:24 +0200
Message-ID: <1343307927-17079-4-git-send-email-aidecoe@aidecoe.name>
References: <1343307927-17079-1-git-send-email-aidecoe@aidecoe.name>
 <1343307927-17079-2-git-send-email-aidecoe@aidecoe.name>
 <1343307927-17079-3-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343307927-17079-3-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
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
index f4d59b3..cca41c3 100755
--- a/modules.d/98usrmount/mount-usr.sh
+++ b/modules.d/98usrmount/mount-usr.sh
@@ -70,7 +70,7 @@ mount_usr()
         fi
     done < "$NEWROOT/etc/fstab" >> /etc/fstab
 
-    if [ "x$_usr_found" != "x" ]; then
+    if [ "$_usr_found" != "" ]; then
         # we have to mount /usr
         _fsck_ret=0
         if ! getargbool 0 rd.skipfsck; then
-- 
1.7.8.6
