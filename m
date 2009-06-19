From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 02/13] uncomment hard-off for TEST-30-ISCSI
Date: Fri, 19 Jun 2009 13:05:40 +0200
Message-ID: <1245409551-30493-3-git-send-email-harald@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245409551-30493-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 test/TEST-30-ISCSI/test.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/TEST-30-ISCSI/test.sh b/test/TEST-30-ISCSI/test.sh
index 3fd6bd3..134ee73 100755
--- a/test/TEST-30-ISCSI/test.sh
+++ b/test/TEST-30-ISCSI/test.sh
@@ -3,7 +3,7 @@ TEST_DESCRIPTION="root filesystem over iSCSI"
 
 KVERSION=${KVERSION-$(uname -r)}
 
-#DEBUGFAIL="rdinitdebug rdnetdebug udevinfo"
+#DEBUGFAIL="rdinitdebug rdnetdebug rdudevinfo"
 
 run_server() {
     # Start server first
@@ -110,7 +110,7 @@ test_setup() {
 	initdir=overlay
 	. $basedir/dracut-functions
 	dracut_install poweroff shutdown
-#	inst_simple ./hard-off.sh /emergency/01hard-off.sh
+	inst_simple ./hard-off.sh /emergency/01hard-off.sh
 #	inst ./cryptroot-ask /sbin/cryptroot-ask
     )
 #	-m "debug dash crypt lvm mdraid udev-rules base rootfs-block iscsi" \
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
