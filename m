From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 14/16] Trivial bashification of 00dash/install
Date: Sat, 14 Aug 2010 14:23:26 -0500 (CDT)
Message-ID: <be88e4941e56f0b18c8be806c131eafd1c25b2d1.1281812506.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=ZXSgo8p7MhrYih6SBFekV0MnODI6XC0H8QMDEDCTPcg=;
        b=XrdZsciF0VwSQ92jno77w91y84L2AvyVRSNJ/EcMH29mtbQyR38sibBO0c5yR0lRJi
         8/uOQHjWix4FijCzP6/4l0RsM9P9IWyuLja36vBIzoIn31cwpqYItwhbcFuWpWGlHd9M
         G00+WqnbEuMineiBr6h+0UdyAgrhpm/PkL7rE=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/00dash/install |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/00dash/install b/modules.d/00dash/install
index 0b344ca..a197573 100755
--- a/modules.d/00dash/install
+++ b/modules.d/00dash/install
@@ -1,6 +1,6 @@
 #!/bin/bash
 # If another shell is already installed, do not use dash
-[ -x "${initdir}/bin/sh" ] && return
+[[ -x $initdir/bin/sh ]] && return
 
 # Prefer dash as /bin/sh if it is available.
 inst /bin/dash && ln -sf dash "${initdir}/bin/sh"
-- 
1.7.2.1
