From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] fix c0a82e271e2730159f042ee7d7fc4aca2e08d28a
Date: Sat, 19 Feb 2011 09:57:55 +0300
Message-ID: <1298098675-24424-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=d4ESPaArrYh72UZT17KDGzDnFvZPx1ryweqzhen/Vxc=;
        b=kcVU9RJRvobWp+bMtoO2PBURY9CptfMw2JylwT/3IKkuUGiwx09k6M3Ol9K6saG8O2
         nZAiugxmtZQz+C0m3U1OAEHDwIIybZY9DTApOg/f4CgRt7BOjJcj7lBoKXG5cBtpQp1G
         zy40Vq5geCBi3NNlobT/y+2BVPxDHO+WC3jRA=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Let inst_key_val usage agree with above patch :)

Also UNICODE is rather global console property, not font specific
(and if anything, is rather keyboard specific). Let it be just
vconsole.unicode

Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/10i18n/parse-i18n.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/modules.d/10i18n/parse-i18n.sh b/modules.d/10i18n/parse-i18n.sh
index 61280c0..73dff6e 100755
--- a/modules.d/10i18n/parse-i18n.sh
+++ b/modules.d/10i18n/parse-i18n.sh
@@ -19,15 +19,15 @@ inst_key_val() {
     unset _value
 }
 
-inst_key_val /etc/vconsole.conf '' KEYMAP      vconsole.keymap      KEYTABLE
-inst_key_val /etc/vconsole.conf '' FONT        vconsole.font        SYSFONT 
-inst_key_val /etc/vconsole.conf '' FONT_MAP    vconsole.font.map    CONTRANS 
-inst_key_val /etc/vconsole.conf '' FONT_UNIMAP vconsole.font.unimap UNIMAP 
-inst_key_val /etc/vconsole.conf 1  UNICODE     vconsole.font.unicode
-inst_key_val /etc/vconsole.conf '' EXT_KEYMAP  vconsole.keymap.ext
+inst_key_val '' /etc/vconsole.conf KEYMAP      vconsole.keymap      KEYTABLE
+inst_key_val '' /etc/vconsole.conf FONT        vconsole.font        SYSFONT 
+inst_key_val '' /etc/vconsole.conf FONT_MAP    vconsole.font.map    CONTRANS 
+inst_key_val '' /etc/vconsole.conf FONT_UNIMAP vconsole.font.unimap UNIMAP 
+inst_key_val 1  /etc/vconsole.conf UNICODE     vconsole.unicode
+inst_key_val '' /etc/vconsole.conf EXT_KEYMAP  vconsole.keymap.ext
 
-inst_key_val /etc/locale.conf   LANG   locale.LANG
-inst_key_val /etc/locale.conf   LC_ALL locale.LC_ALL
+inst_key_val '' /etc/locale.conf   LANG        locale.LANG
+inst_key_val '' /etc/locale.conf   LC_ALL      locale.LC_ALL
 
 if [ -f /etc/locale.conf ]; then
     . /etc/locale.conf
-- 
tg: (9edf1b2..) upstream/fix-c0a82e (depends on: master)
