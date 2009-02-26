From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] Do not run dhclient if the interface is already up.
Date: Wed, 25 Feb 2009 18:42:14 -0800 (PST)
Message-ID: <50f00b90b439c4a33db0dda1f9d29c9e4205a499.1235615754.git.victor.lowther@gmail.com>
References: <cd38313900d1086b09e2d4279e2fed2df5bf46ec.1235615754.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=DiKE0otKndsg3KLrEiN+czHR6PZTp1PUWoYSinFC/r4=;
        b=SyD6Vm85Ucf7hxQy7R/Hre4Ci9McG6mZSrA7wXUL99cfaLi8kqmhoxePtEsOcBu4LN
         QCC24d/Ln3m5q1pfE2+6Gvu3B9mWpzGQSa7YVMcW9CzYkkiR9GBf+HlOd0OilnVQqLjW
         EoV5doxJqlo/ZnjXhdE5s0gamvwjCXkSVzRK4=
In-Reply-To: <cd38313900d1086b09e2d4279e2fed2df5bf46ec.1235615754.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 hooks/run-dhclient.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/hooks/run-dhclient.sh b/hooks/run-dhclient.sh
index fcf890e..afab037 100755
--- a/hooks/run-dhclient.sh
+++ b/hooks/run-dhclient.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 for i in /net.*.dhcp; do
     dev=${i#net.}; dev=${i%.dhcp}
+    [ -f "/net.$dev.up" ] && continue
     dhclient -1 -q $dev &
 done
 wait
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
