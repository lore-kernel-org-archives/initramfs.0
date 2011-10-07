From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 3/4] fs-lib: add ability to choose fsck tools
Date: Fri,  7 Oct 2011 22:23:51 +0200
Message-ID: <1318019032-12787-3-git-send-email-soltys@ziu.info>
References: <4E86385C.6040706@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E86385C.6040706-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

in dracut.conf:

fscks="<tools>"
nofscks="yes"

and similary on command line:

--fscks [LIST] (in addition to conf's, if defined there)
--nofscks

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut                             |   13 ++++++++++++-
 dracut.conf                        |    9 +++++++++
 modules.d/99fs-lib/fs-lib.sh       |    6 +++---
 modules.d/99fs-lib/module-setup.sh |   23 ++++++++++++++++-------
 4 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/dracut b/dracut
index c9329bd..9da1554 100755
--- a/dracut
+++ b/dracut
@@ -59,6 +59,8 @@ Creates initial ramdisk images for preloading modules
   --nomdadmconf         Do not include local /etc/mdadm.conf
   --lvmconf             Include local /etc/lvm/lvm.conf
   --nolvmconf           Do not include local /etc/lvm/lvm.conf
+  --fscks [LIST]        Add a space-separated list of fsck helpers.
+  --nofscks             Inhibit installation of any fsck helpers.
   -h, --help            This message
   --debug               Output debug information of the build process
   --profile             Output profile information of the build process
@@ -204,6 +206,8 @@ while (($# > 0)); do
         --filesystems) push_arg filesystems_l        "$@" || shift;;
         -I|--install)  push_arg install_items        "$@" || shift;;
         --fwdir)       push_arg fw_dir_l             "$@" || shift;;
+        --fscks)       push_arg fscks_l              "$@" || shift;;
+        --nofscks)     nofscks_l="yes";;
         -k|--kmoddir)  read_arg drivers_dir_l        "$@" || shift;;
         -c|--conf)     read_arg conffile             "$@" || shift;;
         --confdir)     read_arg confdir              "$@" || shift;;
@@ -324,6 +328,12 @@ if (( ${#add_drivers_l[@]} )); then
     done
 fi
 
+if (( ${#fscks_l[@]} )); then
+    while pop fscks_l val; do
+        fscks+=" $val "
+    done
+fi
+
 # these options override the stuff in the config file
 if (( ${#dracutmodules_l[@]} )); then
     dracutmodules=''
@@ -379,6 +389,7 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 [[ $do_strip ]] || do_strip=no
 [[ $compress_l ]] && compress=$compress_l
 [[ $show_modules_l ]] && show_modules=$show_modules_l
+[[ $nofscks_l ]] && nofscks="yes"
 # eliminate IFS hackery when messing with fw_dir
 fw_dir=${fw_dir//:/ }
 
@@ -484,7 +495,7 @@ chmod 755 "$initdir"
 export initdir dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug no_kernel kernel_only \
     add_drivers mdadmconf lvmconf filesystems \
-    use_fstab libdir usrlibdir \
+    use_fstab libdir usrlibdir fscks nofscks \
     stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
     debug
 
diff --git a/dracut.conf b/dracut.conf
index 8684328..a502066 100644
--- a/dracut.conf
+++ b/dracut.conf
@@ -29,3 +29,12 @@ mdadmconf="yes"
 
 # install local /etc/lvm/lvm.conf
 lvmconf="yes"
+
+# A list of fsck tools to install. If it's not specified, module's hardcoded
+# default is used, currently: "umount mount /sbin/fsck* xfs_db xfs_check
+# xfs_repair e2fsck jfs_fsck reiserfsck btrfsck". The installation is
+# opportunistic, so non-existing tools are just ignored.
+#fscks=""
+
+# inhibit installation of any fsck tools
+#nofscks="yes"
diff --git a/modules.d/99fs-lib/fs-lib.sh b/modules.d/99fs-lib/fs-lib.sh
index f36299a..772d5c0 100755
--- a/modules.d/99fs-lib/fs-lib.sh
+++ b/modules.d/99fs-lib/fs-lib.sh
@@ -177,7 +177,7 @@ fsck_drv_std() {
 # returns 255 if filesystem wasn't checked at all (e.g. due to lack of
 # necessary tools or insufficient options)
 fsck_single() {
-    local FSTAB_FILE=/etc/fstab.fslib
+    local FSTAB_FILE=/etc/fstab.empty
     local _dev="$1"
     local _fs="${2:-auto}"
     local _fop="$3"
@@ -197,13 +197,13 @@ fsck_single() {
 # takes list of filesystems to check in parallel; we don't rely on automatic
 # checking based on fstab, so empty one is passed
 fsck_batch() {
-    local FSTAB_FILE=/etc/fstab.fslib
+    local FSTAB_FILE=/etc/fstab.empty
     local _drv=fsck
     local _dev
     local _ret
     local _out
 
-    [ $# -eq 0 ] && return 255
+    [ $# -eq 0 ] || ! type fsck >/dev/null 2>&1 && return 255
 
     info "Checking filesystems (fsck -M -T -a):"
     for _dev in "$@"; do
diff --git a/modules.d/99fs-lib/module-setup.sh b/modules.d/99fs-lib/module-setup.sh
index cbf69a5..68ea9b1 100755
--- a/modules.d/99fs-lib/module-setup.sh
+++ b/modules.d/99fs-lib/module-setup.sh
@@ -11,13 +11,22 @@ depends() {
 }
 
 install() {
-    dracut_install -o umount mount xfs_db xfs_check xfs_repair
-    dracut_install -o e2fsck
-    dracut_install -o jfs_fsck
-    dracut_install -o reiserfsck
-    dracut_install -o btrfsck
-    dracut_install -o /sbin/fsck*
+    local _helpers
 
     inst "$moddir/fs-lib.sh" "/lib/fs-lib.sh"
-    touch ${initdir}/etc/fstab.fslib
+    touch ${initdir}/etc/fstab.empty
+
+    [[ "$nofscks" = "yes" ]] && return
+
+    if [[ "$fscks" = "${fscks#*[^ ]*}" ]]; then
+        _helpers="\
+            umount mount /sbin/fsck*
+            xfs_db xfs_check xfs_repair
+            e2fsck jfs_fsck reiserfsck btrfsck
+        "
+    else
+        _helpers="$fscks"
+    fi
+
+    dracut_install -o $_helpers
 }
-- 
1.7.5.3
