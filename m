From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 36/50] Move cat into the list of required executables
Date: Mon, 16 Feb 2009 14:06:57 -0500
Message-ID: <200902161906.n1GJ6vvq028501@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=75ec5873afdbf6a304fa2eddb9a789068e0476b6
Commit:     75ec5873afdbf6a304fa2eddb9a789068e0476b6
Parent:     7f64a3fee12dee23df22a154d617bc4e1baa33b2
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:57 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 36/50] Move cat into the list of required executables
---
 dracut |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index c5f68c7..530524c 100755
--- a/dracut
+++ b/dracut
@@ -43,11 +43,11 @@ initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 
 # executables that we have to have
-exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot /bin/echo"
+exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot /bin/echo /bin/cat"
 lvmexe="/sbin/lvm"
 cryptexe="/sbin/cryptsetup"
 # and some things that are nice for debugging
-debugexe="/bin/ls /bin/cat /bin/ln /bin/ps /bin/grep /bin/more /bin/dmesg"
+debugexe="/bin/ls /bin/ln /bin/ps /bin/grep /bin/more /bin/dmesg"
 # udev things we care about
 udevexe="/lib/udev/vol_id /lib/udev/console_init"
 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
