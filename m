From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 18/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:01 -0800 (PST)
Message-ID: <7c1b9750e7ff65ce35177feb52fe9035060cfe8f.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=ZvXi+U1qw6iLFgVCOo9okhHy9GmAI7hJ4VrxFO/xX88=;
        b=Ha0urlvc+d8VvNgZkSu5ZG4bdEkI2cHFC3jzOJxquqMZuiUm2vrDu88Hg+rZVHhiXw
         t9ACTf4BsTc+C+5clMr7VPMxBfYYHbFX8ayHR9Da6Xf8URHMnXZrbaymFQmQ6Wzjuu6v
         wgPKyfWnTZbMNsjux0wOMkVmTnHcuBknw88ho=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

outfile processing can fit all on one line, so make it.

---
 dracut |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index ae53caf..84abdb5 100755
--- a/dracut
+++ b/dracut
@@ -24,8 +24,7 @@ while (($# > 0)); do
 done
 
 [[ $2 ]] && kernel=$2 || kernel=$(uname -r)
-[[ $1 ]] && outfile=$(readlink -f $1) || \
-    outfile="/boot/initrd-$kernel.img"
+[[ $1 ]] && outfile=$(readlink -f $1) || outfile="/boot/initrd-$kernel.img"
 
 if [[ -f $outfile && ! $force ]]; then
     echo "Will not override existing initramfs ($outfile) without --force"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
