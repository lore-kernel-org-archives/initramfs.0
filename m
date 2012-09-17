From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] use lib function dir_ismounted in convertfs module
Date: Mon, 17 Sep 2012 16:00:44 +0800
Message-ID: <20120917080044.GA15763@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org


convertfs module use a private function of ismounted(), this is
duplicate of the one in dracut-lib.sh.

Change to use global dir_ismounted

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/30convertfs/convertfs.sh |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- dracut.orig/modules.d/30convertfs/convertfs.sh
+++ dracut/modules.d/30convertfs/convertfs.sh
@@ -9,6 +9,8 @@ if [[ ! -d "$ROOT" ]]; then
     exit 1
 fi
 
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+
 if [[ "$ROOT" -ef / ]]; then
     echo "Can't convert the running system."
     echo "Please boot with 'rd.convertfs' on the kernel command line,"
@@ -73,13 +75,6 @@ if [[ ! -e "$testfile" ]]; then
 fi
 rm -f "$testfile"
 
-ismounted() {
-    while read a m a; do
-        [[ "$m" = "$1" ]] && return 0
-    done < /proc/mounts
-    return 1
-}
-
 # clean up after ourselves no matter how we die.
 cleanup() {
     echo "Something failed. Move back to the original state"
@@ -98,7 +93,7 @@ cleanup() {
 trap 'ret=$?; [[ $ret -ne 0 ]] && cleanup;exit $ret;' EXIT
 trap 'exit 1;' SIGINT
 
-ismounted "$ROOT/usr" || CP_HARDLINK="-l"
+dir_ismounted "$ROOT/usr" || CP_HARDLINK="-l"
 
 set -e
 
