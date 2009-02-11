From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 8/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 03:46:54 -0800 (PST)
Message-ID: <f4e48037d9a234736f8c7b7ac0023b05abc1c511.1234351770.git.victor.lowther@gmail.com>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=6rDEQQOOjxF3yZmi5O4wNGRTsBujJEy9R6FAlrLEWZ4=;
        b=wLhj0iu2h7bGcYRBkLurW++eJanAw1iuHTZCKNxh6e9uPov6p/mOWu5VqUNo9zfyh2
         X4zH2U7az7ScRrYHuL/JEqWhc6EW+Dd/afzazCggA+2JCu4WBvmKrfa9bcgKwHPn+m7N
         w4VmwHqcmq/DvYOS3n9lAdVvW0pJIXmExBTjo=
In-Reply-To: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Prefer /bin/dash as /bin/sh on the initrd if it is available.

This is mainly for testing purposes -- if something non-POSIX is added to the
on initrd scripts, dash will die horribly.
---
 dracut |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 530524c..186d6ad 100755
--- a/dracut
+++ b/dracut
@@ -43,7 +43,7 @@ initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 
 # executables that we have to have
-exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot /bin/echo /bin/cat"
+exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot /bin/echo /bin/cat /bin/sed"
 lvmexe="/sbin/lvm"
 cryptexe="/sbin/cryptsetup"
 # and some things that are nice for debugging
@@ -56,6 +56,12 @@ for binary in $exe $debugexe $udevexe $lvmexe $cryptexe ; do
   inst $binary
 done
 
+# Prefer dash as /bin/sh if it is available.
+if [[ -f /bin/dash ]]; then
+    inst /bin/dash
+    ln -sf /bin/dash "${initdir}/bin/sh"
+fi
+
 # FIXME: would be nice if we didn't have to know which rules to grab....
 # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
 # of the rules we want so that we just copy those in would be best
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
