From: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] Make generation of testroot images succeed
Date: Thu, 21 May 2009 16:53:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0905211653170.2058@gate.bb.dicp.net>
References: <Pine.LNX.4.58.0905211541160.7805@gate.bb.dicp.net>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0905211541160.7805-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


sorry, patch was reversed.

correct patch below:

diff -up dracut/modules.d/00test/create-root.sh.orig dracut/modules.d/00test/create-root.sh
--- dracut/modules.d/00test/create-root.sh.orig	2009-05-21 16:50:29.968237157 +0200
+++ dracut/modules.d/00test/create-root.sh	2009-05-21 16:51:09.202248098 +0200
@@ -16,3 +16,4 @@ lvm lvcreate -l 100%FREE -n root dracut
 udevadm settle --timeout=4
 [ -b /dev/dracut/root ] || emergency_shell
 mke2fs /dev/dracut/root
+e2mkdir /dev/dracut/root:/proc
diff -up dracut/modules.d/00test/install.orig dracut/modules.d/00test/install
--- dracut/modules.d/00test/install.orig	2009-05-21 16:50:14.362236827 +0200
+++ dracut/modules.d/00test/install	2009-05-21 16:50:20.680319006 +0200
@@ -1,5 +1,5 @@
 #!/bin/sh
-dracut_install sfdisk mke2fs poweroff cp umount
+dracut_install sfdisk mke2fs poweroff cp umount e2mkdir
 inst_hook pre-pivot 02 "$moddir/halt.sh"
 inst_hook pre-pivot 01 "$moddir/copy-root.sh"
 inst_hook pre-mount 01 "$moddir/create-root.sh"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
