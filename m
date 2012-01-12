From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] 98usrmount: don't pass fstab fs options as fsck options
Date: Thu, 12 Jan 2012 12:48:25 +0100
Message-ID: <1326368905-29873-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

For example for line in /etc/fstab:

  /dev/vg/usr  /usr  ext4  nosuid,nodev  0 2

fsck_single is called as follows:

  fsck_single /dev/vg/usr ext4 nosuid,nodev

and this eventually resolves to:

  e2fsck -a nosuid,nodev /dev/vg/usr

which causes e2fsck usage error.
---
 modules.d/98usrmount/mount-usr.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/98usrmount/mount-usr.sh b/modules.d/98usrmount/mount-usr.sh
index a61f935..fc205d5 100755
--- a/modules.d/98usrmount/mount-usr.sh
+++ b/modules.d/98usrmount/mount-usr.sh
@@ -19,7 +19,7 @@ mount_usr()
 
     if [ "x$_usr_found" != "x" ]; then
         # we have to mount /usr
-        fsck_single "$_dev" "$_fs" "$_opts"
+        fsck_single "$_dev" "$_fs"
         _ret=$?
         echo $_ret >/run/initramfs/usr-fsck
         if [ $_ret -ne 255 ]; then
@@ -29,4 +29,4 @@ mount_usr()
     fi
 }
 
-mount_usr
\ No newline at end of file
+mount_usr
-- 
1.7.8.3
