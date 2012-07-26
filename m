From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/3] Remove obsolete gentoo conf file.
Date: Thu, 26 Jul 2012 09:35:56 +0200
Message-ID: <1343288158-12343-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.conf.d/gentoo-openrc.conf.example |    9 ---------
 dracut.conf.d/gentoo.conf.example        |    6 +++---
 2 files changed, 3 insertions(+), 12 deletions(-)
 delete mode 100644 dracut.conf.d/gentoo-openrc.conf.example

diff --git a/dracut.conf.d/gentoo-openrc.conf.example b/dracut.conf.d/gentoo-openrc.conf.example
deleted file mode 100644
index f5aa8ed..0000000
--- a/dracut.conf.d/gentoo-openrc.conf.example
+++ /dev/null
@@ -1,9 +0,0 @@
-# /etc/dracut.conf.d/gentoo-openrc.conf
-# Dracut config file customized for Gentoo Base System release 2
-
-#
-# Modules
-#
-
-# i18n
-i18n_vars="/etc/conf.d/keymaps:keymap-KEYMAP,extended_keymaps-EXT_KEYMAPS /etc/conf.d/consolefont:consolefont-FONT,consoletranslation-FONT_MAP /etc/rc.conf:unicode-UNICODE"
diff --git a/dracut.conf.d/gentoo.conf.example b/dracut.conf.d/gentoo.conf.example
index a40b746..f5aa8ed 100644
--- a/dracut.conf.d/gentoo.conf.example
+++ b/dracut.conf.d/gentoo.conf.example
@@ -1,9 +1,9 @@
-# /etc/dracut.conf.d/gentoo.conf
-# Dracut config file customized for Gentoo Base System release 1
+# /etc/dracut.conf.d/gentoo-openrc.conf
+# Dracut config file customized for Gentoo Base System release 2
 
 #
 # Modules
 #
 
 # i18n
-i18n_vars="/etc/conf.d/keymaps:KEYMAP,EXTENDED_KEYMAPS-EXT_KEYMAPS /etc/conf.d/consolefont:CONSOLEFONT-FONT,CONSOLETRANSLATION-FONT_MAP /etc/rc.conf:UNICODE"
+i18n_vars="/etc/conf.d/keymaps:keymap-KEYMAP,extended_keymaps-EXT_KEYMAPS /etc/conf.d/consolefont:consolefont-FONT,consoletranslation-FONT_MAP /etc/rc.conf:unicode-UNICODE"
-- 
1.7.8.6
