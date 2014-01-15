From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] set testonly for the relevant test cases
Date: Wed, 15 Jan 2014 20:53:49 +0800
Message-ID: <1389790430-17808-2-git-send-email-bhe@redhat.com>
References: <1389790430-17808-1-git-send-email-bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389790430-17808-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Now only watchdog module is for test only. So test cases which
relates to watchdog need be set the testonly option. So add
"--testonly" to the relevant test cases.
---
 test/TEST-01-BASIC/test.sh     | 1 +
 test/TEST-03-USR-MOUNT/test.sh | 1 +
 test/TEST-20-NFS/test.sh       | 1 +
 test/TEST-40-NBD/test.sh       | 1 +
 test/TEST-50-MULTINIC/test.sh  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/test/TEST-01-BASIC/test.sh b/test/TEST-01-BASIC/test.sh
index f857fd4..f3fb1cc 100755
--- a/test/TEST-01-BASIC/test.sh
+++ b/test/TEST-01-BASIC/test.sh
@@ -86,6 +86,7 @@ test_setup() {
 	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
     )
     sudo $basedir/dracut.sh -l -i $TESTDIR/overlay / \
+	--testonly \
 	-a "debug watchdog" \
 	-d "piix ide-gd_mod ata_piix ext3 sd_mod i6300esb ib700wdt" \
 	-f $TESTDIR/initramfs.testing $KVERSION || return 1
diff --git a/test/TEST-03-USR-MOUNT/test.sh b/test/TEST-03-USR-MOUNT/test.sh
index b3d709e..b8ce951 100755
--- a/test/TEST-03-USR-MOUNT/test.sh
+++ b/test/TEST-03-USR-MOUNT/test.sh
@@ -121,6 +121,7 @@ test_setup() {
 	inst_simple ./99-idesymlinks.rules /etc/udev/rules.d/99-idesymlinks.rules
     )
     sudo $basedir/dracut.sh -l -i $TESTDIR/overlay / \
+	--testonly \
 	-a "debug watchdog" \
         -o "network" \
 	-d "piix ide-gd_mod ata_piix btrfs sd_mod i6300esb ib700wdt" \
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 4f21d45..014e0eb 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -346,6 +346,7 @@ test_setup() {
 
     # Make client's dracut image
     $basedir/dracut.sh -l -i $TESTDIR/overlay / \
+        --testonly \
         -o "plymouth dash" \
         -a "debug watchdog" \
         -d "af_packet piix ide-gd_mod ata_piix sd_mod e1000 nfs sunrpc i6300esb" \
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
index 7cf64b1..6f99e72 100755
--- a/test/TEST-40-NBD/test.sh
+++ b/test/TEST-40-NBD/test.sh
@@ -357,6 +357,7 @@ test_setup() {
         -f $TESTDIR/initramfs.server $KVERSION || return 1
 
     sudo $basedir/dracut.sh -l -i $TESTDIR/overlay / \
+        --testonly \
         -o "plymouth" \
         -a "debug watchdog" \
         -d "af_packet piix ide-gd_mod ata_piix ext2 ext3 sd_mod e1000 i6300esb ib700wdt" \
diff --git a/test/TEST-50-MULTINIC/test.sh b/test/TEST-50-MULTINIC/test.sh
index add849c..e8ee80f 100755
--- a/test/TEST-50-MULTINIC/test.sh
+++ b/test/TEST-50-MULTINIC/test.sh
@@ -264,6 +264,7 @@ test_setup() {
 
     # Make server's dracut image
     $basedir/dracut.sh -l -i "$TESTDIR"/overlay / \
+        --testonly \
         -m "dash udev-rules base rootfs-block debug kernel-modules watchdog" \
         -d "af_packet piix ide-gd_mod ata_piix ext3 sd_mod nfsv2 nfsv3 nfsv4 nfs_acl nfs_layout_nfsv41_files nfsd e1000 i6300esb ib700wdt" \
         -f "$TESTDIR"/initramfs.server "$KVERSION" || return 1
-- 
1.8.3.1
