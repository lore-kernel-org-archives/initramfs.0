From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] Make generation of testroot images succeed
Date: Thu, 21 May 2009 15:44:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905211541160.7805@gate.bb.dicp.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The patchset from Victor improves the make test functionality quite a bit.

Currently though generating the root images fails as the 99mount-root.sh 
is triggered concurrently due to the /init checking for the existance of a 
/proc directory in the freshly mounted rootfs.

This patch uses the tool e2mkdir from the e2tools package to create this 
/proc dir after mke2fs ran.


diff -up dracut/modules.d/00test/create-root.sh.orig dracut/modules.d/00test/create-root.sh
--- dracut/modules.d/00test/create-root.sh.orig	2009-05-21 15:38:14.354760584 +0200
+++ dracut/modules.d/00test/create-root.sh	2009-05-21 15:38:37.059757528 +0200
@@ -16,4 +16,3 @@ lvm lvcreate -l 100%FREE -n root dracut
 udevadm settle --timeout=4
 [ -b /dev/dracut/root ] || emergency_shell
 mke2fs /dev/dracut/root
-e2mkdir /dev/dracut/root:/proc
diff -up dracut/modules.d/00test/install.orig dracut/modules.d/00test/install
--- dracut/modules.d/00test/install.orig	2009-05-21 15:38:22.915510612 +0200
+++ dracut/modules.d/00test/install	2009-05-21 15:38:45.495507075 +0200
@@ -1,5 +1,5 @@
 #!/bin/sh
-dracut_install sfdisk mke2fs poweroff cp umount e2mkdir
+dracut_install sfdisk mke2fs poweroff cp umount
 inst_hook pre-pivot 02 "$moddir/halt.sh"
 inst_hook pre-pivot 01 "$moddir/copy-root.sh"
 inst_hook pre-mount 01 "$moddir/create-root.sh"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
