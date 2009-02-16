From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 08/50] Don't load commands into the initrd that are built in to bash.
Date: Mon, 16 Feb 2009 14:06:02 -0500
Message-ID: <200902161906.n1GJ62pQ027442@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=70c26b7fce5f1cddbd82863c371caaf20b299706
Commit:     70c26b7fce5f1cddbd82863c371caaf20b299706
Parent:     8b691309de20bb20c064cf8c9bd3502a9eddc76a
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:50 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 08/50] Don't load commands into the initrd that are built in to bash.
    
    No sense in loading commands that will never be used.
---
 dracut |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index ef2ca42..0fe0282 100755
--- a/dracut
+++ b/dracut
@@ -4,6 +4,7 @@
 # Tries to retain some degree of compatibility with the command line
 # of the various mkinitrd implementations out there
 #
+
 # Copyright 2008, Red Hat, Inc.  Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 # GPLv2 header here
 
@@ -66,7 +67,7 @@ fi
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 
 # executables that we have to have
-exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /bin/kill /sbin/pidof /bin/sleep /bin/echo /usr/sbin/chroot"
+exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot"
 lvmexe="/sbin/lvm"
 cryptexe="/sbin/cryptsetup"
 # and some things that are nice for debugging
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
