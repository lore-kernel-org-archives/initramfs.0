From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:31 -0800 (PST)
Message-ID: <558ea11281c8c1575f73569ebe202910fd669309.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=sINLlkY6+Nm5MAzaT96GPGHdNTOJlP0Yy9C5rNCJYPk=;
        b=K3mARGWRDqV1iC9S8RcMKs/0K+5lHVHO9Cp7X5PiCvSUQ0bXfiLQBgbU1x1SJhU4FL
         aepJgJjJLqJG8fcFWqng+NIzt7crzmFg2T91uIl1d6sgvYoMW2arTrE+7CChBQC6geRw
         fRw2qFLSqjhhQNDAM5ci+LMDzSj3gxTWfynPM=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Get rid of some redundancy when sourcing our functions.

---
 dracut |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/dracut b/dracut
index 7ba4a09..c333173 100755
--- a/dracut
+++ b/dracut
@@ -32,17 +32,11 @@ if [[ -f $outfile && ! $force ]]; then
     exit 1
 fi
 
-if [[ $allowlocal && -f ./init ]]; then
-    . ./dracut-functions
-    initfile=./init
-    switchroot=./switch_root
-    rulesdir=./rules.d
-else
-    . /usr/libexec/dracut/functions
-    initfile=/usr/libexec/dracut/init
-    switchroot=/usr/libexec/dracut/switch_root
-    rulesdir=/usr/libexec/dracut/rules.d
-fi
+[[ $allowlocal && -f ./init ]] && dsrc="." || dsrc=/usr/libexec/dracut
+. $dsrc/dracut-functions
+initfile=$dsrc/init
+switchroot=$dsrc/switch_root
+rulesdir=$dsrc/rules.d
 
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
