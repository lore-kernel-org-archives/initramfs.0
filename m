From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/7] use 128M for the test virtual machines instead of 512M
Date: Thu, 18 Jun 2009 15:26:18 +0200
Message-ID: <1245331581-2453-5-git-send-email-harald@redhat.com>
References: <1245331581-2453-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245331581-2453-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 test/TEST-10-RAID/test.sh |    4 ++--
 test/TEST-20-NFS/test.sh  |    4 ++--
 test/TEST-40-NBD/test.sh  |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/test/TEST-10-RAID/test.sh b/test/TEST-10-RAID/test.sh
index a6e81ab..b208760 100755
--- a/test/TEST-10-RAID/test.sh
+++ b/test/TEST-10-RAID/test.sh
@@ -4,7 +4,7 @@ TEST_DESCRIPTION="root filesystem on an encrypted LVM PV"
 KVERSION=${KVERSION-$(uname -r)}
 
 test_run() {
-    $testdir/run-qemu -hda root.ext2 -m 512M -nographic \
+    $testdir/run-qemu -hda root.ext2 -m 128M -nographic \
 	-net none -kernel /boot/vmlinuz-$KVERSION \
 	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81" \
 	-initrd initramfs.testing
@@ -47,7 +47,7 @@ test_setup() {
 	-f initramfs.makeroot $KVERSION || return 1
     rm -rf overlay
     # Invoke KVM and/or QEMU to actually create the target filesystem.
-    $testdir/run-qemu -hda root.ext2 -m 512M -nographic -net none \
+    $testdir/run-qemu -hda root.ext2 -m 128M -nographic -net none \
 	-kernel "/boot/vmlinuz-$kernel" \
 	-append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81" \
 	-initrd initramfs.makeroot  || return 1
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index d3787ec..ff11f27 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -10,7 +10,7 @@ run_server() {
     # Start server first
     echo "NFS TEST SETUP: Starting DHCP/NFS server"
 
-    $testdir/run-qemu -hda server.ext2 -m 512M -nographic \
+    $testdir/run-qemu -hda server.ext2 -m 128M -nographic \
 	-net nic,macaddr=52:54:00:12:34:56,model=e1000 \
 	-net socket,mcast=230.0.0.1:1234 \
 	-serial udp:127.0.0.1:9999 \
@@ -42,7 +42,7 @@ client_test() {
 	return 1
     fi
 
-    $testdir/run-qemu -hda client.img -m 512M -nographic \
+    $testdir/run-qemu -hda client.img -m 128M -nographic \
   	-net nic,macaddr=$mac,model=e1000 \
   	-net socket,mcast=230.0.0.1:1234 \
   	-kernel /boot/vmlinuz-$KVERSION \
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
index f3a3d20..b6d12b6 100755
--- a/test/TEST-40-NBD/test.sh
+++ b/test/TEST-40-NBD/test.sh
@@ -11,7 +11,7 @@ run_server() {
     echo "NBD TEST SETUP: Starting DHCP/NBD server"
 
     $testdir/run-qemu -hda server.ext2 -hdb nbd.ext2 -hdc encrypted.ext2 \
-	-m 512M -nographic \
+	-m 128M -nographic \
 	-net nic,macaddr=52:54:00:12:34:56,model=e1000 \
 	-net socket,mcast=230.0.0.1:1234 \
 	-serial udp:127.0.0.1:9999 \
@@ -46,7 +46,7 @@ client_test() {
 	return 1
     fi
 
-    $testdir/run-qemu -hda flag.img -m 512M -nographic \
+    $testdir/run-qemu -hda flag.img -m 128M -nographic \
 	-net nic,macaddr=$mac,model=e1000 \
 	-net socket,mcast=230.0.0.1:1234 \
 	-kernel /boot/vmlinuz-$KVERSION \
@@ -213,7 +213,7 @@ make_encrypted_root() {
     rm -rf overlay
 
     # Invoke KVM and/or QEMU to actually create the target filesystem.
-    $testdir/run-qemu -hda flag.img -hdb encrypted.ext2 -m 512M \
+    $testdir/run-qemu -hda flag.img -hdb encrypted.ext2 -m 128M \
 	-nographic -net none \
 	-kernel "/boot/vmlinuz-$kernel" \
 	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81" \
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
