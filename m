From: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] 98integrity: support validating the IMA policy file signature
Date: Thu, 13 Oct 2016 16:49:43 -0400
Message-ID: <1476391783-27231-1-git-send-email-stefanb@linux.vnet.ibm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

From: Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

IMA validates file signatures based on the security.ima xattr. As of
Linux-4.7, instead of cat'ing the IMA policy into the securityfs policy,
the IMA policy pathname can be written, allowing the IMA policy file
signature to be validated.

This patch first attempts to write the pathname, but on failure falls
back to cat'ing the IMA policy contents .

Signed-off-by: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 modules.d/98integrity/ima-policy-load.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/modules.d/98integrity/ima-policy-load.sh b/modules.d/98integrity/ima-policy-load.sh
index 0061cff..5460d02 100755
--- a/modules.d/98integrity/ima-policy-load.sh
+++ b/modules.d/98integrity/ima-policy-load.sh
@@ -30,7 +30,8 @@ load_ima_policy()
     # check the existence of the IMA policy file
     [ -f "${IMAPOLICYPATH}" ] && {
         info "Loading the provided IMA custom policy";
-        cat ${IMAPOLICYPATH} > ${IMASECDIR}/policy;
+        echo -n "${IMAPOLICYPATH}" > ${IMASECDIR}/policy || \
+            cat "${IMAPOLICYPATH}" > ${IMASECDIR}/policy
     }
 
     return 0
-- 
2.7.0
