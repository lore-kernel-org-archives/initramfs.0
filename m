From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 08/10] job control fixup
Date: Tue, 18 Oct 2011 20:33:24 +0200
Message-ID: <1318962806-24000-9-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

- in case no ctty was provided, shell was spawned without caring about
  /dev/console

Also, the ctty is more opportunistic. If the image was generated with
--ctty, we will fallback to /dev/tty1 if rc.ctty is invalid or missing.
Otherwise we spawn standard shell on /dev/console

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/99base/init         |    8 +++++---
 modules.d/99shutdown/shutdown |    9 +++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index e532bfe..3da6abd 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -59,11 +59,13 @@ emergency_shell()
         echo
         export PS1="$_rdshell_name:\${PWD}# "
         [ -e /.profile ] || >/.profile
-        _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
-        if type setsid >/dev/null 2>&1 && [ -c "$_ctty" ] ; then
+        _ctty=/dev/console
+        if type setsid >/dev/null 2>&1; then
+            _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
+            [ -c "$_ctty" ] || _ctty=/dev/tty1
             setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
         else
-            sh -i -l
+            sh -i -l 0<$_ctty 1>$_ctty 2>&1
         fi
     else
         warn "Boot has failed. To debug this issue add \"rdshell\" to the kernel command line."
diff --git a/modules.d/99shutdown/shutdown b/modules.d/99shutdown/shutdown
index 9473b5b..21bb37f 100755
--- a/modules.d/99shutdown/shutdown
+++ b/modules.d/99shutdown/shutdown
@@ -31,12 +31,13 @@ emergency_shell()
         echo
         export PS1="$_rdshell_name:\${PWD}# "
         [ -e /.profile ] || >/.profile
-        _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
-        if type setsid >/dev/null 2>&1 && [ -c "$_ctty" ] ; then
-            _ctty=/dev/${_ctty##*/}
+        _ctty=/dev/console
+        if type setsid >/dev/null 2>&1; then
+            _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
+            [ -c "$_ctty" ] || _ctty=/dev/tty1
             setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
         else
-            sh -i -l
+            sh -i -l 0<$_ctty 1>$_ctty 2>&1
         fi
     else
         exec /lib/systemd/systemd-shutdown "$@"
-- 
1.7.5.3
