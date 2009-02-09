From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:03 -0800 (PST)
Message-ID: <bcfa8bb66f276899d55681fa58798438d28a6405.1234137267.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=RJFkQkbzEwgDQJWjoQAvgBAht+VUr6pf5+mGVtnLA4w=;
        b=EgFfd2Emm69MgX08i3BTnr9gJ6XGeilaEpZNnzr4CUlxQdxBUkRkKw3F41qFcYYacK
         iEB+BiSBdsE+1ghFCydd/Sdu99IVYDT3TFCmRMaD/no0DmndKjlNnLWCEKxBPZ/3i4Kk
         xOhWeU7R5uFfjS2MzPCPCyvvyd4+cesFHfxhc=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Bashify results testing for selinux policy loading

---
 init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init b/init
index 2ebf1b0..2b7aa36 100755
--- a/init
+++ b/init
@@ -92,7 +92,7 @@ mount -t sysfs /sys $NEWROOT/sys
 # FIXME: load selinux policy.  this should really be done after we switchroot 
 if [ -x $NEWROOT/usr/sbin/load_policy ]; then
   chroot $NEWROOT /usr/sbin/load_policy -i
-  if [ $? -eq 3 ]; then
+  if (($? == 3)); then
     echo "Initial SELinux policy load failed and enforcing mode requested."
     echo "Not continuing"
     sleep 100d
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
