From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 12/13] renamed dracut-lib to dracut-lib.sh
Date: Fri, 19 Jun 2009 13:05:50 +0200
Message-ID: <1245409551-30493-13-git-send-email-harald@redhat.com>
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
 modules.d/40network/dhclient-script |    2 +-
 modules.d/40network/ifup            |    2 +-
 modules.d/40network/netroot         |    2 +-
 modules.d/95iscsi/iscsiroot         |    2 +-
 modules.d/95nbd/nbdroot             |    2 +-
 modules.d/95nfs/nfsroot             |    2 +-
 modules.d/99base/dracut-lib         |   62 -----------------------------------
 modules.d/99base/dracut-lib.sh      |   55 +++++++++++++++++++++++++++++++
 modules.d/99base/init               |    2 +-
 modules.d/99base/install            |    2 +-
 10 files changed, 63 insertions(+), 70 deletions(-)
 delete mode 100644 modules.d/99base/dracut-lib
 create mode 100644 modules.d/99base/dracut-lib.sh

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index f662828..5b36a40 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -35,7 +35,7 @@ setup_interface() {
 
 PATH=$PATH:/sbin:/usr/sbin
 
-. /lib/dracut-lib
+. /lib/dracut-lib.sh
 
 if getarg rdnetdebug ; then
     exec >/tmp/dhclient.$interface.$$.out
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 332fc21..89017bb 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -46,7 +46,7 @@ do_static() {
 
 PATH=$PATH:/sbin:/usr/sbin
 
-. /lib/dracut-lib
+. /lib/dracut-lib.sh
 
 if getarg rdnetdebug ; then
     exec >/tmp/ifup.$1.$$.out
diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 099c9a9..f719d93 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -2,7 +2,7 @@
 
 PATH=$PATH:/sbin:/usr/sbin
 
-. /lib/dracut-lib
+. /lib/dracut-lib.sh
 
 if getarg rdnetdebug ; then
     exec >/tmp/netroot.$1.$$.out
diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
index 783306b..c66f9d2 100755
--- a/modules.d/95iscsi/iscsiroot
+++ b/modules.d/95iscsi/iscsiroot
@@ -6,7 +6,7 @@
 # iscsistart needs this.
 #
 
-. /lib/dracut-lib
+. /lib/dracut-lib.sh
 
 PATH=$PATH:/sbin:/usr/sbin
 
diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
index 71f6af9..90f6ef8 100755
--- a/modules.d/95nbd/nbdroot
+++ b/modules.d/95nbd/nbdroot
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-. /lib/dracut-lib
+. /lib/dracut-lib.sh
 
 PATH=$PATH:/sbin:/usr/sbin
 
diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index 46c2b42..6012598 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -38,7 +38,7 @@ root_to_var() {
     fi
 }
 
-. /lib/dracut-lib
+. /lib/dracut-lib.sh
 
 PATH=$PATH:/sbin:/usr/sbin
 
diff --git a/modules.d/99base/dracut-lib b/modules.d/99base/dracut-lib
deleted file mode 100644
index 00c21bd..0000000
--- a/modules.d/99base/dracut-lib
+++ /dev/null
@@ -1,62 +0,0 @@
-#!/bin/sh
-#
-# Licensed under the GPLv2
-#
-# Copyright 2008, Red Hat, Inc.
-# Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
-
-getarg() {
-    local o line
-    [ "$CMDLINE" ] || read CMDLINE </proc/cmdline;
-    for o in $CMDLINE; do
-	[ "$o" = "$1" ] && return 0
-	[ "${o%%=*}" = "${1%=}" ] && { echo ${o#*=}; return 0; }
-    done
-    return 1
-}
-
-source_all() {
-    local f
-    [ "$1" ] && [  -d "/$1" ] || return
-    for f in "/$1"/*.sh; do [ -f "$f" ] && . "$f"; done
-}
-
-die() {
-    printf "<1>FATAL: $1\n" > /dev/kmsg
-    printf "<1>Refusing to continue\n" > /dev/kmsg
-    exit 1
-}
-
-warn() {
-    printf "<1>Warning: $1\n" > /dev/kmsg
-}
-
-check_occurances() {
-    # Count the number of times the character $ch occurs in $str
-    # Return 0 if the count matches the expected number, 1 otherwise
-    local str="$1"
-    local ch="$2"
-    local expected="$3"
-    local count=0
-
-    while [ "${str#*$ch}" != "${str}" ]; do
-	str="${str#*$ch}"
-	count=$(( $count + 1 ))
-    done
-
-    [ $count -eq $expected ]
-}
-
-incol2() {
-    local dummy check;
-    local file="$1";
-    local str="$2";
-
-    [ -z "$file" ] && return;
-    [ -z "$str"  ] && return;
-
-    while read dummy check restofline; do
-	[ "$check" = "$str" ] && return 0
-    done < $file
-    return 1
-}
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
new file mode 100644
index 0000000..96ecbb0
--- /dev/null
+++ b/modules.d/99base/dracut-lib.sh
@@ -0,0 +1,55 @@
+getarg() {
+    local o line
+    [ "$CMDLINE" ] || read CMDLINE </proc/cmdline;
+    for o in $CMDLINE; do
+	[ "$o" = "$1" ] && return 0
+	[ "${o%%=*}" = "${1%=}" ] && { echo ${o#*=}; return 0; }
+    done
+    return 1
+}
+
+source_all() {
+    local f
+    [ "$1" ] && [  -d "/$1" ] || return
+    for f in "/$1"/*.sh; do [ -f "$f" ] && . "$f"; done
+}
+
+die() {
+    printf "<1>FATAL: $1\n" > /dev/kmsg
+    printf "<1>Refusing to continue\n" > /dev/kmsg
+    exit 1
+}
+
+warn() {
+    printf "<1>Warning: $1\n" > /dev/kmsg
+}
+
+check_occurances() {
+    # Count the number of times the character $ch occurs in $str
+    # Return 0 if the count matches the expected number, 1 otherwise
+    local str="$1"
+    local ch="$2"
+    local expected="$3"
+    local count=0
+
+    while [ "${str#*$ch}" != "${str}" ]; do
+	str="${str#*$ch}"
+	count=$(( $count + 1 ))
+    done
+
+    [ $count -eq $expected ]
+}
+
+incol2() {
+    local dummy check;
+    local file="$1";
+    local str="$2";
+
+    [ -z "$file" ] && return;
+    [ -z "$str"  ] && return;
+
+    while read dummy check restofline; do
+	[ "$check" = "$str" ] && return 0
+    done < $file
+    return 1
+}
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 5ce28a0..113b130 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -20,7 +20,7 @@ NEWROOT="/sysroot"
 
 trap "emergency_shell" 0
 
-. /lib/dracut-lib
+. /lib/dracut-lib.sh
 
 mknod /dev/null c 1 3
 
diff --git a/modules.d/99base/install b/modules.d/99base/install
index 4bf5301..01ad771 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -12,7 +12,7 @@ if which switch_root >/dev/null 2>&1; then
 else
     inst "$moddir/switch_root" "/sbin/switch_root"
 fi
-inst "$moddir/dracut-lib" "/lib/dracut-lib"
+inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
 inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
 inst_hook cmdline 20 "$moddir/parse-blacklist.sh"
 inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
