From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 4/4] crypt/parse-crypt.sh: hide encrypted devices from
 systemd timeout warnings.
Date: Thu, 26 Mar 2015 15:41:49 +1100
Message-ID: <20150326044148.10121.15286.stgit@notabene.brown>
References: <20150326043938.10121.34223.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150326043938.10121.34223.stgit-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

When systemd's crypttab generator parsed crypttab, it tells
systemd about several devices which may not appear until later
in the boot sequence, and which are not needed while dract is running.

This can particularly happen when an md array is encrypted,
and the array is newly degraded so that it doesn't appear until
dracut runs mdraid_start.sh.

This can result in systemd printing warning messages which are
inappropriate.

So tell systemd that the timeout for each of these is zero.

This is involves splitting some functionality out of wait_for_dev()

That function does two things:
 - creates 'finished' hooks so that dracut will wait for the device,
   and
 - sets the systemd timeout for the device to zero, so systemd doesn't
   wait.

We only want the second of these for most encrypted devices.
So split that out into a new function set_systemd_timeout_for_dev(),
and call it from parse-crypt.sh

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90crypt/parse-crypt.sh |    4 +++
 modules.d/99base/dracut-lib.sh   |   53 ++++++++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-crypt.sh
index 94ad1f63ae6f..5a64652cc51c 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -14,6 +14,10 @@ else
     LUKS=$(getargs rd.luks.uuid -d rd_LUKS_UUID)
     tout=$(getarg rd.luks.key.tout)
 
+    while read _dev _uuid ; do
+        set_systemd_timeout_for_dev $_dev
+    done
+
     if [ -n "$LUKS" ]; then
         for luksid in $LUKS; do
 
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 259e2057b67e..c8ff3c1a32d1 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -895,12 +895,10 @@ dev_unit_name()
     printf -- "%s" "$dev"
 }
 
-# wait_for_dev <dev>
-#
-# Installs a initqueue-finished script,
-# which will cause the main loop only to exit,
-# if the device <dev> is recognized by the system.
-wait_for_dev()
+# set_systemd_timeout_for_dev <dev>
+# Set 'rd.timeout' as the systemd timeout for <dev>
+
+set_systemd_timeout_for_dev()
 {
     local _name
     local _needreload
@@ -915,19 +913,6 @@ wait_for_dev()
     _timeout=$(getarg rd.timeout)
     _timeout=${_timeout:-0}
 
-    _name="$(str_replace "$1" '/' '\x2f')"
-
-    type mark_hostonly >/dev/null 2>&1 && mark_hostonly "$hookdir/initqueue/finished/devexists-${_name}.sh"
-
-    [ -e "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" ] && return 0
-
-    printf '[ -e "%s" ]\n' $1 \
-        >> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh"
-    {
-        printf '[ -e "%s" ] || ' $1
-        printf 'warn "\"%s\" does not exist"\n' $1
-    } >> "${PREFIX}$hookdir/emergency/80-${_name}.sh"
-
     if [ -n "$DRACUT_SYSTEMD" ]; then
         _name=$(dev_unit_name "$1")
         if ! [ -L ${PREFIX}/etc/systemd/system/initrd.target.wants/${_name}.device ]; then
@@ -952,6 +937,36 @@ wait_for_dev()
         fi
     fi
 }
+# wait_for_dev <dev>
+#
+# Installs a initqueue-finished script,
+# which will cause the main loop only to exit,
+# if the device <dev> is recognized by the system.
+wait_for_dev()
+{
+    local _name
+    local _noreload
+
+    if [ "$1" = "-n" ]; then
+        _noreload=-n
+        shift
+    fi
+
+    _name="$(str_replace "$1" '/' '\x2f')"
+
+    type mark_hostonly >/dev/null 2>&1 && mark_hostonly "$hookdir/initqueue/finished/devexists-${_name}.sh"
+
+    [ -e "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh" ] && return 0
+
+    printf '[ -e "%s" ]\n' $1 \
+        >> "${PREFIX}$hookdir/initqueue/finished/devexists-${_name}.sh"
+    {
+        printf '[ -e "%s" ] || ' $1
+        printf 'warn "\"%s\" does not exist"\n' $1
+    } >> "${PREFIX}$hookdir/emergency/80-${_name}.sh"
+
+    set_systemd_timeout_for_dev $_noreload $1
+}
 
 cancel_wait_for_dev()
 {

