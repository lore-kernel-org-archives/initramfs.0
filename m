From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/16] Shorten permission checking to ensure we can actually write our initramfs.
Date: Sat, 14 Aug 2010 14:23:24 -0500 (CDT)
Message-ID: <f25afda727e1ff3ddebccc987268b5fdc2d1332b.1281812505.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=QJ6bc6jzpgCYNmBLr1MCAjO+hXNSbRCX7G941v/fKSg=;
        b=rWz+4+MazZ7oxj22UMBL6DQaytbqdRh6veXAD/u+hREs+GCldfUrzCDfsjYtCtrvbH
         P7UTw0GNLnm4i78aOOHpuBB+UN3yeyKEiQh6shZhf8frXvZGd9IYY9UKoTLRB1P6HhWt
         7kstGhL8mdAIYH1pWMdTn113z/ol7WudxZOQs=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

These tests can be combined into an if... elif... elif... statement, and
that makes it clear they are all part of the same test.

---
 dracut |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/dracut b/dracut
index 33d802a..184b0c1 100755
--- a/dracut
+++ b/dracut
@@ -210,18 +210,14 @@ if [[ -f $outfile && ! $force ]]; then
     exit 1
 fi
 
-outdir=$(dirname "$outfile")
-if ! [[ -d "$outdir" ]]; then
+outdir=${outfile%/*}
+if [[ ! -d "$outdir" ]]; then
     echo "Can't write $outfile: Directory $outdir does not exist."
     exit 1
-fi
-
-if ! [[ -w "$outdir" ]]; then
+elif [[ ! -w "$outdir" ]]; then
     echo "No permission to write $outdir."
     exit 1
-fi
-
-if [[ -f "$outfile" ]] &&  ! [[ -w "$outfile" ]]; then
+elif [[ ! -w "$outfile" ]]; then
     echo "No permission to write $outfile."
     exit 1
 fi
-- 
1.7.2.1
