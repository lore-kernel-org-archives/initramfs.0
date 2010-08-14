From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 15/16] We are precise about hostonly checking these days.
Date: Sat, 14 Aug 2010 14:23:26 -0500 (CDT)
Message-ID: <caabafd4cc01522c1350615915880b9109a3d308.1281812506.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=vJC9tEjRH1xwhWg1r/EPElpuPLxM2ZdZbLWUK14hr5o=;
        b=T7KgrmMvHO46moM1sIN91jVJ2Y4ZzN7TTwYTXrwmjh4Sh+j9r8Xyr7S3+dw4X601CB
         9bDJiysYljrIYg87jVENAYIgWLcA7HSjyGsRkmxvIyibKJFSDgr5IBW+rtr8jFLG6r4y
         G3/WY7AvfR1l6TJx+GoD4MuknFZx23RpsM2xs=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

So get rid of the comment in 90crypt/check.
Also do a bit of trivial bashification.

---
 modules.d/90crypt/check |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/modules.d/90crypt/check b/modules.d/90crypt/check
index a34a05e..22a017e 100755
--- a/modules.d/90crypt/check
+++ b/modules.d/90crypt/check
@@ -2,12 +2,7 @@
 
 # if cryptsetup is not installed, then we cannot support encrypted devices.
 which cryptsetup >/dev/null 2>&1 || exit 1
-
-[ "$1" = "-d" ] && echo dm
-
-# hostonly checking should only return true if root is on a LUKS device
-# in some way, but I am too lazy to figure out how to do that.
-# Instead, fail if we do not have a LUKS device in use somewhere.
+[[ $1 = -d ]] && echo dm
 
 . $dracutfunctions
 
-- 
1.7.2.1
