From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/16] Just test the status of the cpio-and-compress pipe directly.
Date: Sat, 14 Aug 2010 14:23:25 -0500 (CDT)
Message-ID: <5ed737a5c528dcafd5e9840e476627ad4c1efe10.1281812506.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=RtJTsUN2x9fN3wBrN4ARiJCLmNRCnZlXp+J+/l6UqRU=;
        b=JMzMkCnoMsemOML2Ngz1HBJy/febZATwZHjd6B0urA8nMSFKAilkcsZ8+/Q2o+a4MM
         jaee7IXjozPOS4QFktiR/caYXxlDnbdNOAqPlJyXoIAikL/1377J2QZAgmvsD69eKS0a
         EbPDvvcJAcDJ/vxGMcd92Vr5nR6Ps1jYAPUX0=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dracut |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index 5c1c4b4..1242f42 100755
--- a/dracut
+++ b/dracut
@@ -340,8 +340,8 @@ type hardlink &>/dev/null && {
 }
 
 [[ $compress = gzip* ]] && type pigz > /dev/null 2>&1 && compress="pigz -9"
-( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet |$compress > "$outfile"; ) 
-if [ $? -ne 0 ]; then
+if ! ( cd "$initdir"; find . |cpio -R 0:0 -H newc -o --quiet | \
+    $compress > "$outfile"; ); then 
     derror "dracut: creation of $outfile failed"
     exit 1
 fi 
-- 
1.7.2.1
