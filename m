From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/5] tiny fixup to getarg to make handling more arguments slightly easier
Date: Sat, 21 Feb 2009 08:24:20 -0800 (PST)
Message-ID: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=qj6fPvoge16W0DpSx4OVmTczYB7ZWTV0jx8ZwIPKbV8=;
        b=fpj7pYeDemWOKR6qs+v+vHxoffh5OTe+YrSSKJIxwxXeekB2YSUkL9A0BGlpzW2oUt
         +OfLKwmCTPir4zgM+L2WA/pojV3Rq/SDzSWHf7x6Nqgt7qOq+8QiybPejMe+XLhjImKs
         /43IEQFryEEYPcgeP+CaBwaQ/BMNOORPeU7qI=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch series adds support for some common mount arguments that have to be
handled in the initramfs.

It is also available at
http://git.fnordovax.org/dracut/log/?h=handle-more-parameters

---
 init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init b/init
index 358ef02..ee1123c 100755
--- a/init
+++ b/init
@@ -16,7 +16,7 @@ emergency_shell()
 getarg() {
     local o line
     for o in $CMDLINE; do
-	[ "${o%%=*}" = "$1" ] && { echo $o; break; }
+	[ "${o%%=*}" = "$1" ] && { echo $o; return 0; }
     done
     return 1
 }
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
