From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 01/13] moved test-init to TEST-10-RAID
Date: Fri, 19 Jun 2009 13:05:39 +0200
Message-ID: <1245409551-30493-2-git-send-email-harald@redhat.com>
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
 test/TEST-10-RAID/test-init |   10 ++++++++++
 test/TEST-10-RAID/test.sh   |    2 +-
 test/test-init              |   10 ----------
 3 files changed, 11 insertions(+), 11 deletions(-)
 create mode 100755 test/TEST-10-RAID/test-init
 delete mode 100755 test/test-init

diff --git a/test/TEST-10-RAID/test-init b/test/TEST-10-RAID/test-init
new file mode 100755
index 0000000..ccdc9a4
--- /dev/null
+++ b/test/TEST-10-RAID/test-init
@@ -0,0 +1,10 @@
+#!/bin/sh
+exec >/dev/console 2>&1
+echo "dracut-root-block-success" >/dev/sda1
+export TERM=linux
+export PS1='initramfs-test:\w\$ '
+[ -f /etc/fstab ] || ln -s /proc/mounts /etc/fstab
+stty sane
+echo "made it to the rootfs! Powering down."
+mount -n -o remount,ro /
+poweroff -f
diff --git a/test/TEST-10-RAID/test.sh b/test/TEST-10-RAID/test.sh
index 59ae01e..501b03e 100755
--- a/test/TEST-10-RAID/test.sh
+++ b/test/TEST-10-RAID/test.sh
@@ -28,7 +28,7 @@ test_setup() {
 	inst "$basedir/modules.d/40network/dhclient-script" "/sbin/dhclient-script"
 	inst "$basedir/modules.d/40network/ifup" "/sbin/ifup"
 	dracut_install grep
-	inst $testdir/test-init /sbin/init
+	inst ./test-init /sbin/init
 	find_binary plymouth >/dev/null && dracut_install plymouth
 	(cd "$initdir"; mkdir -p dev sys proc etc var/run tmp )
     )
diff --git a/test/test-init b/test/test-init
deleted file mode 100755
index ccdc9a4..0000000
--- a/test/test-init
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-exec >/dev/console 2>&1
-echo "dracut-root-block-success" >/dev/sda1
-export TERM=linux
-export PS1='initramfs-test:\w\$ '
-[ -f /etc/fstab ] || ln -s /proc/mounts /etc/fstab
-stty sane
-echo "made it to the rootfs! Powering down."
-mount -n -o remount,ro /
-poweroff -f
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
