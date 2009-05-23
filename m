From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 3/5] lib: create a library for useful shell functions
Date: Fri, 22 May 2009 22:29:22 -0400
Message-ID: <60a2af259ed832622dba50c78157053ef4d033a5.1243053563.git.dave@thedillows.org>
References: <cover.1243053563.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243053563.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 

There are several snippits of shell code that are useful to multiple
scripts. Start by moving getarg() into the library.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 modules.d/99base/dracut-lib |   16 ++++++++++++++++
 modules.d/99base/init       |   12 ++----------
 modules.d/99base/install    |    1 +
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/modules.d/99base/dracut-lib b/modules.d/99base/dracut-lib
new file mode 100644
index 0000000..1f31933
--- /dev/null
+++ b/modules.d/99base/dracut-lib
@@ -0,0 +1,16 @@
+#!/bin/sh
+#
+# Licensed under the GPLv2
+#
+# Copyright 2008, Red Hat, Inc.
+# Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+
+getarg() {
+    local o line
+    [ "$CMDLINE" ] || read CMDLINE </proc/cmdline;
+    for o in $CMDLINE; do
+	[ "$o" = "$1" ] && return 0
+	[ "${o%%=*}" = "${1%=}" ] && { echo ${o#*=}; return 0; }
+    done
+    return 1
+}
diff --git a/modules.d/99base/init b/modules.d/99base/init
index ac6a2d8..05cc4b7 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -14,15 +14,6 @@ emergency_shell()
     sh -i
 }
 
-getarg() {
-    local o line
-    for o in $CMDLINE; do
-	[ "$o" = "$1" ] && return 0
-	[ "${o%%=*}" = "${1%=}" ] && { echo ${o#*=}; return 0; }
-    done
-    return 1
-}
-
 source_all() {
     local f
     [ "$1" ] && [  -d "/$1" ] || return
@@ -35,6 +26,8 @@ NEWROOT="/sysroot"
 
 trap "emergency_shell" 0
 
+. /lib/dracut-lib
+
 mknod /dev/null c 1 3
 
 # mount some important things
@@ -42,7 +35,6 @@ mount -t proc /proc /proc >/dev/null 2>&1
 mount -t sysfs /sys /sys >/dev/null 2>&1
 mount -t tmpfs -omode=0755 udev /dev >/dev/null 2>&1
 
-read CMDLINE </proc/cmdline;
 getarg ramfsdebug && set -x
 # Make some basic devices first, let udev handle the rest
 mknod /dev/null c 1 3
diff --git a/modules.d/99base/install b/modules.d/99base/install
index 00436ae..ce1e2f9 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -9,4 +9,5 @@ if [ ! -x "$moddir/switch_root" ]; then
     exit 1
 fi
 inst "$moddir/switch_root" "/sbin/switch_root"
+inst "$moddir/dracut-lib" "/lib/dracut-lib"
 inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
