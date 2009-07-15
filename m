From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 11/14] extend TEST-12-RAID-DEG to check for UUID command line parameters
Date: Wed, 15 Jul 2009 18:50:43 +0200
Message-ID: <1247676646-3837-12-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 test/TEST-12-RAID-DEG/create-root.sh |    9 +++++++-
 test/TEST-12-RAID-DEG/test.sh        |   39 +++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/test/TEST-12-RAID-DEG/create-root.sh b/test/TEST-12-RAID-DEG/create-root.sh
index a5398d9..30c9111 100755
--- a/test/TEST-12-RAID-DEG/create-root.sh
+++ b/test/TEST-12-RAID-DEG/create-root.sh
@@ -31,6 +31,13 @@ umount /sysroot && \
 lvm lvchange -a n /dev/dracut/root && \
 cryptsetup luksClose /dev/mapper/dracut_crypt_test && \
 mdadm /dev/md0 --fail /dev/sda2 --remove /dev/sda2 && \
-echo "dracut-root-block-created" >/dev/sda1
+{
+/sbin/mdadm --detail --export /dev/md0 > /tmp/mduuid ;
+. /tmp/mduuid;
+} && \
+{
+echo "dracut-root-block-created" 
+echo MD_UUID=$MD_UUID 
+}> /dev/sda1
 dd if=/dev/zero of=/dev/sda2
 poweroff -f
diff --git a/test/TEST-12-RAID-DEG/test.sh b/test/TEST-12-RAID-DEG/test.sh
index e0a9cbf..2a834d9 100755
--- a/test/TEST-12-RAID-DEG/test.sh
+++ b/test/TEST-12-RAID-DEG/test.sh
@@ -6,12 +6,45 @@ KVERSION=${KVERSION-$(uname -r)}
 # Uncomment this to debug failures
 #DEBUGFAIL="rdinitdebug rdnetdebug"
 
-test_run() {
+client_run() {
+    echo "CLIENT TEST START: $@"
     $testdir/run-qemu -hda root.ext2 -m 256M -nographic \
 	-net none -kernel /boot/vmlinuz-$KVERSION \
-	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81 rdshell $DEBUGFAIL" \
+	-append "$@ root=/dev/dracut/root rw quiet console=ttyS0,115200n81 rdshell $DEBUGFAIL " \
 	-initrd initramfs.testing
-    grep -m 1 -q dracut-root-block-success root.ext2 || return 1
+    if ! grep -m 1 -q dracut-root-block-success root.ext2; then
+	echo "CLIENT TEST END: $@ [FAIL]"
+	return 1;
+    fi
+
+    sed -i -e 's#dracut-root-block-success#dracut-root-block-xxxxxxx#' root.ext2
+    echo "CLIENT TEST END: $@ [OK]"
+    return 0
+}
+
+test_run() {
+    eval $(grep --binary-files=text -m 1 MD_UUID root.ext2)
+    echo "MD_UUID=$MD_UUID"
+
+    client_run || return 1
+
+    client_run rd_NO_LVM && return 1
+
+    client_run rd_LVM_VG=failme && return 1
+
+    client_run rd_LVM_VG=dracut || return 1
+
+    client_run rd_LVM_VG=dummy1 rd_LVM_VG=dracut rd_LVM_VG=dummy2 || return 1
+
+    client_run rd_MD_UUID=failme && return 1
+
+    client_run rd_NO_MD && return 1
+
+    client_run rd_MD_UUID=$MD_UUID || return 1
+
+    client_run rd_MD_UUID=dummy1 rd_MD_UUID=$MD_UUID rd_MD_UUID=dummy2 || return 1
+
+    return 0
 }
 
 test_setup() {
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
