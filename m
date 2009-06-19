From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 06/13] install rules to ignore some devices
Date: Fri, 19 Jun 2009 13:05:44 +0200
Message-ID: <1245409551-30493-7-git-send-email-harald@redhat.com>
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
 modules.d/95udev-rules/01-ignore.rules |    1 +
 modules.d/95udev-rules/install         |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/95udev-rules/01-ignore.rules

diff --git a/modules.d/95udev-rules/01-ignore.rules b/modules.d/95udev-rules/01-ignore.rules
new file mode 100644
index 0000000..b32f22e
--- /dev/null
+++ b/modules.d/95udev-rules/01-ignore.rules
@@ -0,0 +1 @@
+KERNEL=="ram[0-9]*", OPTIONS+="ignore_device", OPTIONS+="last_rule"
diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
index d55c61a..8a3d8e9 100755
--- a/modules.d/95udev-rules/install
+++ b/modules.d/95udev-rules/install
@@ -9,10 +9,14 @@ inst_rules 50-udev-default.rules 60-persistent-storage.rules \
 #Some debian udev rules are named differently
 inst_rules 50-udev.rules 95-late.rules
 
+# ignore some devices in the initrd
+inst_rules "$moddir/01-ignore.rules"
+
 if [ ! -x /lib/udev/vol_id ]; then
     dracut_install blkid
 fi
 
+
 if ldd $(find_binary udevd) |grep -q /lib64/libc; then
     dracut_install /lib64/libnss_files*
 else
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
