From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 2/9] block root: split out resume parsing and udev rules
Date: Sun, 31 May 2009 23:19:31 -0400
Message-ID: <5c123162ededa03b56b21117644740b69fdf3fbf.1243833882.git.dave@thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

We have a resume module, and these rules should live in it. Modify
the sort order a bit to ensure the resume rules continue to execute
first.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 modules.d/95resume/install                  |    3 ++-
 modules.d/95resume/resume-genrules.sh       |    6 ++++++
 modules.d/95rootfs-block/block-genrules.sh  |    6 ++++++
 modules.d/95rootfs-block/genrules.sh        |   14 --------------
 modules.d/95rootfs-block/install            |    4 ++--
 modules.d/95rootfs-block/parse-root-opts.sh |    6 ------
 6 files changed, 16 insertions(+), 23 deletions(-)
 create mode 100755 modules.d/95resume/resume-genrules.sh
 create mode 100755 modules.d/95rootfs-block/block-genrules.sh
 delete mode 100755 modules.d/95rootfs-block/genrules.sh

diff --git a/modules.d/95resume/install b/modules.d/95resume/install
index 532fcc3..e656d53 100755
--- a/modules.d/95resume/install
+++ b/modules.d/95resume/install
@@ -1,4 +1,5 @@
 #!/bin/bash
+dracut_install echo
 inst_hook pre-udev 10 "$moddir/parse-resume.sh"
+inst_hook pre-udev 30 "$moddir/resume-genrules.sh"
 inst_hook mount 90 "$moddir/resume.sh"
-
diff --git a/modules.d/95resume/resume-genrules.sh b/modules.d/95resume/resume-genrules.sh
new file mode 100755
index 0000000..108c3f7
--- /dev/null
+++ b/modules.d/95resume/resume-genrules.sh
@@ -0,0 +1,6 @@
+resume=$(getarg resume=) && ! getarg noresume  && {
+(
+	/bin/echo -e 'KERNEL=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
+	/bin/echo -e 'SYMLINK=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
+) >> /etc/udev/rules.d/99-resume.rules
+}
diff --git a/modules.d/95rootfs-block/block-genrules.sh b/modules.d/95rootfs-block/block-genrules.sh
new file mode 100755
index 0000000..47083df
--- /dev/null
+++ b/modules.d/95rootfs-block/block-genrules.sh
@@ -0,0 +1,6 @@
+if [ "${root#/dev/}" != "$root" ]; then
+    (
+	echo 'KERNEL=="'${root#/dev/}'", RUN+="/bin/mount '$fstype' -o '$rflags' '$root' '$NEWROOT'" '
+	echo 'SYMLINK=="'${root#/dev/}'", RUN+="/bin/mount '$fstype' -o '$rflags' '$root' '$NEWROOT'" '
+    ) >> /etc/udev/rules.d/99-mount.rules
+fi
diff --git a/modules.d/95rootfs-block/genrules.sh b/modules.d/95rootfs-block/genrules.sh
deleted file mode 100755
index 4662a32..0000000
--- a/modules.d/95rootfs-block/genrules.sh
+++ /dev/null
@@ -1,14 +0,0 @@
-if [ "${root#/dev/}" != "$root" ]; then
-
-    resume=$(getarg resume=) && ! getarg noresume  && {
-	(
-    	    /bin/echo -e 'KERNEL=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
-    	    /bin/echo -e 'SYMLINK=="'${resume#/dev/}'", RUN+="/bin/echo %M:%m > /sys/power/resume"'
-	) >> /etc/udev/rules.d/99-resume.rules
-    }
-
-    (
-	echo 'KERNEL=="'${root#/dev/}'", RUN+="/bin/mount '$fstype' -o '$rflags' '$root' '$NEWROOT'" '
-	echo 'SYMLINK=="'${root#/dev/}'", RUN+="/bin/mount '$fstype' -o '$rflags' '$root' '$NEWROOT'" '
-    ) >> /etc/udev/rules.d/99-mount.rules
-fi
\ No newline at end of file
diff --git a/modules.d/95rootfs-block/install b/modules.d/95rootfs-block/install
index bf36cae..9d53855 100755
--- a/modules.d/95rootfs-block/install
+++ b/modules.d/95rootfs-block/install
@@ -1,5 +1,5 @@
 #!/bin/sh
 dracut_install echo
-inst_hook pre-udev 10 "$moddir/parse-root-opts.sh"
-inst_hook pre-udev 20 "$moddir/genrules.sh"
+inst_hook pre-udev 20 "$moddir/parse-root-opts.sh"
+inst_hook pre-udev 30 "$moddir/block-genrules.sh"
 inst_hook mount 99 "$moddir/mount-root.sh"
diff --git a/modules.d/95rootfs-block/parse-root-opts.sh b/modules.d/95rootfs-block/parse-root-opts.sh
index 9c49aa9..3a8b1a6 100755
--- a/modules.d/95rootfs-block/parse-root-opts.sh
+++ b/modules.d/95rootfs-block/parse-root-opts.sh
@@ -1,10 +1,4 @@
 #!/bin/sh
-if resume=$(getarg resume=) && ! getarg noresume; then 
-    export resume
-    echo "$resume" >/.resume
-else
-    unset resume
-fi
 
 root=$(getarg root=)
 case $root in
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
