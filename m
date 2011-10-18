From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 09/10] prepare common emergency_shell function (1), shell job control fixups (2)
Date: Tue, 18 Oct 2011 20:33:25 +0200
Message-ID: <1318962806-24000-10-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

1) prepare common emergency_shell

emergency_shell functions from 99base/init and 99shutdown/shutdown were
very similar, which forced to do similar changes in both places

The core functionality was moved to 99base/dracut-lib.sh as
emergency_shell_core(), which is now called through wrapping
emergency_shell(), with two simple internal knobs (type and error
message). wait_for_loginit() was moved to the lib as well.

2) shell job control fixups

Terminal (the one provided to command line) is thoroughly checked if it
really is terminal. In case of any problems we fallback to /dev/tty1
(if --ctty was used) or if it doesn't exist for whatever reason (or no
--ctty was used), to /dev/console. Additionally, shell is never spawned
through setsid on /dev/console (little point to do so).

This should cover all possible corner cases.
---
 modules.d/99base/dracut-lib.sh |   98 ++++++++++++++++++++++++++++++++++++++++
 modules.d/99base/init          |   64 --------------------------
 modules.d/99shutdown/shutdown  |   37 ++-------------
 3 files changed, 102 insertions(+), 97 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index cf5aae6..ff80eda 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -555,3 +555,101 @@ usable_root() {
     [ -e "$1/lib" -o -e "$1/lib64" ] || return 1
     return 0
 }
+
+wait_for_loginit()
+{
+    set +x
+    [ "$RD_DEBUG" = "yes" ] || return
+    [ -e /run/initramfs/loginit.pipe ] || return
+    echo "DRACUT_LOG_END"
+    exec 0<>/dev/console 1<>/dev/console 2<>/dev/console
+    # wait for loginit
+    i=0
+    while [ $i -lt 10 ]; do
+        if [ ! -e /run/initramfs/loginit.pipe ]; then
+            j=$(jobs)
+            [ -z "$j" ] && break
+            [ -z "${j##*Running*}" ] || break
+        fi
+        sleep 0.1
+        i=$(($i+1))
+    done
+
+    if [ $i -eq 10 ]; then
+        kill %1 >/dev/null 2>&1
+        kill $(while read line;do echo $line;done</run/initramfs/loginit.pid)
+    fi
+
+    set -x
+    rm -f /run/initramfs/loginit.pipe /run/initramfs/loginit.pid
+}
+
+# meant only to be called through emergency_shell wrapper function;
+# standard version is defined below, shutdown override is in
+# 99shutdown/shutdown
+#
+# $1     - 's' or 'i', depending if it was called from shutdown or init
+# $2     - error message
+# $3     - "name", or:
+# $3, $4 - "-n" "name"
+# remaining arguments - remaining message passed to wrapper
+#
+emergency_shell_core()
+{
+    local _type; local _mesg
+    set +e
+
+    _type="$1"; _mesg="$2"; shift 2
+    if [ "$1" = "-n" ]; then
+        _rdshell_name=$2
+        shift 2
+    else
+        _rdshell_name=dracut
+    fi
+    echo ; echo
+    warn "$*"
+    echo
+    if [ $_type = i ]; then
+        source_hook emergency
+        wait_for_loginit
+        [ -e /run/initramfs/.die ] && exit 1
+    else
+        source_hook shutdown-emergency
+    fi
+    if getargbool 1 rd.shell -y rdshell || getarg rd.break rdbreak; then
+        local _tty; local _tmp
+
+        _tty=/dev/console
+        if type setsid >/dev/null 2>&1; then
+            [ -c /dev/tty1 ] && _tty=/dev/tty1
+            _tmp="$(getarg rd.ctty=)" && _tmp="/dev/${_tmp##*/}"
+            if [ -c "$_tmp" ] && exec 9<>$_tmp >/dev/null 2>&1; then
+                [ -t 9 ] && _tty=$_tmp
+                exec 9>&-
+            fi
+        fi
+        [ -x /lib/udev/console_init ] && /lib/udev/console_init $_tty
+
+        echo "Dropping to debug shell."
+        echo
+        export PS1="$_rdshell_name:\${PWD}# "
+        [ -e /.profile ] || >/.profile
+        if [ $_tty != /dev/console ]; then
+            setsid sh -i -l 0<$_tty 1>$_tty 2>&1
+        else
+            sh -i -l 0<$_tty 1>$_tty 2>&1
+        fi
+    else
+        [ $_type = s ] && exec /lib/systemd/systemd-shutdown "$@"
+        warn "$_mesg"
+        # cause a kernel panic
+        exit 1
+    fi
+}
+
+emergency_shell()
+{
+    emergency_shell_core i \
+        "Boot has failed. To debug this issue add \"rd.shell\" to the kernel command line." \
+        "$@"
+}
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 3da6abd..16ed3fc 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -10,70 +10,6 @@
 
 export -p > /tmp/export.orig
 
-wait_for_loginit()
-{
-    set +x
-    [ "$RD_DEBUG" = "yes" ] || return
-    [ -e /run/initramfs/loginit.pipe ] || return
-    echo "DRACUT_LOG_END"
-    exec 0<>/dev/console 1<>/dev/console 2<>/dev/console
-        # wait for loginit
-    i=0
-    while [ $i -lt 10 ]; do
-        if [ ! -e /run/initramfs/loginit.pipe ]; then
-            j=$(jobs)
-            [ -z "$j" ] && break
-            [ -z "${j##*Running*}" ] || break
-        fi
-        sleep 0.1
-        i=$(($i+1))
-    done
-
-    if [ $i -eq 10 ]; then
-        kill %1 >/dev/null 2>&1
-        kill $(while read line;do echo $line;done</run/initramfs/loginit.pid)
-    fi
-
-    set -x
-    rm -f /run/initramfs/loginit.pipe /run/initramfs/loginit.pid
-}
-
-emergency_shell()
-{
-    local _ctty
-    set +e
-    if [ "$1" = "-n" ]; then
-        _rdshell_name=$2
-        shift 2
-    else
-        _rdshell_name=dracut
-    fi
-    echo ; echo
-    warn $@
-    source_hook emergency
-    echo
-    wait_for_loginit
-    [ -e /run/initramfs/.die ] && exit 1
-    if getargbool 1 rd.shell -y rdshell || getarg rd.break rdbreak; then
-        echo "Dropping to debug shell."
-        echo
-        export PS1="$_rdshell_name:\${PWD}# "
-        [ -e /.profile ] || >/.profile
-        _ctty=/dev/console
-        if type setsid >/dev/null 2>&1; then
-            _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
-            [ -c "$_ctty" ] || _ctty=/dev/tty1
-            setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
-        else
-            sh -i -l 0<$_ctty 1>$_ctty 2>&1
-        fi
-    else
-        warn "Boot has failed. To debug this issue add \"rdshell\" to the kernel command line."
-        # cause a kernel panic
-        exit 1
-    fi
-}
-
 trap "emergency_shell Signal caught!" 0
 OLDPATH=$PATH
 PATH=/usr/sbin:/usr/bin:/sbin:/bin
diff --git a/modules.d/99shutdown/shutdown b/modules.d/99shutdown/shutdown
index 21bb37f..8a44e8f 100755
--- a/modules.d/99shutdown/shutdown
+++ b/modules.d/99shutdown/shutdown
@@ -7,44 +7,15 @@
 # Copyright 2011, Red Hat, Inc.
 # Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 
-#!/bin/sh
 . /lib/dracut-lib.sh
 export TERM=linux
 
+# override standard function
 emergency_shell()
 {
-    local _ctty
-    set +e
-    if [ "$1" = "-n" ]; then
-        _rdshell_name=$2
-        shift 2
-    else
-        _rdshell_name=dracut
-    fi
-    echo ; echo
-    warn $@
-    source_hook shutdown-emergency
-    echo
-    if getargbool 1 rd.shell -y rdshell || getarg rd.break rdbreak; then
-        [ -x /lib/udev/console_init ] && /lib/udev/console_init /dev/console
-        echo "Dropping to debug shell."
-        echo
-        export PS1="$_rdshell_name:\${PWD}# "
-        [ -e /.profile ] || >/.profile
-        _ctty=/dev/console
-        if type setsid >/dev/null 2>&1; then
-            _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
-            [ -c "$_ctty" ] || _ctty=/dev/tty1
-            setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
-        else
-            sh -i -l 0<$_ctty 1>$_ctty 2>&1
-        fi
-    else
-        exec /lib/systemd/systemd-shutdown "$@"
-        warn "Shutdown has failed. To debug this issue add \"rdshell\" to the kernel command line."
-        # cause a kernel panic
-        exit 1
-    fi
+    emergency_shell_core s \
+        "Shutdown has failed. To debug this issue add \"rd.shell\" to the kernel command line." \
+        "$@"
 }
 
 trap "emergency_shell Signal caught!" 0
-- 
1.7.5.3
