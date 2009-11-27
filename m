From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Remove Ubuntu 8.10 support
Date: Fri, 27 Nov 2009 13:47:28 +0100
Message-ID: <1259326048-15392-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is outdated and no longer needed
---
 modules.d/95udev-rules.ub810/check   |    3 ---
 modules.d/95udev-rules.ub810/install |   12 ------------
 2 files changed, 0 insertions(+), 15 deletions(-)
 delete mode 100755 modules.d/95udev-rules.ub810/check
 delete mode 100755 modules.d/95udev-rules.ub810/install

diff --git a/modules.d/95udev-rules.ub810/check b/modules.d/95udev-rules.ub810/check
deleted file mode 100755
index 54501f3..0000000
--- a/modules.d/95udev-rules.ub810/check
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-# if we are not running Ubuntu 8.10, then we don't need to load this module.
-[ -f /etc/lsb-release ] && grep -q "Ubuntu 8.10" /etc/lsb-release 2>/dev/null 
diff --git a/modules.d/95udev-rules.ub810/install b/modules.d/95udev-rules.ub810/install
deleted file mode 100755
index b8f7186..0000000
--- a/modules.d/95udev-rules.ub810/install
+++ /dev/null
@@ -1,12 +0,0 @@
-#!/bin/bash
-# udev rules for ubuntu 8.10
-# content from /usr/share/initramfs-tools/hooks/udev
-mkdir -p "$initdir/var/run"
-
-dracut_install udevd udevadm pkill /lib/udev/*_id /lib/udev/*_device_name \
-    /lib/udev/firmware_helper /lib/udev/ide_media /lib/udev/vio_type \
-    /lib/udev/watershed /etc/udev/udev.conf /etc/group /lib*/libnss_files.*
-
-inst_rules 05-options.rules 20-names.rules 40-basic-permissions.rules \
-    60-persistent-storage.rules 61-persistent-storage-edd.rules \
-    80-programs.rules 90-modprobe.rules 95-udev-late.rules
-- 
1.6.5.3
