From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:16 -0800 (PST)
Message-ID: <dd4d7d8d633cdf7b0fc8ef51316874cfa2276bc4.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=dXRHLbkJKRLfETId3SX6AlVQflfEjO24q5iL1jpS/Eg=;
        b=BNvjX4qIiPebJ8HnVbtDgzeUforcon7kI0zXEBQb5LBooHVKwdzaO6vY1MIUawUlLq
         XRY341eVSWTxlaexaO9Hzf0ikhyfEzE7dxZI4jUwMEqYlthz5hjh9Stu8ZVrWah68hLg
         tQ+9n/xMWSpbKpZRAp2CVCByx0aJvNRKFCGEo=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Compact option processing.

Most of the options are one-liners, and the shift can be factored out of
the case expression entirely.
---
 dracut |   31 +++++++++----------------------
 1 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/dracut b/dracut
index 0fe0282..82cf9e5 100755
--- a/dracut
+++ b/dracut
@@ -10,30 +10,17 @@
 
 [ -f /etc/dracut.conf ] && . /etc/dracut.conf
 
-while [ $# -gt 0 ]; do
+while (($# > 0)); do
     case $1 in
-	-f|--force)
-	    force=yes
-	    shift
-	    ;;
-	-h|--help)
-	    echo "Usage: $0 [-f] <initramfs> <kernel-version>"
-	    exit 1
-	    ;;
-	-v|--verbose)
-	    set -x
-	    shift
-	    ;;
-	-l|--local)
-	    allowlocal="yes"
-	    shift
-	    ;;
-	--allow-missing)
-	    shift
-	    ;;
-	*)
-	    break
+	-f|--force) force=yes;;
+	-h|--help) echo "Usage: $0 [-f] <initramfs> <kernel-version>"
+	    exit 1 ;;
+	-v|--verbose) set -x;;
+	-l|--local) allowlocal="yes" ;;
+	--allow-missing) : ;;
+	*) break ;;
     esac
+    shift
 done
 
 if [ -n "$2" ]; then
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
