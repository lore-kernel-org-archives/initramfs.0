From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 27/50] Don't leave cruft behind in /tmp
Date: Mon, 16 Feb 2009 14:06:39 -0500
Message-ID: <200902161906.n1GJ6d41028239@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=2c6fc388b0fc46e070b7f738bc906c42883034f5
Commit:     2c6fc388b0fc46e070b7f738bc906c42883034f5
Parent:     bc6b0dec9e077468d45ae3248eb196c92a9e7b31
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:36 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 27/50] Don't leave cruft behind in /tmp
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
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
