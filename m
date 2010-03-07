From: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Subject: [PATCH] silence xen-detect detection
Date: Sun, 7 Mar 2010 13:52:08 +0100
Message-ID: <20100307125208.GA26671@maude.comedia.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=comedia.it; h=
	user-agent:content-disposition:content-type:mime-version
	:message-id:subject:from:date:received:x-virus-scanned; s=200808
	; t=1267966328; bh=JNMNFrjkv8xErSjo0IJclD8QI2NkznYOKC7NSfVWMK4=;
	 b=ihtgu+6+MatB73aF7ncBvexynC+PkKqbbRlqtWCLaMnES7Dy/04++3ZSAIIpv
	uahPHGiPyaiFjJ+bsLXpItd0NybTrou5hhCaQvg7lJ77dJWjzaWYr78qh53IQ6t+
	fq+eNkyuotTdIoRZHNM4sfbxOWdUNs9c2JFpnlU1zMxCG8=
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Signed-off-by: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
---
  modules.d/60xen/check |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/60xen/check b/modules.d/60xen/check
index 420cdc2..f155582 100755
--- a/modules.d/60xen/check
+++ b/modules.d/60xen/check
@@ -1,7 +1,7 @@
  #!/bin/bash
  
  # No Xen-detect? Boo!!
-XENDETECT=$(which xen-detect)
+XENDETECT=$(which xen-detect 2>/dev/null)
  [ -z "$XENDETECT" ] && [ -d "/usr/lib/xen-default" ] && XENDETECT="/usr/lib/xen-default/bin/xen-detect"
  [ -z "$XENDETECT" ] && exit 1
  
-- 
Luca Berra -- bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org
         Communication Media & Services S.r.l.
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X        AGAINST HTML MAIL
  / \
