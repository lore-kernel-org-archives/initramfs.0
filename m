From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] 99base/dracut-lib.sh: split _emergency_shell
Date: Mon, 24 Jun 2013 18:14:48 +0800
Message-ID: <f8dd0b6259e7709eadb1c2ef5957ce0d32ca74fe.1372068867.git.bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

With rd.action_on_fail specified and 'DRACUT_SYSTEMD' set, the
_emergency_shell calling will fail even though user really want to drop into
shell by explicitly calling it.

Now split _emergency_shell into 2 functions, the 1st is called if
"DRACUT_SYSTEMD" is set, otherwise the 2nd is called. Then user
who want to drop into shell anyway can use the 2nd function.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |   76 +++++++++++++++++++++------------------
 1 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 581b63a..0f4f858 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -924,45 +924,47 @@ wait_for_loginit()
     rm -f /run/initramfs/loginit.pipe /run/initramfs/loginit.pid
 }
 
+_emergency_shell_systemd()
+{
+    local _name="$1"
+    > /.console_lock
+    echo "PS1=\"$_name:\\\${PWD}# \"" >/etc/profile
+    systemctl start dracut-emergency.service
+    rm -f /etc/profile
+    rm -f /.console_lock
+}
+
 _emergency_shell()
 {
     local _name="$1"
-    if [ -n "$DRACUT_SYSTEMD" ]; then
-        > /.console_lock
-        echo "PS1=\"$_name:\\\${PWD}# \"" >/etc/profile
-        systemctl start dracut-emergency.service
-        rm -f /etc/profile
-        rm -f /.console_lock
-    else
-        debug_off
-        echo
-        /sbin/sosreport
-        echo 'You might want to save "/run/initramfs/sosreport.txt" to a USB stick or /boot'
-        echo 'after mounting them and attach it to a bug report.'
-        if ! RD_DEBUG= getargbool 0 rd.debug -d -y rdinitdebug -d -y rdnetdebug; then
-            echo
-            echo 'To get more debug information in the report,'
-            echo 'reboot with "rd.debug" added to the kernel command line.'
-        fi
-        echo
-        echo 'Dropping to debug shell.'
+    debug_off
+    echo
+    /sbin/sosreport
+    echo 'You might want to save "/run/initramfs/sosreport.txt" to a USB stick or /boot'
+    echo 'after mounting them and attach it to a bug report.'
+    if ! RD_DEBUG= getargbool 0 rd.debug -d -y rdinitdebug -d -y rdnetdebug; then
         echo
-        export PS1="$_name:\${PWD}# "
-        [ -e /.profile ] || >/.profile
-
-        _ctty="$(RD_DEBUG= getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
-        if [ -z "$_ctty" ]; then
-            _ctty=console
-            while [ -f /sys/class/tty/$_ctty/active ]; do
-                _ctty=$(cat /sys/class/tty/$_ctty/active)
-                _ctty=${_ctty##* } # last one in the list
-            done
-            _ctty=/dev/$_ctty
-        fi
-        [ -c "$_ctty" ] || _ctty=/dev/tty1
-        case "$(/usr/bin/setsid --help 2>&1)" in *--ctty*) CTTY="--ctty";; esac
-        setsid $CTTY /bin/sh -i -l 0<>$_ctty 1<>$_ctty 2<>$_ctty
+        echo 'To get more debug information in the report,'
+        echo 'reboot with "rd.debug" added to the kernel command line.'
     fi
+    echo
+    echo 'Dropping to debug shell.'
+    echo
+    export PS1="$_name:\${PWD}# "
+    [ -e /.profile ] || >/.profile
+
+    _ctty="$(RD_DEBUG= getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
+    if [ -z "$_ctty" ]; then
+        _ctty=console
+        while [ -f /sys/class/tty/$_ctty/active ]; do
+            _ctty=$(cat /sys/class/tty/$_ctty/active)
+            _ctty=${_ctty##* } # last one in the list
+        done
+        _ctty=/dev/$_ctty
+    fi
+    [ -c "$_ctty" ] || _ctty=/dev/tty1
+    case "$(/usr/bin/setsid --help 2>&1)" in *--ctty*) CTTY="--ctty";; esac
+    setsid $CTTY /bin/sh -i -l 0<>$_ctty 1<>$_ctty 2<>$_ctty
 }
 
 emergency_shell()
@@ -989,7 +991,11 @@ emergency_shell()
     echo
 
     if getargbool 1 rd.shell -d -y rdshell || getarg rd.break -d rdbreak; then
-        _emergency_shell $_rdshell_name
+        if [ -n "$DRACUT_SYSTEMD" ]; then
+            _emergency_shell_systemd $_rdshell_name
+        else
+            _emergency_shell $_rdshell_name
+        fi
     else
         warn "$action has failed. To debug this issue add \"rd.shell rd.debug\" to the kernel command line."
         # cause a kernel panic
-- 
1.7.1
