From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Install debian renamed udev rules as well
Date: Mon, 8 Jun 2009 17:18:44 +0200
Message-ID: <4A2D2BD4.1000504@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Debian has reworked/renamed quite a few default udev rules.

This patch ensures that the necessary debian rules get installed if available.

---
diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
index b53650f..3ed1e5a 100755
--- a/modules.d/95udev-rules/install
+++ b/modules.d/95udev-rules/install
@@ -6,6 +6,9 @@ dracut_install udevd udevadm /lib*/udev/*_id /etc/udev/udev.conf /etc/group
 inst_rules 50-udev-default.rules 60-persistent-storage.rules \
     61-persistent-storage-edd.rules 80-drivers.rules 95-udev-late.rules 
 
+#Debian udev rules are named a bit differently
+inst_rules 50-udev.rules 95-late.rules
+
 if ldd $(find_binary udevd) |grep -q /lib64/libc; then
     dracut_install /lib64/libnss_files*
 else
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
