From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/16] Bashify the code that actually sources out config files.
Date: Sat, 14 Aug 2010 14:23:24 -0500 (CDT)
Message-ID: <05e1b369ee69723ea460def899e9f3ae6dcfa8a1.1281812505.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=p49+Yqi2W/e4qg4jpsE6RKjyNX7tymvxfhn7PHsbUws=;
        b=Fv2dZU5Mso3Zgz4PoVnH06Myz0env5Qws9UrYobi5upPfEXGD/QzyFVGpZBKRQJbnI
         2paf3CUEw3Q9ZfmQvZO2+vuYRMeWz2M6WXSHagsgaV9NAva6mB88BeLdDxzkuyqNdrnG
         /+GUL4XbmbnGKsXJ6g5j1fTPGDVNaadEg1g6Q=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Just some trivial bashification.

---
 dracut |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index a653981..33d802a 100755
--- a/dracut
+++ b/dracut
@@ -144,9 +144,9 @@ fi
 [[ -f $conffile ]] && . "$conffile"
 
 # source our config dir
-if [ "$confdir" ] && [  -d "$confdir" ]; then
+if [[ $confdir && -d $confdir ]]; then
     for f in "$confdir"/*.conf; do 
-	[ -e "$f" ] && . "$f"
+	[[ -e $f ]] && . "$f"
     done
 fi
 
-- 
1.7.2.1
