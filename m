From: Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] dracut: don't print misleading dinfo after successful ldconfig run
Date: Tue,  7 Dec 2010 02:44:20 +0100
Message-ID: <1291686260-32371-2-git-send-email-christian.ch.heinz@gmail.com>
References: <1291686260-32371-1-git-send-email-christian.ch.heinz@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=gydp4Ne/Fw9J1zjOQjSrBnz6CbR/0LTBnHLRt5v0x9Q=;
        b=W79OdnJYTkanI6u5uXnj97D9zJur8GfbioFLc9uaZizLOI79VQXaFH1M8yxdkLX4LR
         6lEb3eNubo7g+Z8c8RZ2H5utR6tqqKp/hU7RymFTxYNbABdjoZvTx55+9fZLPTm93kEa
         KctnaeWKELA9tKc3/5He/Z3ATYmeyRoYOjX14=
In-Reply-To: <1291686260-32371-1-git-send-email-christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 dracut |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index 5cdd313..93ea308 100755
--- a/dracut
+++ b/dracut
@@ -351,8 +351,8 @@ unset item
 # make sure that library links are correct and up to date
 cp -ar /etc/ld.so.conf* "$initdir"/etc
 mkdir -p "$initdir/var/cache/ldconfig"
-ldconfig -r "$initdir" || [[ $UID != "0" ]] && \
-    dinfo "ldconfig might need uid=0 (root) for chroot()"
+ldconfig -r "$initdir" || { [[ $UID != "0" ]] && \
+    dinfo "ldconfig might need uid=0 (root) for chroot()"; }
 
 [[ $beverbose = yes ]] && (du -c "$initdir" | sort -n)
 
-- 
1.7.3.3
