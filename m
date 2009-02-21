From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] We now support the noresume kernel parameter.
Date: Sat, 21 Feb 2009 08:24:25 -0800 (PST)
Message-ID: <a2c9a882aadd2b2671c7264a6962a521f1c0704d.1235233199.git.victor.lowther@gmail.com>
References: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=GIXsX7MN6A5lD6MGlsRgTdlPuz7XKaNUasqAA1WVu8g=;
        b=Ks16T3AstYxjwpcAQctlliiyA4e/sfp3OX/TLQA643pQVBLDBGCeyUntC6FmygOhLb
         QBVeXNAY98Y7V97TwIUxtOg9euYqmQUg/rQs5bek3ThLm7vkr+PS09rS/piEvFpiFv5z
         985yjwl/6m43ruRCVPetxnMpEz61V1tHoV/UA=
In-Reply-To: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 hooks/resume.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/hooks/resume.sh b/hooks/resume.sh
index 4f1d6c3..619d634 100755
--- a/hooks/resume.sh
+++ b/hooks/resume.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-resume=$(getarg resume) && {
+resume=$(getarg resume) && [ "$(getarg noresume)" = "" ] && {
     resume=${resume#resume=}
     [ -b "$resume" ] && {
         # parsing the output of ls is Bad, but until there is a better way...
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
