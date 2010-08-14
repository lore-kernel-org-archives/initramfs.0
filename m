From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/16] We have $UID, use it instead of $(id -u)
Date: Sat, 14 Aug 2010 14:23:25 -0500 (CDT)
Message-ID: <5037c1e35489d01b1924fc38013b08d8e3bf696a.1281812505.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=ZeCU/LMjhgPSyDRioIiR8KQiviy0dev+ixOWhGN7/Ls=;
        b=S8guuUMVV3H8JYfa9aUyqR145Bn8bxOKsKmondhGqYOv+zWqil5XI95esw8wm+OnVe
         YNX1jD8mM7tixoHXM5x9EH3CiXxPIXdyRfFVfpuU7e/afdkn9jFIAUqkAST+suPHQeMW
         AFFEzzOh/PsaeawVINSiEp/8Aw9AsmV9liJVo=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

No point in spawning a command and parsing its output when the UID
is already in the environment.

---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index bfef92c..a2bc312 100755
--- a/dracut
+++ b/dracut
@@ -288,7 +288,7 @@ unset item
 
 # make sure that library links are correct and up to date
 cp -ar /etc/ld.so.conf* "$initdir"/etc
-ldconfig -r "$initdir" || [[ $(id -u) != "0" ]] && dinfo "ldconfig might need uid=0 (root) for chroot()"
+ldconfig -r "$initdir" || [[ $UID != "0" ]] && dinfo "ldconfig might need uid=0 (root) for chroot()"
 
 [[ $beverbose = yes ]] && (du -c "$initdir" | sort -n)
 
-- 
1.7.2.1
