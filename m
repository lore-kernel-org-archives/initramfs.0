From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH] introduce optional job control
Date: Mon, 17 Oct 2011 23:01:50 +0200
Message-ID: <1318885310-12535-2-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Option --ctty will optionally add setsid binary to dracut's image.

During runtime, if rd.ctty is set and is a character device,
emergency shells will be spawned with job control.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut                           |    3 ++-
 modules.d/99base/init            |   10 ++++++++--
 modules.d/99base/module-setup.sh |    1 +
 modules.d/99shutdown/shutdown    |   11 +++++++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/dracut b/dracut
index 4bc0db3..d32b357 100755
--- a/dracut
+++ b/dracut
@@ -226,6 +226,7 @@ while (($# > 0)); do
         --nolvmconf)   lvmconf_l="no";;
         --debug)       debug="yes";;
         --profile)     profile="yes";;
+        --ctty)        cttyhack="yes";;
         -v|--verbose)  ((verbosity_mod_l++));;
         -q|--quiet)    ((verbosity_mod_l--));;
         -l|--local)    allowlocal="yes" ;;
@@ -504,7 +505,7 @@ chmod 755 "$initdir"
 export initdir dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug no_kernel kernel_only \
     add_drivers mdadmconf lvmconf filesystems \
-    use_fstab libdir usrlibdir fscks nofscks \
+    use_fstab libdir usrlibdir fscks nofscks cttyhack \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
     debug
 
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 06d61a8..1b62582 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -40,6 +40,7 @@ wait_for_loginit()
 
 emergency_shell()
 {
+    local _ctty
     set +e
     if [ "$1" = "-n" ]; then
         _rdshell_name=$2
@@ -57,8 +58,13 @@ emergency_shell()
         echo "Dropping to debug shell."
         echo
         export PS1="$_rdshell_name:\${PWD}# "
-        [ -e /.profile ] || echo "exec 0<>/dev/console 1<>/dev/console 2<>/dev/console" > /.profile
-        sh -i -l
+        [ -e /.profile ] || >/.profile
+        _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
+        if type setsid >/dev/null 2>&1 && [ -c "$_ctty" ] ; then
+            setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
+        else
+            sh -i -l
+        fi
     else
         warn "Boot has failed. To debug this issue add \"rdshell\" to the kernel command line."
         # cause a kernel panic
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index f6dc920..6d2fa07 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -16,6 +16,7 @@ install() {
     dracut_install mount mknod mkdir modprobe pidof sleep chroot \
         sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink
     dracut_install -o less
+    [[ $cttyhack = yes ]] && dracut_install -o setsid
     if [ ! -e "${initdir}/bin/sh" ]; then
         dracut_install bash
         (ln -s bash "${initdir}/bin/sh" || :)
diff --git a/modules.d/99shutdown/shutdown b/modules.d/99shutdown/shutdown
index a31a95d..9473b5b 100755
--- a/modules.d/99shutdown/shutdown
+++ b/modules.d/99shutdown/shutdown
@@ -13,6 +13,7 @@ export TERM=linux
 
 emergency_shell()
 {
+    local _ctty
     set +e
     if [ "$1" = "-n" ]; then
         _rdshell_name=$2
@@ -29,8 +30,14 @@ emergency_shell()
         echo "Dropping to debug shell."
         echo
         export PS1="$_rdshell_name:\${PWD}# "
-        [ -e /.profile ] || echo "exec 0<>/dev/console 1<>/dev/console 2<>/dev/console" > /.profile
-        sh -i -l
+        [ -e /.profile ] || >/.profile
+        _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
+        if type setsid >/dev/null 2>&1 && [ -c "$_ctty" ] ; then
+            _ctty=/dev/${_ctty##*/}
+            setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
+        else
+            sh -i -l
+        fi
     else
         exec /lib/systemd/systemd-shutdown "$@"
         warn "Shutdown has failed. To debug this issue add \"rdshell\" to the kernel command line."
-- 
1.7.5.3
