From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/7] install "basename" for path_id
Date: Thu, 18 Jun 2009 15:26:16 +0200
Message-ID: <1245331581-2453-3-git-send-email-harald@redhat.com>
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
 modules.d/95udev-rules/install |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
index 4cf488d..c5d73a6 100755
--- a/modules.d/95udev-rules/install
+++ b/modules.d/95udev-rules/install
@@ -3,9 +3,9 @@
 # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
 # of the rules we want so that we just copy those in would be best
 dracut_install udevd udevadm /lib*/udev/*_id /etc/udev/udev.conf /etc/group
+dracut_install basename
 inst_rules 50-udev-default.rules 60-persistent-storage.rules \
     61-persistent-storage-edd.rules 80-drivers.rules 95-udev-late.rules 
-
 #Some debian udev rules are named differently
 inst_rules 50-udev.rules 95-late.rules
  
@@ -13,4 +13,4 @@ if ldd $(find_binary udevd) |grep -q /lib64/libc; then
     dracut_install /lib64/libnss_files*
 else
     dracut_install /lib/libnss_files*
-fi
\ No newline at end of file
+fi
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
