From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 09/11] add APPEND and DRACUTOPTS to make target "test"
Date: Fri, 15 May 2009 14:40:07 +0200
Message-ID: <4A0D62A7.9030609@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090108010607030206050803"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------090108010607030206050803
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


call test with additional dracut options and kernel command line
parameter:

$ make APPEND="udevinfo quiet" DRACUTOPTS="-verbose" test
---
  Makefile              |    2 +-
  test/dracut.conf.test |    3 ++-
  test/test-initramfs   |    8 ++------
  3 files changed, 5 insertions(+), 8 deletions(-)



--------------090108010607030206050803
Content-Type: text/x-patch;
 name="e2367e1948cf86c8f1b685ef1876b1df6f96c695.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="e2367e1948cf86c8f1b685ef1876b1df6f96c695.diff"

diff --git a/Makefile b/Makefile
index 7053cd9..a4dfd92 100644
--- a/Makefile
+++ b/Makefile
@@ -33,7 +33,7 @@ rpm: dracut-$(VERSION)-$(GITVERSION).tar.bz2
 	rm -fr BUILD BUILDROOT
 
 test: test/root.ext2 all
-	sudo test/test-initramfs
+	sudo APPEND="$(APPEND)" DRACUTOPTS="$(DRACUTOPTS)" test/test-initramfs
 
 test/root.ext2: test/test-init test/make-test-root
 	sudo test/make-test-root
diff --git a/test/dracut.conf.test b/test/dracut.conf.test
index 764cef2..6bdd6b8 100644
--- a/test/dracut.conf.test
+++ b/test/dracut.conf.test
@@ -1,2 +1,3 @@
-dracutmodules="base dash crypt lvm kernel-modules resume rootfs-block 95rootfs-block-udev network udev-rules"
+#dracutmodules="base dash crypt lvm kernel-modules resume rootfs-block 95rootfs-block-udev network udev-rules"
+dracutmodules="base dash crypt lvm kernel-modules debug resume rootfs-block-udev udev-rules"
 #modules="ata_piix ext2 sd_mod"
diff --git a/test/test-initramfs b/test/test-initramfs
index f1fed7c..a050deb 100755
--- a/test/test-initramfs
+++ b/test/test-initramfs
@@ -1,17 +1,13 @@
 #!/bin/bash
 kernel=$(uname -r)
 [[ -f test/root.ext2 ]] || test/make-test-root
-./dracut -c test/dracut.conf.test -l -f test/initramfs.testing || exit
 
-#qemu-kvm -hda test/root.ext2 -m 512M -nographic -net none \
-#    -kernel /boot/vmlinuz-$kernel \
-#    -append "root=/dev/sda init=/init rw rootfstype=ext2 quiet ramfsdebug console=ttyS0,115200n81" \
-#    -initrd test/initramfs.testing
+./dracut $DRACUTOPTS -c test/dracut.conf.test -l -f test/initramfs.testing || exit
 
 qemu-kvm -hda test/root.ext2 -m 512M -nographic  \
 	-net nic,macaddr=52:54:00:12:34:56  \
 	-net user  \
 	-kernel /boot/vmlinuz-$kernel \
 	-initrd test/initramfs.testing \
-	-append "root=/dev/sda init=/init rw rootfstype=ext2 console=ttyS0,115200n81"   
+	-append "root=/dev/sda rw console=ttyS0,115200n81 $APPEND"   
 


--------------090108010607030206050803--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
