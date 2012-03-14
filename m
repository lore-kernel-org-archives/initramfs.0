From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] fix emergency_shell with setsid (--ctty/cttyhack)
Date: Wed, 14 Mar 2012 11:01:47 -0400
Message-ID: <1331737309-24315-2-git-send-email-wwoods@redhat.com>
References: <1331737309-24315-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331737309-24315-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

So, for emergency_shell to work right, it has to be a session leader
(e.g. by using setsid) and it needs to have a controlling tty (ctty).
But /dev/console and /dev/tty0 are just aliases - they aren't allowed to
be cttys!

For this to work, we need to be attached to a *real* tty. Which means
finding the real tty that /dev/console is attached to.

In the past, anaconda's "loader" and busybox's "cttyhack" used a series
of ioctl() calls to guess what tty device /dev/console is actually
attached to. Now we have /sys/class/tty/*/active, which tells us what
device(s) are active for aliases like /dev/console or /dev/tty0.

So: we can find our actual console device by following the 'active'
links until we get to a real device. cttyhack uses the *last* device it
finds in the list for /dev/console so we'll do the same.
---
 modules.d/99base/dracut-lib.sh |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 80e093b..cc93a83 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -803,10 +803,19 @@ emergency_shell()
         echo
         export PS1="$_rdshell_name:\${PWD}# "
         [ -e /.profile ] || >/.profile
-        _ctty=/dev/console
+
+        _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
+        if [ -z "$_ctty" ]; then
+            _ctty=console
+            while [ -f /sys/class/tty/$_ctty/active ]; do
+                _ctty=$(cat /sys/class/tty/$_ctty/active)
+                _ctty=${_ctty##* } # last one in the list
+            done
+            _ctty=/dev/$_ctty
+        fi
+        [ -c "$_ctty" ] || _ctty=/dev/tty1
+
         if [ -n "$(command -v setsid)" ]; then
-            _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
-            [ -c "$_ctty" ] || _ctty=/dev/tty1
             setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
         elif [ -n "$(command -v openvt)" ] && ! getarg "console=" >/dev/null 2>&1 && getargbool 1 "rd.openvt" ; then
             openvt -f -c 1 -w -s -l -- sh
-- 
1.7.7.6
