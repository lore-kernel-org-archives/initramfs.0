From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i18n: fix udev error due to empty rules file
Date: Fri,  5 Nov 2010 19:31:38 +0300
Message-ID: <1288974698-21387-1-git-send-email-arvidjaar@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=8ntjmWkBujtx8Irg3RMTdLr9aE5oLjzBcFsuRPNIVsc=;
        b=kzUYdjrfmjWCFzwt41+nIcgTOiM7VeMonJ75Clmd5x6otaKlmtiaya5Hcws1RCx3W5
         X9K44/7/Mf6QiMsemtUj9VrMjuFheq88VhdJVh+4czZnuQ02h/gjLbR1ucHgtGwPcBhK
         DvxRd4YUeKLdqRSxjqDCj+h+qsPgnOdJjDSiU=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Empty rule file is causing udev error:

dracut: udevd[99]: can not read '/etc/udev/rules.d/10-console.rules'

Remove file completely instead of truncating it.

Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/10i18n/parse-i18n.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/10i18n/parse-i18n.sh b/modules.d/10i18n/parse-i18n.sh
index 0a58cc2..8f7f8f8 100755
--- a/modules.d/10i18n/parse-i18n.sh
+++ b/modules.d/10i18n/parse-i18n.sh
@@ -35,5 +35,5 @@ if [ -e /dev/tty0 ]; then
     # if the device already exists, yes
     # clear the udev rules and run it
     /lib/udev/console_init /dev/tty0
-    > /etc/udev/rules.d/10-console.rules
+    rm /etc/udev/rules.d/10-console.rules
 fi
-- 
tg: (65d247d..) upstream/02-i18n-udev-rules (depends on: upstream/01-merge-resume)
