From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 3/3] LatArCyrHeb-16 as a default i18n font for Gentoo
Date: Thu, 20 Jun 2013 20:33:59 +0200
Message-ID: <1371753239-19780-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.conf.d/gentoo.conf.example | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dracut.conf.d/gentoo.conf.example b/dracut.conf.d/gentoo.conf.example
index b78e5c6..f9617f0 100644
--- a/dracut.conf.d/gentoo.conf.example
+++ b/dracut.conf.d/gentoo.conf.example
@@ -11,5 +11,6 @@ ro_mnt=yes
 
 # i18n
 i18n_vars="/etc/conf.d/keymaps:keymap-KEYMAP,extended_keymaps-EXT_KEYMAPS /etc/conf.d/consolefont:consolefont-FONT,consoletranslation-FONT_MAP /etc/rc.conf:unicode-UNICODE"
+i18n_default_font="LatArCyrHeb-16"
 
 omit_drivers+=" i2o_scsi"
-- 
1.8.2.1
