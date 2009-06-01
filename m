From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 4/9] cmdline: cleanup handling and block: handler
Date: Mon, 1 Jun 2009 00:21:53 -0400
Message-ID: <d15c7a1ab71af9ab4fccd51fa02915e949f39c86.1243833882.git.dave@thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Now init checks that we understood the root= option, and can
act upon it, presenting and error if not. Also, clean up the
generation of udev rules such that we don't require /bin/echo.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 modules.d/95rootfs-block/block-genrules.sh  |   10 +++++++---
 modules.d/95rootfs-block/install            |    4 ++--
 modules.d/95rootfs-block/parse-block.sh     |   16 ++++++++++++++++
 modules.d/95rootfs-block/parse-root-opts.sh |   15 +++++----------
 modules.d/99base/init                       |   12 ++++++++++++
 5 files changed, 42 insertions(+), 15 deletions(-)
 create mode 100755 modules.d/95rootfs-block/parse-block.sh

diff --git a/modules.d/95rootfs-block/block-genrules.sh b/modules.d/95rootfs-block/block-genrules.sh
index 47083df..5c3f957 100755
--- a/modules.d/95rootfs-block/block-genrules.sh
+++ b/modules.d/95rootfs-block/block-genrules.sh
@@ -1,6 +1,10 @@
-if [ "${root#/dev/}" != "$root" ]; then
+#!/bin/bash # for highlighting
+
+if [ "${root%%:*}" = "block" ]; then
     (
-	echo 'KERNEL=="'${root#/dev/}'", RUN+="/bin/mount '$fstype' -o '$rflags' '$root' '$NEWROOT'" '
-	echo 'SYMLINK=="'${root#/dev/}'", RUN+="/bin/mount '$fstype' -o '$rflags' '$root' '$NEWROOT'" '
+    printf 'KERNEL=="%s", RUN+="/bin/mount -t %s -o %s %s %s"\n' \
+	${root#block:/dev/} "$fstype" "$rflags" "${root#block:}" "$NEWROOT"
+    printf 'SYMLINK=="%s", RUN+="/bin/mount -t %s -o %s %s %s"\n' \
+	${root#block:/dev/} "$fstype" "$rflags" "${root#block:}" "$NEWROOT"
     ) >> /etc/udev/rules.d/99-mount.rules
 fi
diff --git a/modules.d/95rootfs-block/install b/modules.d/95rootfs-block/install
index 722e47b..b977f9b 100755
--- a/modules.d/95rootfs-block/install
+++ b/modules.d/95rootfs-block/install
@@ -1,5 +1,5 @@
 #!/bin/sh
-dracut_install echo
-inst_hook cmdline 20 "$moddir/parse-root-opts.sh"
+inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
+inst_hook cmdline 95 "$moddir/parse-block.sh"
 inst_hook pre-udev 30 "$moddir/block-genrules.sh"
 inst_hook mount 99 "$moddir/mount-root.sh"
diff --git a/modules.d/95rootfs-block/parse-block.sh b/modules.d/95rootfs-block/parse-block.sh
new file mode 100755
index 0000000..4b6ecfa
--- /dev/null
+++ b/modules.d/95rootfs-block/parse-block.sh
@@ -0,0 +1,16 @@
+#!/bin/bash # for highlighting
+
+case "$root" in
+    block:LABEL=*|LABEL=*)
+	root="${root#block:}"
+	root="$(echo $root | sed 's,/,\\x2f,g')"
+	root="block:/dev/disk/by-label/${root#LABEL=}"
+        rootok=1 ;;
+    block:UUID=*|UUID=*)
+	root="${root#block:}"
+	root="block:/dev/disk/by-uuid/${root#UUID=}"
+        rootok=1 ;;
+    /dev/*)
+	root="block:${root}"
+        rootok=1 ;;
+esac
diff --git a/modules.d/95rootfs-block/parse-root-opts.sh b/modules.d/95rootfs-block/parse-root-opts.sh
index 3a8b1a6..dc0ae6d 100755
--- a/modules.d/95rootfs-block/parse-root-opts.sh
+++ b/modules.d/95rootfs-block/parse-root-opts.sh
@@ -1,14 +1,6 @@
-#!/bin/sh
+#!/bin/bash # for highlighting
 
 root=$(getarg root=)
-case $root in
-    LABEL=*) root=${root#LABEL=}
-    root="$(echo $root |sed 's,/,\\x2f,g')"
-    root="/dev/disk/by-label/${root}" ;;
-    UUID=*) root="/dev/disk/by-uuid/${root#UUID=}" ;;
-    '') echo "Warning: no root specified"
-        root="/dev/sda1" ;;
-esac
 
 if rflags="$(getarg rootflags=)"; then
     getarg rw && rflags="${rflags},rw" || rflags="${rflags},ro"
@@ -16,6 +8,9 @@ else
     getarg rw && rflags=rw || rflags=ro
 fi
 
-fstype="$(getarg rootfstype=)" && fstype="-t ${fstype}" 
+fstype="$(getarg rootfstype=)"
+if [ -z "$fstype" ]; then
+    fstype="auto"
+fi
 
 export fstype rflags root
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 9ea4747..ebbc6ad 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -47,6 +47,18 @@ mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts >/dev/null 2>&1
 getarg 'rdbreak=cmdline' && emergency_shell
 source_all cmdline
 
+if [ -z "$rootok" -a -n "${root%%error:*}" ]; then
+    root="error: No handler for root=${root}"
+fi
+
+if [ -z "${root%%error:*}" ]; then
+    case "${root%%:*}" in
+       '') echo "FATAL: no root= option specified" ;;
+       error) echo "FATAL: ${root#error:}" ;;
+    esac
+    emergency_shell
+fi
+
 # pre-udev scripts run before udev starts, and are run only once.
 getarg 'rdbreak=pre-udev' && emergency_shell
 source_all pre-udev
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
