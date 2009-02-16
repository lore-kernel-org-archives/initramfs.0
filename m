From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 39/50] Prefer /bin/dash as /bin/sh on the initrd if it is available.
Date: Mon, 16 Feb 2009 14:07:02 -0500
Message-ID: <200902161907.n1GJ72dB028704@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=6dc8676d8c86167e667491a95f7e71d8a60019e7
Commit:     6dc8676d8c86167e667491a95f7e71d8a60019e7
Parent:     2a3efd82e55ccd4cbd6e039d5cf70569ae4767f6
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:43:04 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 39/50] Prefer /bin/dash as /bin/sh on the initrd if it is available.
    
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
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
