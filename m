From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 25/50] Add dmesg to the list of debugging tools
Date: Mon, 16 Feb 2009 14:06:35 -0500
Message-ID: <200902161906.n1GJ6Zai028182@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=213c781797a697b89fa1a7eb1214d1a74f71c8cb
Commit:     213c781797a697b89fa1a7eb1214d1a74f71c8cb
Parent:     36b24d7c532c257ef8171c8fc39e7618784f6195
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:31 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 25/50] Add dmesg to the list of debugging tools
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
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
