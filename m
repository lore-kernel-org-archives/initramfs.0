From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 29/50] Add echoer script
Date: Mon, 16 Feb 2009 14:06:43 -0500
Message-ID: <200902161906.n1GJ6hFY028299@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=933a523af36fec75f5b7dd5a6bf97c699e16e2bb
Commit:     933a523af36fec75f5b7dd5a6bf97c699e16e2bb
Parent:     8cc53c16a0f7860a6b87c99c1504288225fb904b
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:40 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 29/50] Add echoer script
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
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
