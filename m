From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 11/11] removed kernel variable from test/test-initramfs
Date: Fri, 15 May 2009 14:40:24 +0200
Message-ID: <4A0D62B8.3070401@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080703010404000100070609"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------080703010404000100070609
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

---
  test/test-initramfs |    3 +--
  1 files changed, 1 insertions(+), 2 deletions(-)



--------------080703010404000100070609
Content-Type: text/x-patch;
 name="c354b54e555a76fa78404b57740372694e18d37e.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="c354b54e555a76fa78404b57740372694e18d37e.diff"

diff --git a/test/test-initramfs b/test/test-initramfs
index a050deb..dc0e837 100755
--- a/test/test-initramfs
+++ b/test/test-initramfs
@@ -1,5 +1,4 @@
 #!/bin/bash
-kernel=$(uname -r)
 [[ -f test/root.ext2 ]] || test/make-test-root
 
 ./dracut $DRACUTOPTS -c test/dracut.conf.test -l -f test/initramfs.testing || exit
@@ -7,7 +6,7 @@ kernel=$(uname -r)
 qemu-kvm -hda test/root.ext2 -m 512M -nographic  \
 	-net nic,macaddr=52:54:00:12:34:56  \
 	-net user  \
-	-kernel /boot/vmlinuz-$kernel \
+	-kernel /boot/vmlinuz-$(uname -r) \
 	-initrd test/initramfs.testing \
 	-append "root=/dev/sda rw console=ttyS0,115200n81 $APPEND"   
 


--------------080703010404000100070609--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
