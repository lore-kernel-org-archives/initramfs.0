From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 17/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:56 -0800 (PST)
Message-ID: <6f64c7360a8fbded4acd33cedbc5c07046a2e906.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=rNPjkynqoe/vCQwp/hbzifYCk6mAYw5GmqUFiUMuwWU=;
        b=AcOWIj3RJMHo1wDvEfiJAo3YeRy0605O3VnOlYBHh5Bu7Pix0goGrYNMgMYtHq060Q
         00gYS7xuulRDtQeyiwMJZX5oupU4Iq2TsHke3pAnFW1n8ojj7KzcyE/Ven40ShlW5vkv
         sk3mnGilN/XAN3xp3JCBZQKPHsw4pFBZzfaR0=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Tighten up the font installation case statement as well.

---
 dracut |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/dracut b/dracut
index a19f910..ae53caf 100755
--- a/dracut
+++ b/dracut
@@ -97,12 +97,8 @@ if [ -f /etc/sysconfig/i18n ]; then
     for FN in /lib/kbd/consolefonts/$SYSFONT.* ; do
         inst "$FN" "$initdir"
         case $FN in
-            *.gz)
-                gzip -d "$initdir$FN"
-                ;;
-            *.bz2)
-                bzip2 -d "$initdir$FN"
-                ;;
+            *.gz) gzip -d "$initdir$FN" ;;
+            *.bz2) bzip2 -d "$initdir$FN" ;;
         esac
     done
     [[ $SYSFONTACM ]] && inst /lib/kbd/consoletrans/$SYSFONTACM "$initdir"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
