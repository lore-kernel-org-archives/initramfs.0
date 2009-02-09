From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:34:54 -0800 (PST)
Message-ID: <2e0f11d70bcf9f3a713b9d811045d0461404042d.1234137267.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=2Z8kjqwHVmtRnt9UER1zyYGBCZZndbUHcytEJTxWiP0=;
        b=uuFMGVFtmFdP4kGW5LowKkTnoLGmlFlVrfbuNUJaF0cq40GRbddfdu9bOvW6K5kexK
         03Ljr2S0kEgtlawUhdcb+BK34l4tRUnNGrMH8kfdIk2oMKVxprTbVad32h7YCcM6yGur
         DnwklwCgtiCo4jtapftwx0//xV6ki8Qmki+Zs=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Modify root cmdline parsing to use a case statement.

This code takes less space and is easier to read at a glance.
---
 init |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/init b/init
index 7b2a985..78f962e 100755
--- a/init
+++ b/init
@@ -59,19 +59,16 @@ NEWROOT="/sysroot"
 # it'd be nice if we had a udev rule that just did all of the bits for
 # figuring out what the specified root is and linking it /dev/root
 root=$(getarg 'root=*'); root=${root#root=}
-
 echo -n "Going to mount rootfs ($root)"
-if [ -z "$root" ]; then 
-  echo "Warning: no root specified"
-  root="/dev/sda1"
-elif [ "${root#LABEL=}" != $root ]; then
-  # FIXME: may need to do more escaping here
-  l=${root#LABEL=}
-  label=${l//\//\\x2f}
-  root="/dev/disk/by-label/${label}"
-elif [ "${root#UUID=}" != $root ]; then
-  root="/dev/disk/by-uuid/${root#UUID=}"
-fi
+case $root in
+    LABEL=*) root=${root#LABEL=}
+             root=${root//\//\\x2f}
+	     root="/dev/disk/by-label/${root}" ;;
+    UUID=*) root="/dev/disk/by-uuid/${root#UUID=}" ;;
+    '') echo "Warning: no root specified"
+	root="/dev/sda1" ;;
+esac
+
 # should we have a timeout?
 tries=0
 while [ ! -e $root ]; do
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
