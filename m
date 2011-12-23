From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4 branch usrmove] Add job control support to emergency
 shell
Date: Fri, 23 Dec 2011 16:04:23 +0800
Message-ID: <20111223080423.GA12666@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

Option --ctty will optionally add setsid binary to dracut's image.

During runtime, if rd.ctty is set and is a character device,
emergency shells will be spawned with job control.

in case no ctty was provided, shell was spawned without caring about
/dev/console. Also, the ctty is more opportunistic. If the image was
generated with --ctty, we will fallback to /dev/tty1 if rc.ctty is
invalid or missing. Otherwise we spawn standard shell on /dev/console

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut                           |    3 ++-
 dracut.8.xml                     |    9 +++++++++
 dracut.cmdline.7.xml             |   14 ++++++++++++++
 modules.d/99base/init            |   12 ++++++++++--
 modules.d/99base/module-setup.sh |    1 +
 modules.d/99shutdown/shutdown    |   12 ++++++++++--
 6 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/dracut b/dracut
index 8449fc1..24a89e6 100755
--- a/dracut
+++ b/dracut
@@ -232,6 +232,7 @@ while (($# > 0)); do
         --nolvmconf)   lvmconf_l="no";;
         --debug)       debug="yes";;
         --profile)     profile="yes";;
+        --ctty)        cttyhack="yes";;
         -v|--verbose)  ((verbosity_mod_l++));;
         -q|--quiet)    ((verbosity_mod_l--));;
         -l|--local)    allowlocal="yes" ;;
@@ -587,7 +588,7 @@ fi
 export initdir dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug no_kernel kernel_only \
     add_drivers mdadmconf lvmconf filesystems \
-    use_fstab libdir usrlibdir fscks nofscks \
+    use_fstab libdir usrlibdir fscks nofscks cttyhack \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
     debug host_fs_types host_devs
 
diff --git a/dracut.8.xml b/dracut.8.xml
index ba8ab07..a46fc04 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -297,6 +297,15 @@ include in the generic initramfs. This parameter can be specified multiple times
         </varlistentry>
         <varlistentry>
           <term>
+            <option>--ctty</option>
+          </term>
+          <listitem>
+            <para>if possible, try to spawn an emergency shell on a terminal
+              with job control</para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
             <option>-h</option>
           </term>
           <term>
diff --git a/dracut.cmdline.7.xml b/dracut.cmdline.7.xml
index 8a49056..8309d26 100644
--- a/dracut.cmdline.7.xml
+++ b/dracut.cmdline.7.xml
@@ -109,6 +109,20 @@ This parameter can be specified multiple times.</para>
 	    <para>force loading kernel module &lt;drivername&gt; after all automatic loading modules have been loaded. This parameter can be specified multiple times.</para>
           </listitem>
         </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>rd.ctty=<replaceable>&lt;terminal&gt;</replaceable></envar>
+          </term>
+          <listitem>
+            <para>
+              if the dracut image was generated with --ctty option, try to
+              spawn an emergency shell on the specified terminal; if
+              <envar>rd.ctty</envar> is specified without a value or not
+              provided at all, the default is /dev/tty1. The '/dev' prefix
+              can be omitted.
+            </para>
+          </listitem>
+        </varlistentry>
       </variablelist>
     </refsect2>
     <refsect2 id="dracut-kernel-debug">
diff --git a/modules.d/99base/init b/modules.d/99base/init
index fc00e4f..92bf6a0 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -40,6 +40,7 @@ wait_for_loginit()
 
 emergency_shell()
 {
+    local _ctty
     set +e
     if [ "$1" = "-n" ]; then
         _rdshell_name=$2
@@ -57,8 +58,15 @@ emergency_shell()
         echo "Dropping to debug shell."
         echo
         export PS1="$_rdshell_name:\${PWD}# "
-        [ -e /.profile ] || echo "exec 0<>/dev/console 1<>/dev/console 2<>/dev/console" > /.profile
-        sh -i -l
+        [ -e /.profile ] || >/.profile
+        _ctty=/dev/console
+        if type setsid >/dev/null 2>&1; then
+            _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
+            [ -c "$_ctty" ] || _ctty=/dev/tty1
+            setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
+        else
+            sh -i -l 0<$_ctty 1>$_ctty 2>&1
+        fi
     else
         warn "Boot has failed. To debug this issue add \"rdshell\" to the kernel command line."
         # cause a kernel panic
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index f6c1209..03058b1 100755
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
index a31a95d..21bb37f 100755
--- a/modules.d/99shutdown/shutdown
+++ b/modules.d/99shutdown/shutdown
@@ -13,6 +13,7 @@ export TERM=linux
 
 emergency_shell()
 {
+    local _ctty
     set +e
     if [ "$1" = "-n" ]; then
         _rdshell_name=$2
@@ -29,8 +30,15 @@ emergency_shell()
         echo "Dropping to debug shell."
         echo
         export PS1="$_rdshell_name:\${PWD}# "
-        [ -e /.profile ] || echo "exec 0<>/dev/console 1<>/dev/console 2<>/dev/console" > /.profile
-        sh -i -l
+        [ -e /.profile ] || >/.profile
+        _ctty=/dev/console
+        if type setsid >/dev/null 2>&1; then
+            _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
+            [ -c "$_ctty" ] || _ctty=/dev/tty1
+            setsid sh -i -l 0<$_ctty 1>$_ctty 2>&1
+        else
+            sh -i -l 0<$_ctty 1>$_ctty 2>&1
+        fi
     else
         exec /lib/systemd/systemd-shutdown "$@"
         warn "Shutdown has failed. To debug this issue add \"rdshell\" to the kernel command line."
-- 
1.7.1
