From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] only use openvt on systems where the console is a vt
Date: Wed, 14 Mar 2012 11:01:48 -0400
Message-ID: <1331737309-24315-3-git-send-email-wwoods@redhat.com>
References: <1331737309-24315-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331737309-24315-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On systems where ttyX doesn't go anywhere useful (headless stuff like
IBM POWER, some virt guests, s390), openvt can't do anything useful.

Don't bother using openvt on those systems; just fall back to plain sh.
---
 modules.d/99base/dracut-lib.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index cc93a83..1ebe399 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -784,7 +784,7 @@ wait_for_loginit()
 
 emergency_shell()
 {
-    local _ctty
+    local _ctty _using_vt
     set +e
     if [ "$1" = "-n" ]; then
         _rdshell_name=$2
@@ -814,10 +814,11 @@ emergency_shell()
             _ctty=/dev/$_ctty
         fi
         [ -c "$_ctty" ] || _ctty=/dev/tty1
+        case "$_ctty" in /dev/tty[0-9]*) _using_vt=1;; esac
 
         if [ -n "$(command -v setsid)" ]; then
             setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
-        elif [ -n "$(command -v openvt)" ] && ! getarg "console=" >/dev/null 2>&1 && getargbool 1 "rd.openvt" ; then
+        elif [ -n "$(command -v openvt)" ] && [ "$_using_vt" = 1 ] && getargbool 1 "rd.openvt"; then
             openvt -f -c 1 -w -s -l -- sh
         else
             sh -i -l 0<$_ctty 1>$_ctty 2>&1
-- 
1.7.7.6
