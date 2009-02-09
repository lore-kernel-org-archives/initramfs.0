From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 15/31]  Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:46 -0800 (PST)
Message-ID: <465e9ba5717f9bbfd88cb8add5bef9aac1c45ac7.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=rWn4TsrMGUd/VYAnQd8mywA6s+26eiTTdqoXYCqOfgQ=;
        b=qgeN7w3cpHQYTAyFnvY4fvQtbb8JsKpYgbk9Y0KENepntcKCVEcaZ0qq/NHu0kAIrE
         f9E+bcd/lJoja4sAtKcWAD9aijDMFZvzBT16019SVSsDwCdvNPAdKw1IbZg34LroAesX
         tX8K9votEjxOevFwAN+QWz9o/gefODMZMOFjo=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Tighten up the keymap installation case statement in dracut.

---
 dracut |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/dracut b/dracut
index 8cbe0da..13c254f 100755
--- a/dracut
+++ b/dracut
@@ -80,13 +80,9 @@ if [[ -f /etc/sysconfig/keyboard || -f /etc/sysconfig/console/default.kmap ]]; t
 
         for FN in $KEYMAPS; do
             inst $FN "$initdir"
-            case "$FN" in
-                *.gz)
-                    gzip -d "$initdir$FN"
-                    ;;
-                *.bz2)
-                    bzip2 -d "$initdir$FN"
-                    ;;
+            case $FN in
+                *.gz) gzip -d "$initdir$FN" ;;
+                *.bz2) bzip2 -d "$initdir$FN" ;;
             esac
         done
     fi
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
