From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 27/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:44 -0800 (PST)
Message-ID: <b7b3347b6be7660f0a067936c137aa3c33307d20.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=adsRAAdEERwAx7cI1dSSFvjkAn0N/UAdDBTosTKi71Q=;
        b=ndN9zcSCXX9tEkXZ/5k4+PkVLLMf6wiRHwDaAlScAh3RR6byuZ/ixk+Lfm9f6uSEzW
         JceS+xYHZS8BK27kBIbMqy2M7B63yoKDpPzK4xyXjQTAzQeX0BDc53FQDkOI9bSL/4Aa
         L7yWpR0XbOjEyLBKb/5aoq15v4juwnEN6Y+Ao=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Don't leave cruft behind in /tmp

---
 dracut |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dracut b/dracut
index eb6632d..56695c1 100755
--- a/dracut
+++ b/dracut
@@ -38,6 +38,7 @@ switchroot=$dsrc/switch_root
 rulesdir=$dsrc/rules.d
 
 initdir=$(mktemp -d -t initramfs.XXXXXX)
+trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 
 # executables that we have to have
 exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
