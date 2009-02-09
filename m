From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 29/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:52 -0800 (PST)
Message-ID: <0d1c74b7212e7a760c270e06a8e77f885aa2d35f.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=6nB3fA7Lo5mWUem+4qW+sjf8Pf8QXJf8Rq8gphDLl0s=;
        b=g2GE98iyl6OuVB/SueAZvgHRyUk9jjMT30EUZxowT7YdoqSFMiVgxUvJYXulYwKJo5
         bi1vxIGWe0TquM///ixlTTVcZvQMSue750mEJJwyDVm2wKDxSNLg12uumkFMdHSCtXDP
         oouyy6kbfrZApPUTBlpl8iiwQBn3d1D7kAQxk=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add echoer script

This should be squashed into the previous patch, but I am feeling lazy.

---
 Makefile |    1 +
 dracut   |    2 ++
 echoer   |    4 ++++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b3704e7..a4d1348 100644
--- a/Makefile
+++ b/Makefile
@@ -8,6 +8,7 @@ install:
 	install -m 0755 init $(DESTDIR)/usr/libexec/dracut/init
 	install -m 0755 switch_root $(DESTDIR)/usr/libexec/dracut/switch_root
 	install -m 0755 dracut-functions $(DESTDIR)/usr/libexec/dracut/functions
+	install -m 0755 echoer $(DESTDIR)/usr/libexec/dracut/echoer
 	mkdir $(DESTDIR)/usr/libexec/dracut/rules.d
 	for rule in rules.d/*.rules ; do install -m 0644 $$rule $(DESTDIR)/usr/libexec/dracut/rules.d ; done
 
diff --git a/dracut b/dracut
index 630b78b..cade0e9 100755
--- a/dracut
+++ b/dracut
@@ -36,6 +36,7 @@ fi
 initfile=$dsrc/init
 switchroot=$dsrc/switch_root
 rulesdir=$dsrc/rules.d
+echoer=$dsrc/echoer
 
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
@@ -108,6 +109,7 @@ fi
 # install our files
 cp $initfile "$initdir/init"
 cp $switchroot "$initdir/sbin/switch_root"
+cp $echoer "$initdir/echoer"
 
 # and create some directory structure
 for d in etc proc sys sysroot dev/pts; do mkdir -p "$initdir/$d"; done
diff --git a/echoer b/echoer
new file mode 100755
index 0000000..249155d
--- /dev/null
+++ b/echoer
@@ -0,0 +1,4 @@
+#!/bin/bash
+target=$1
+shift
+echo "$@" >"$target"
\ No newline at end of file
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
