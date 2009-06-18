From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/7] add DEBUGFAIL to TEST-10-RAID
Date: Thu, 18 Jun 2009 15:26:20 +0200
Message-ID: <1245331581-2453-7-git-send-email-harald@redhat.com>
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
 test/TEST-10-RAID/test.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/test/TEST-10-RAID/test.sh b/test/TEST-10-RAID/test.sh
index b208760..59ae01e 100755
--- a/test/TEST-10-RAID/test.sh
+++ b/test/TEST-10-RAID/test.sh
@@ -3,10 +3,13 @@ TEST_DESCRIPTION="root filesystem on an encrypted LVM PV"
 
 KVERSION=${KVERSION-$(uname -r)}
 
+# Uncomment this to debug failures
+#DEBUGFAIL="rdinitdebug rdnetdebug"
+
 test_run() {
     $testdir/run-qemu -hda root.ext2 -m 128M -nographic \
 	-net none -kernel /boot/vmlinuz-$KVERSION \
-	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81" \
+	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81 $DEBUGFAIL" \
 	-initrd initramfs.testing
     grep -m 1 -q dracut-root-block-success root.ext2 || return 1
 }
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
