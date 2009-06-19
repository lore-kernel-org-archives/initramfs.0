From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 13/13] removed shebang from .sh and changed mode to 0644
Date: Fri, 19 Jun 2009 13:05:51 +0200
Message-ID: <1245409551-30493-14-git-send-email-harald@redhat.com>
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
 modules.d/50plymouth/plymouth-emergency.sh |    1 -
 modules.d/90dmraid/dmraid.sh               |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)
 mode change 100755 => 100644 modules.d/95resume/resume-genrules.sh
 mode change 100755 => 100644 modules.d/95rootfs-block/block-genrules.sh
 mode change 100755 => 100644 modules.d/95rootfs-block/parse-block.sh
 mode change 100755 => 100644 modules.d/99base/parse-root-opts.sh

diff --git a/modules.d/50plymouth/plymouth-emergency.sh b/modules.d/50plymouth/plymouth-emergency.sh
index e8b642d..3119330 100644
--- a/modules.d/50plymouth/plymouth-emergency.sh
+++ b/modules.d/50plymouth/plymouth-emergency.sh
@@ -1,2 +1 @@
-#!/sbin/sh
 [ -x /bin/plymouth ] && /bin/plymouth --hide-splash
diff --git a/modules.d/90dmraid/dmraid.sh b/modules.d/90dmraid/dmraid.sh
index 17a92fb..c64d686 100644
--- a/modules.d/90dmraid/dmraid.sh
+++ b/modules.d/90dmraid/dmraid.sh
@@ -1,4 +1,3 @@
-#!/bin/sh
 dmraid -ay
 udevadm settle --timeout=30 >/dev/null 2>&1 
 
diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
old mode 100755
new mode 100644
diff --git a/modules.d/95rootfs-block/block-genrules.sh b/modules.d/95rootfs-block/block-genrules.sh
old mode 100755
new mode 100644
diff --git a/modules.d/95rootfs-block/parse-block.sh b/modules.d/95rootfs-block/parse-block.sh
old mode 100755
new mode 100644
diff --git a/modules.d/99base/parse-root-opts.sh b/modules.d/99base/parse-root-opts.sh
old mode 100755
new mode 100644
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
