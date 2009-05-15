From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 10/11] cleanup make-test-root
Date: Fri, 15 May 2009 14:40:15 +0200
Message-ID: <4A0D62AF.6020804@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010602070003010500060001"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------010602070003010500060001
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

---
  test/make-test-root |   10 ----------
  1 files changed, 0 insertions(+), 10 deletions(-)



--------------010602070003010500060001
Content-Type: text/x-patch;
 name="9e551c90976caf75483065f8f4ba93d5b4258ec9.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="9e551c90976caf75483065f8f4ba93d5b4258ec9.diff"

diff --git a/test/make-test-root b/test/make-test-root
index 8c54f8d..7da36c5 100755
--- a/test/make-test-root
+++ b/test/make-test-root
@@ -19,13 +19,3 @@ unset initdir
 
 umount test/mnt
 rm -fr test/mnt
-
-#./dracut -l -i "$targetfs" /source \
-#    -m "dash kernel-modules test crypt lvm udev-rules base rootfs-block" \
-#    -d "ata_piix ext2 sd_mod" \
-#    -f test/initramfs.makeroot
-#
-#qemu-kvm -hda test/root.ext2 -m 512M -nographic -net none \
-#    -kernel "/boot/vmlinuz-$kernel" \
-#    -append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81" \
-#    -initrd test/initramfs.makeroot


--------------010602070003010500060001--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
