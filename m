From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i18n: mention {vconsole,locale}.conf in README
Date: Sat,  6 Nov 2010 17:26:08 +0300
Message-ID: <1289053568-6959-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=QT//iOMkd9JoxoI07+rn43Ruq7tDbaVQIQpziAmRXFQ=;
        b=dOgJe/SVKTGOxY4nO/MuJTqiwRUwf6UcbvAI5Ws8AP63a+p0+mL3HvAvANwjC1xmKz
         CIu/fBM8rhhUtcnCsH0eXNVJPxfZrW+QKnEsgWBuc3U1OqGotQoEmwoHujHR5jvQNEfO
         FU4NNMeLGpw7CbRDmYYwzaG+tfA/ATXT4eDcs=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

i18n does not use /etc/sysconfig/{i18n,keyboard} anymore

Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/10i18n/README |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/10i18n/README b/modules.d/10i18n/README
index db84d02..b2204cd 100644
--- a/modules.d/10i18n/README
+++ b/modules.d/10i18n/README
@@ -31,8 +31,8 @@ with us, so we can include it in source package.
 If you invoke dracut with '-H' option, i18n module install script will
 gather variables values from your configuration files using mappings
 provided in "/etc/dracut.conf.d/<foo>.conf".  Those variables will be
-put in "etc/sysconfig/{i18n,keyboard}" files inside initramfs image.
-Next it will install only declared font, keymaps and so.
+put in "etc/vconsole.conf" and "etc/locale.conf" files inside initramfs
+image. Next it will install only declared font, keymaps and so.
 
 When building generic image (dracut without '-H' option), install script
 copies all content of directories: consolefonts, consoletrans, unimaps
-- 
tg: (1e52b7e..) upstream/02-fix-i18n-README (depends on: master)
