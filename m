From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 16/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:52 -0800 (PST)
Message-ID: <f81edb6e325a33f457d328eb3a78051bb6fc2245.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=f1JGYal0LcN4QvHshsknQo0AZlbZYVgSGjlNPJYP7HY=;
        b=P2MwFY8KZ6FklUOqTt2dR7o6pBd9yWE833vrpTL5d/HVvqU8kAdJGzfw4Hl68kfWg6
         /OM8x/Czv55CZ6CzDOA8/mxSyhClB7mOkj0LGvA67JDP/JmSNSzI8MM1lG056/aDYFT8
         Yda0XcUCQ2BE596EqCPk6E/1e1yo4beWsmojc=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

$MNTIMAGE?  I thought the install dir was $initdir.

---
 dracut |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index 13c254f..a19f910 100755
--- a/dracut
+++ b/dracut
@@ -98,10 +98,10 @@ if [ -f /etc/sysconfig/i18n ]; then
         inst "$FN" "$initdir"
         case $FN in
             *.gz)
-                gzip -d "$MNTIMAGE$FN"
+                gzip -d "$initdir$FN"
                 ;;
             *.bz2)
-                bzip2 -d "$MNTIMAGE$FN"
+                bzip2 -d "$initdir$FN"
                 ;;
         esac
     done
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
