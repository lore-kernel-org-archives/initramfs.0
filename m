From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [1/3] test suite: allow a user-selected kernel
Date: Fri, 05 Jun 2009 00:33:43 -0400
Message-ID: <1244176423.29842.3.camel@obelisk.thedillows.org>
References: <1244176354.29842.1.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244176354.29842.1.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Sometimes it is desirable to allow the user to test with a different
kernel than the one they are currently running.

diff --git a/test/TEST-10-RAID/test.sh b/test/TEST-10-RAID/test.sh
index 8bbb6e5..a6e81ab 100755
--- a/test/TEST-10-RAID/test.sh
+++ b/test/TEST-10-RAID/test.sh
@@ -1,9 +1,11 @@
 #!/bin/bash
 TEST_DESCRIPTION="root filesystem on an encrypted LVM PV"
 
+KVERSION=${KVERSION-$(uname -r)}
+
 test_run() {
     $testdir/run-qemu -hda root.ext2 -m 512M -nographic \
-	-net none -kernel /boot/vmlinuz-$(uname -r) \
+	-net none -kernel /boot/vmlinuz-$KVERSION \
 	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81" \
 	-initrd initramfs.testing
     grep -m 1 -q dracut-root-block-success root.ext2 || return 1
@@ -13,7 +15,7 @@ test_setup() {
     # Create the blank file to use as a root filesystem
     dd if=/dev/zero of=root.ext2 bs=1M count=20
 
-    kernel=$(uname -r)
+    kernel=$KVERSION
     # Create what will eventually be our root filesystem onto an overlay
     (
 	initdir=overlay/source
@@ -42,7 +44,7 @@ test_setup() {
     $basedir/dracut -l -i overlay / \
 	-m "dash crypt lvm mdraid udev-rules base rootfs-block" \
 	-d "ata_piix ext2 sd_mod" \
-	-f initramfs.makeroot || return 1
+	-f initramfs.makeroot $KVERSION || return 1
     rm -rf overlay
     # Invoke KVM and/or QEMU to actually create the target filesystem.
     $testdir/run-qemu -hda root.ext2 -m 512M -nographic -net none \
@@ -60,7 +62,7 @@ test_setup() {
     sudo $basedir/dracut -l -i overlay / \
 	-m "dash crypt lvm mdraid udev-rules base rootfs-block" \
 	-d "ata_piix ext2 sd_mod" \
-	-f initramfs.testing || return 1
+	-f initramfs.testing $KVERSION || return 1
 }
 
 test_cleanup() {


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
