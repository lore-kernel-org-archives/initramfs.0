From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] listing modules fixed
Date: Tue,  8 Mar 2011 22:13:34 +0100
Message-ID: <1299618814-16400-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Modules were not listed because code relied on deprecated 'install' and
'installkernel' scripts.
---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 6e6de1e..ef8d398 100755
--- a/dracut
+++ b/dracut
@@ -227,7 +227,7 @@ export dracutfunctions
 [[ $do_list = yes ]] && {
     for mod in $dracutbasedir/modules.d/*; do
         [[ -d $mod ]] || continue;
-        [[ -e $mod/install || -e $mod/installkernel ]] || continue;
+        [[ -e $mod/module-setup.sh ]] || continue;
         echo ${mod##*/??}
     done
     exit 0
-- 
1.7.4.1
