From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:08 -0800 (PST)
Message-ID: <51febd8641f677632d42615f741be11c949f400b.1234137267.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=sDszD18x9z/ezv3vZJQ6aJRoqEGRKdmNukHCCdzSxfY=;
        b=Q+FLUr18ymuI6D5WuQxgEtCisPoe4VO+LP8cjz1rYFgLhuq8rUiiZc40m5AoZFj/iG
         YhI1lyjE6elTCK9x16azBcaX9MiT9e/SfGzGCIAkyr8EH68RrwN07sC7BrgQWhqbpAE1
         uKx8a8FLPd3PYKuzJR7paXKj+wBPR/WHwOJGg=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Get rid of `` subprocess expansion when killing udevd.

$() subprocess expansion is so much easier to read.
---
 init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init b/init
index 2b7aa36..599f8ad 100755
--- a/init
+++ b/init
@@ -101,7 +101,7 @@ if [ -x $NEWROOT/usr/sbin/load_policy ]; then
 fi
 
 # kill off udev
-kill `pidof udevd`
+kill $(pidof udevd)
 
 [ -x /bin/plymouth ] && plymouth --newroot=$NEWROOT
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
