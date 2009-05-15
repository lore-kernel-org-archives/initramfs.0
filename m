From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 07/11] dash echo does not support -e option
Date: Fri, 15 May 2009 14:39:48 +0200
Message-ID: <4A0D6294.1040509@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070201080104030801020903"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------070201080104030801020903
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


use /bin/echo, instead of dash builtin echo
do not use "sh -c"
---
  modules.d/95rootfs-block-udev/genrules.sh |    9 ++++-----
  modules.d/95rootfs-block-udev/install     |    1 +
  2 files changed, 5 insertions(+), 5 deletions(-)



--------------070201080104030801020903
Content-Type: text/x-patch;
 name="e419faf652b7323963df00046b0fa6109ea6d12e.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="e419faf652b7323963df00046b0fa6109ea6d12e.diff"

diff --git a/modules.d/95rootfs-block-udev/genrules.sh b/modules.d/95rootfs-block-udev/genrules.sh
index d4e226c..0b42483 100755
--- a/modules.d/95rootfs-block-udev/genrules.sh
+++ b/modules.d/95rootfs-block-udev/genrules.sh
@@ -1,15 +1,14 @@
 
 resume=$(getarg resume=) && ! getarg noresume && [ -b "$resume" ] && {
-    # parsing the output of ls is Bad, but until there is a better way...
     (
-    	echo -e 'KERNEL=="'${resume#/dev/}'", RUN+="/bin/sh -c \047 echo %M:%m > /sys/power/resume \047 "'
-    	echo -e 'SYMLINK=="'${resume#/dev/}'", RUN+="/bin/sh -c \047 echo %M:%m > /sys/power/resume \047 "'
+    	/bin/echo -e 'KERNEL=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
+    	/bin/echo -e 'SYMLINK=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
     ) >> /etc/udev/rules.d/99-resume.rules
 }
 
 (
- echo -e 'KERNEL=="'${root#/dev/}'", RUN+="/bin/sh -c \047 mount '$fstype' -o '$rflags' '$root' '$NEWROOT' \047 " '
- echo -e 'SYMLINK=="'${root#/dev/}'", RUN+="/bin/sh -c \047 mount '$fstype' -o '$rflags' '$root' '$NEWROOT' \047 " '
+ echo 'KERNEL=="'${root#/dev/}'", RUN+="/bin/mount '$fstype' -o '$rflags' '$root' '$NEWROOT'" '
+ echo 'SYMLINK=="'${root#/dev/}'", RUN+="/bin/mount '$fstype' -o '$rflags' '$root' '$NEWROOT'" '
 ) >> /etc/udev/rules.d/99-mount.rules
 
 
diff --git a/modules.d/95rootfs-block-udev/install b/modules.d/95rootfs-block-udev/install
index 641e7df..3b02232 100755
--- a/modules.d/95rootfs-block-udev/install
+++ b/modules.d/95rootfs-block-udev/install
@@ -1,3 +1,4 @@
 #!/bin/sh
+dracut_install echo
 inst_hook pre-udev 10 "$moddir/parse-root-opts.sh"
 inst_hook pre-udev 20 "$moddir/genrules.sh"


--------------070201080104030801020903--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
