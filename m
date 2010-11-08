From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Add busybox shell replacements module
Date: Mon,  8 Nov 2010 19:49:33 +0000 (GMT)
Message-ID: <20101108194933.89BE19D401B@zog.reactivated.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On the OLPC XO-1, there is a noticable delay during boot while the
initramfs is loaded from disk and uncompressed, so we have an interest
in making it small. We are also pushed for disk space.

Using busybox instead of all the regular tools saves a lot of space.
I have not tried every module but the basics are working with busybox's
replacements. Our initramfs is now down to 1.9mb.
---
 modules.d/05busybox/check   |    2 ++
 modules.d/05busybox/install |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/05busybox/check
 create mode 100755 modules.d/05busybox/install

diff --git a/modules.d/05busybox/check b/modules.d/05busybox/check
new file mode 100755
index 0000000..06bd986
--- /dev/null
+++ b/modules.d/05busybox/check
@@ -0,0 +1,2 @@
+#!/bin/bash
+exit 0
diff --git a/modules.d/05busybox/install b/modules.d/05busybox/install
new file mode 100755
index 0000000..5252d03
--- /dev/null
+++ b/modules.d/05busybox/install
@@ -0,0 +1,16 @@
+#!/bin/bash
+
+inst busybox /sbin/busybox
+
+# List of shell programs that we use in other official dracut modules, that
+# must be supported by the busybox installed on the host system
+progs="echo grep usleep [ rmmod insmod mount uname umount setfont kbd_mode stty gzip bzip2 chvt readlink blkid dd losetup tr sed seq ps more cat rm free ping netstat vi ping6 fsck ip hostname basename mknod mkdir pidof sleep chroot ls cp mv dmesg mkfifo less ln modprobe"
+
+# FIXME: switch_root should be in the above list, but busybox version hangs
+# (using busybox-1.15.1-7.fc14.i686 at the time of writing)
+
+for i in $progs; do
+	path=$(find_binary "$i")
+	ln -s /sbin/busybox "$initdir/$path"
+done
+
-- 
1.7.3.2
