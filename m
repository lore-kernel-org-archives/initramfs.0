From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 25/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:34 -0800 (PST)
Message-ID: <b4c820f3332b580e282ba8beba825813ecf39433.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=5aC+RWEKWZo3ndHjVWvjLP7UgpfxQP6faQ58S6u1R4w=;
        b=Pgr3h+KdOINMAdZfJA6n23rVYYu+jFMcHTMsa+rAKRQwni7VJVinkfezregIhihVLg
         9VRITWLdeQcozd1EdzaWhw1VPDgBY0ky+TAddUHYLHTRlKSu0BarHJNoE04G6Kk9xHWf
         5Q6CJAp/lUxrZTbuVLKolqqB42Rj3H2lEganI=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add dmesg to the list of debugging tools

---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 8bebbd6..c444c92 100755
--- a/dracut
+++ b/dracut
@@ -44,7 +44,7 @@ exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin
 lvmexe="/sbin/lvm"
 cryptexe="/sbin/cryptsetup"
 # and some things that are nice for debugging
-debugexe="/bin/ls /bin/cat /bin/ln /bin/ps /bin/grep /bin/more"
+debugexe="/bin/ls /bin/cat /bin/ln /bin/ps /bin/grep /bin/more /bin/dmesg"
 # udev things we care about
 udevexe="/lib/udev/vol_id /lib/udev/console_init"
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
