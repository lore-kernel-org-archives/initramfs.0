From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 20/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:10 -0800 (PST)
Message-ID: <4d6b746791451f436122517484f0cd4bdf1f27d3.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=3Fvbw97ox9BiX+jPHMxN3jd1M4BIZRSexJyNFbjHFrI=;
        b=MSwCcrsVTW85ERSNWQQuP9AuC8Xg2+vQ9+fDor6kd3cUqZ+Y2/URj9WXwA7kzeQ79v
         JAN7oND+Aha66NfQv78fdxG8nueB/gabv3KqJo9AHpPIfVnNsIwcwR86NSL+lxB1pUMv
         cXb2cuKtVZ6xzRDbCrvEpHt4E3g1XWZPigxxo=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

set_verbose is not used anywhere.  Buh-bye.

---
 dracut-functions |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 7f9dfcd..26254a4 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -24,10 +24,6 @@
 #
 #
 
-set_verbose() {
-    foo=""
-}
-
 IF_RTLD=""
 IF_dynamic=""
 get_dso_deps() {
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
