From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 11/16] Bashify mkinitrd-dracut.sh, introduce read_arg.
Date: Sat, 14 Aug 2010 14:23:26 -0500 (CDT)
Message-ID: <3162d968da6382ef35c566c81d8518bd68f9da6a.1281812506.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=Wk7uv/givsAa4YQ2bfjPDMbK2hdhLNPFSk1RvOzHfd4=;
        b=CJwRy3vL+W2Td/qsNLvLTi4IdghXuY7YruYUdBy5EcnMStp6hsAwxw/8+6VU5GFXap
         fjl0slkTUsOBxpmuFYs1CkjgUuricQ0PEMiMWGeEP+yLl0rG5P/vbL2QBA76bD5jNEQA
         WMsj8lZNWsZW+OKFCeEQVSAVw2Ch5m7fNCvD0=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hack up argument processing in dracut and mkinitrd-dracut.sh to use
read_arg to flexibly process arguments.

---
 dracut             |   50 ++++++++----
 mkinitrd-dracut.sh |  240 ++++++++++++++++++++++------------------------------
 2 files changed, 137 insertions(+), 153 deletions(-)

diff --git a/dracut b/dracut
index 1242f42..1a30cc7 100755
--- a/dracut
+++ b/dracut
@@ -89,23 +89,41 @@ Creates initial ramdisk images for preloading modules
 "
 }
 
+# Little helper function for reading args from the commandline.
+# it automatically handles -a b and -a=b variants, and returns 1 if
+# we need to shift $3.
+read_arg() {
+    # $1 = arg name
+    # $2 = arg value
+    # $3 = arg parameter
+    local rematch='^[^=]*=(.*)$'
+    if [[ $2 =~ $rematch ]]; then
+	read "$1" <<< "${BASH_REMATCH[1]}"
+    else
+	read "$1" <<< "$3"
+	# There is no way to shift our callers args, so
+	# return 1 to indicate they should do it instead.
+	return 1
+    fi
+}
+
 while (($# > 0)); do
-    case $1 in
+    case ${1%%=*} in
 	-f|--force) force=yes;;
-	-m|--modules) dracutmodules_l="$dracutmodules_l $2"; shift;;
-	-o|--omit) omit_dracutmodules_l="$omit_dracutmodules_l $2"; shift;;
-	-a|--add) add_dracutmodules_l="$add_dracutmodules_l $2"; shift;;
-	-d|--drivers) drivers_l="$drivers_l $2"; shift;;
-	--add-drivers) add_drivers_l="$add_drivers_l $2"; shift;;
-	--filesystems) filesystems_l="$filesystems_l $2"; shift;;
-	-k|--kmoddir) drivers_dir_l="$2"; shift;;
-	--fwdir) fw_dir_l="$fw_dir_l:$2"; shift;;
+	-m|--modules) read_arg dracutmodules_l "$@" ||shift;;
+	-o|--omit) read_arg omit_dracutmodules_l "$@" || shift;;
+	-a|--add) read_arg add_dracutmodules_l "$@" || shift;;
+	-d|--drivers) read_arg drivers_l "$@" || shift;;
+	--add-drivers) read_arg add_drivers_l "$@" || shift;;
+	--filesystems) read_arg filesystems_l "$@" || shift;;
+	-k|--kmoddir) read_arg drivers_dir_l "$@" || shift;;
+	--fwdir) read_arg fw_dir_l "$@" || shift;;
 	--kernel-only) kernel_only="yes"; no_kernel="no";;
 	--no-kernel) kernel_only="no"; no_kernel="yes";;
-    --ignore-kernel-modules) kernel_only="no"; no_kernel="yes"
-        ignore_kmodules="yes"
-        omit_dracutmodules_l+=\ kernel-modules
-        ;;
+        --ignore-kernel-modules) kernel_only="no"; no_kernel="yes"
+            ignore_kmodules="yes"
+            omit_dracutmodules_l+=\ kernel-modules
+            ;;
 	--strip) do_strip_l="yes";;
 	--nostrip) do_strip_l="no";;
         --mdadmconf) mdadmconf_l="yes";;
@@ -115,13 +133,13 @@ while (($# > 0)); do
 	-h|--help) usage; exit 1 ;;
 	--debug) debug="yes";;
 	-v|--verbose) beverbose="yes";;
-	-c|--conf) conffile="$2"; shift;;
-	--confdir) confdir="$2"; shift;;
+	-c|--conf) read_arg conffile "$@" || shift;;
+	--confdir) read_arg confdir "$@" || shift;;
 	-l|--local) allowlocal="yes" ;;
 	-H|--hostonly) hostonly_l="yes" ;;
 	--fstab) use_fstab_l="yes" ;;
 	-i|--include) include_src="$2"; include_target="$3"; shift 2;;
-	-I|--install) install_items="$2"; shift;;
+	-I|--install) read_arg install_items "$@" || shift;;
         --gzip) [[ $compress != cat ]] && compress="gzip -9";;
         --bzip2) [[$compress != cat ]] && compress="bzip2 -9";;
         --xz) [[ $compress != cat ]] && compress="xz -9";;
diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
dissimilarity index 61%
index 3943dad..f25ccb9 100644
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -1,137 +1,103 @@
-#!/bin/bash --norc
-kver=$(uname -r)
-
-error() { echo "$@" >&2; }
-
-usage () {
-    [[ $1 = '-n' ]] && cmd=echo || cmd=error
-
-    $cmd "usage: ${0%/*} [--version] [--help] [-v] [-f] [--preload <module>]"
-    $cmd "       [--image-version] [--with=<module>]"
-    $cmd "       <initrd-image> <kernel-version>"
-    $cmd ""
-    $cmd "       (ex: ${0%/*} /boot/initramfs-$kver.img $kver)"
-
-    [[ $1 = '-n' ]] && exit 0
-    exit 1
-}
-
-
-while [ $# -gt 0 ]; do
-    case $1 in
-        --with-usb*)
-            if [ "$1" != "${1##--with-usb=}" ]; then
-                usbmodule=${1##--with-usb=}
-            else
-                usbmodule="usb-storage"
-            fi
-            basicmodules="$basicmodules $usbmodule"
-            unset usbmodule
-            ;;
-        --with-avail*)
-            if [ "$1" != "${1##--with-avail=}" ]; then
-                modname=${1##--with-avail=}
-            else
-                modname=$2
-                shift
-            fi
-
-            basicmodules="$basicmodules $modname"
-            ;;
-        --with*)
-            if [ "$1" != "${1##--with=}" ]; then
-                modname=${1##--with=}
-            else
-                modname=$2
-                shift
-            fi
-
-            basicmodules="$basicmodules $modname"
-            ;;
-        --version)
-            echo "mkinitrd: dracut compatibility wrapper"
-            exit 0
-            ;;
-        -v|--verbose)
-            dracut_args="${dracut_args} -v"
-            ;;
-        -f)
-            dracut_args="${dracut_args} -f"
-            ;;
-        --preload*)
-            if [ "$1" != "${1##--preload=}" ]; then
-                modname=${1##--preload=}
-            else
-                modname=$2
-                shift
-            fi
-            basicmodules="$basicmodules $modname"
-            ;;
-        --image-version)
-            img_vers=yes
-            ;;
-	--rootfs*)
-            if [ "$1" != "${1##--rootfs=}" ]; then
-                rootfs="${1##--rootfs=}"
-            else
-                rootfs="$2"
-                shift
-            fi
-	    dracut_args="${dracut_args} --filesystems $rootfs"
-	    ;;
-        --builtin*) ;;
-        --without*) ;;
-        --without-usb) ;;
-        --fstab*) ;;
-        --nocompress) dracut_args="$dracut_args --no-compress";;
-        --ifneeded) ;;
-        --omit-scsi-modules) ;;
-        --omit-ide-modules) ;;
-        --omit-raid-modules) ;;
-        --omit-lvm-modules) ;;
-        --omit-dmraid) ;;
-        --allow-missing) ;;
-        --net-dev*) ;;
-        --noresume) ;;
-	--rootdev*) ;;
-	--thawdev*) ;;
-	--rootopts*) ;;
-	--root*) ;;
-	--loopdev*) ;;
-	--loopfs*) ;;
-	--loopopts*) ;;
-	--looppath*) ;;
-	--dsdt*) ;;
-        --bootchart) ;;
-        --help)
-            usage -n
-            ;;
-        *)
-            if [ -z "$target" ]; then
-                target=$1
-            elif [ -z "$kernel" ]; then
-                kernel=$1
-            else
-                usage
-            fi
-            ;;
-    esac
-
-    shift
-done
-
-if [ -z "$target" -o -z "$kernel" ]; then
-    usage
-fi
-
-if [ -n "$img_vers" ]; then
-    target="$target-$kernel"
-fi
-
-if [ -n "$basicmodules" ]; then
-	dracut -H $dracut_args --add-drivers "$basicmodules" "$target" "$kernel"
-else
-	dracut -H $dracut_args "$target" "$kernel"
-fi
-
-# vim:ts=8:sw=4:sts=4:et
+#!/bin/bash --norc
+kver=$(uname -r)
+
+error() { echo "$@" >&2; }
+
+usage () {
+    [[ $1 = '-n' ]] && cmd=echo || cmd=error
+
+    $cmd "usage: ${0%/*} [--version] [--help] [-v] [-f] [--preload <module>]"
+    $cmd "       [--image-version] [--with=<module>]"
+    $cmd "       <initrd-image> <kernel-version>"
+    $cmd ""
+    $cmd "       (ex: ${0%/*} /boot/initramfs-$kver.img $kver)"
+
+    [[ $1 = '-n' ]] && exit 0
+    exit 1
+}
+
+# Little helper function for reading args from the commandline.
+# it automatically handles -a b and -a=b variants, and returns 1 if
+# we need to shift $3.
+read_arg() {
+    # $1 = arg name
+    # $2 = arg value
+    # $3 = arg parameter
+    local rematch='^[^=]*=(.*)$'
+    if [[ $2 =~ $rematch ]]; then
+	read "$1" <<< "${BASH_REMATCH[1]}"
+    elif [[ $3 != -* ]]; then
+        # Only read next arg if it not an arg itself.
+	read "$1" <<< "$3"
+	# There is no way to shift our callers args, so
+	# return 1 to indicate they should do it instead.
+	return 1
+    fi
+}
+
+while (($# > 0)); do
+    case ${1%%=*} in
+        --with-usb) read_arg usbmodule "$@" || shift
+            basicmodules="$basicmodules ${usbmodule:-usb-storage}"
+            unset usbmodule;;
+        --with-avail) read_arg modname "$@" || shift
+            basicmodules="$basicmodules $modname";;
+        --with) read_arg modname "$@" || shift
+            basicmodules="$basicmodules $modname";;
+        --version)
+            echo "mkinitrd: dracut compatibility wrapper"
+            exit 0;;
+        -v|--verbose) dracut_args="${dracut_args} -v";;
+        -f) dracut_args="${dracut_args} -f";;
+        --preload) read_args modname "$@" || shift
+            basicmodules="$basicmodules $modname";;
+        --image-version) img_vers=yes;;
+	--rootfs) read_args rootfs "$@" || shift
+            dracut_args="${dracut_args} --filesystems $rootfs";;
+        --nocompress) dracut_args="$dracut_args --no-compress";;
+        --help) usage -n;;
+        --builtin) ;;
+        --without*) ;;
+        --without-usb) ;;
+        --fstab*) ;;
+        --ifneeded) ;;
+        --omit-scsi-modules) ;;
+        --omit-ide-modules) ;;
+        --omit-raid-modules) ;;
+        --omit-lvm-modules) ;;
+        --omit-dmraid) ;;
+        --allow-missing) ;;
+        --net-dev*) ;;
+        --noresume) ;;
+	--rootdev*) ;;
+	--thawdev*) ;;
+	--rootopts*) ;;
+	--root*) ;;
+	--loopdev*) ;;
+	--loopfs*) ;;
+	--loopopts*) ;;
+	--looppath*) ;;
+	--dsdt*) ;;
+        --bootchart) ;;
+        *) if [[ ! $target ]]; then
+            target=$1
+            elif [[ ! $kernel ]]; then
+            kernel=$1
+            else
+            usage
+            fi;;
+    esac
+    shift
+done
+
+[[ $target && $kernel ]] || usage
+[[ $img_vers ]] && target="$target-$kernel"
+fi
+
+if [[ $basicmodules ]]; then
+	dracut -H $dracut_args --add-drivers "$basicmodules" "$target" "$kernel"
+else
+	dracut -H $dracut_args "$target" "$kernel"
+fi
+
+# vim:ts=8:sw=4:sts=4:et
-- 
1.7.2.1
