From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut: don't fail on empty /etc/ld.so.conf.d/
Date: Sat,  2 Apr 2011 00:45:44 +0200
Message-ID: <1301697944-12372-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index c6605bb..15a5ee5 100755
--- a/dracut
+++ b/dracut
@@ -524,7 +524,9 @@ done
 unset item
 
 # make sure that library links are correct and up to date
-dracut_install /etc/ld.so.conf /etc/ld.so.conf.d/*
+for f in /etc/ld.so.conf /etc/ld.so.conf.d/*; do
+    [[ -e $f ]] && dracut_install "$f"
+done
 if ! ldconfig -r "$initdir"; then
     if [[ $UID = 0 ]]; then
         derror "ldconfig exited ungracefully"
-- 
1.7.4.1
