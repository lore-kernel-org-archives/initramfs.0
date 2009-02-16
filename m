From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 47/50] Split out the various things we load into their own modules.
Date: Mon, 16 Feb 2009 14:07:18 -0500
Message-ID: <200902161907.n1GJ7Ixm028948@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=f4fff04ef1e985ddb7bd83b8abb2a92d9a43fac5
Commit:     f4fff04ef1e985ddb7bd83b8abb2a92d9a43fac5
Parent:     bff8c33c2bb17a7641ce664c5435f35956dbd02f
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:43:24 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 47/50] Split out the various things we load into their own modules.
    
    This should make it easier for distros to customize things according to
    their preferences.
---
 dracut                   |   55 ++++-----------------------------------------
 dracut-functions         |   27 ++++++----------------
 modules/00dash           |    6 +++++
 modules/90crypt          |    2 +
 modules/90kernel-modules |    8 ++++++
 modules/90lvm            |    2 +
 modules/95debug          |    2 +
 modules/95terminfo       |    3 ++
 modules/95udev-rules     |    8 ++++++
 modules/99base           |   13 +++++++++++
 10 files changed, 56 insertions(+), 70 deletions(-)

diff --git a/dracut b/dracut
index c8550c7..fa3aafa 100755
--- a/dracut
+++ b/dracut
@@ -8,11 +8,13 @@
 # Copyright 2008, Red Hat, Inc.  Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 # GPLv2 header here
 
+
 [ -f /etc/dracut.conf ] && . /etc/dracut.conf
 
 while (($# > 0)); do
     case $1 in
 	-f|--force) force=yes;;
+	-m|--modules) dracutmodules="$2"; shift;;
 	-h|--help) echo "Usage: $0 [-f] <initramfs> <kernel-version>"
 	    exit 1 ;;
 	-v|--verbose) set -x;;
@@ -22,6 +24,7 @@ while (($# > 0)); do
     esac
     shift
 done
+[[ $dracutmodules ]] || dracutmodules="all" 
 
 [[ $2 ]] && kernel=$2 || kernel=$(uname -r)
 [[ $1 ]] && outfile=$(readlink -f $1) || outfile="/boot/initrd-$kernel.img"
@@ -41,61 +44,13 @@ hookdirs="pre-udev pre-mount pre-pivot"
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 
+export initdir hookdirs rulesdir dsrc dracutmodules kmodules
+
 # Create some directory structure first
 for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do 
     mkdir -p "$initdir/$d"; 
 done
 
-# executables that we have to have
-exe="bash mount mknod mkdir modprobe udevd udevadm nash pidof sleep chroot echo sed"
-lvmexe="lvm"
-cryptexe="cryptsetup"
-# and some things that are nice for debugging
-debugexe="ls ln ps grep more dmesg cat"
-# udev things we care about
-udevexe="/lib/udev/vol_id /lib/udev/console_init"
-
-# install base executables
-for binary in $exe $debugexe $udevexe $lvmexe $cryptexe ; do
-  inst $binary
-done
-
-# Prefer dash as /bin/sh if it is available.
-if [[ -f /bin/dash ]]; then
-    inst /bin/dash
-    ln -sf /bin/dash "${initdir}/bin/sh"
-fi
-
-# install our scripts and hooks
-inst "$initfile" "/init"
-inst "$switchroot" "/sbin/switch_root"
-for hookdir in $hookdirs; do
-    for hook in "$dsrc/$hookdir"/*; do
-	[[ -f $hook ]] && inst "$hook" "/$hookdir/${hook##*/}"
-    done
-done
-
-# FIXME: hard-coded module list of doom.
-[[ $modules ]] || modules="=ata =block =drm dm-crypt aes sha256 cbc"
-
-instmods $modules
-
-# Grab modules for all filesystem types we currently have mounted
-while read d mp t rest; do
-    instmods "$t"
-done </proc/mounts
-
-# FIXME: would be nice if we didn't have to know which rules to grab....
-# ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
-# of the rules we want so that we just copy those in would be best
-mkdir -p "$initdir/lib/udev/rules.d"
-for rule in /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* /lib/udev/rules.d/95* $rulesdir/*.rules ; do
-  cp "$rule" "$initdir/lib/udev/rules.d"
-done
-
-# terminfo bits make things work better if you fall into interactive mode
-for f in $(find /lib/terminfo -type f) ; do cp  --parents $f "$initdir" ; done
-
 # source any third-party package provided modules
 for f in "$dsrc/modules"/*; do
     [[ -x $f ]] && . "$f"
diff --git a/dracut-functions b/dracut-functions
index a0a1906..b410034 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -32,6 +32,7 @@ inst_simple() {
     local src=$1 target="${initdir}${2:-$1}"
     [[ -f $target ]] && return 0
     mkdir -p "${target%/*}"
+    echo "Installing $src" >&2
     cp -fL "$src" "$target"
 }
 
@@ -132,6 +133,12 @@ inst() {
     return 1
 }
 
+dracut_install() {
+    while (($# > 0)); do
+	inst "$1" && shift
+    done
+}
+
 modcat="/lib/modules/$kernel/modules"
 instmods() {
     local mod mpargs modpath modname cmd
@@ -163,24 +170,4 @@ instmods() {
     done
 } 
 
-findkeymap () {
-    local MAP=$1
-    [[ ! -f $MAP ]] && \
-	MAP=$(find /lib/kbd/keymaps -type f -name $MAP -o -name $MAP.\* | head -n1)
-    [[ " $KEYMAPS " = *" $MAP "* ]] && return
-    KEYMAPS="$KEYMAPS $MAP"
-    case $MAP in
-        *.gz) cmd=zgrep;;
-        *.bz2) cmd=bzgrep;;
-        *) cmd=grep ;;
-    esac
-
-    for INCL in $($cmd "^include " $MAP | cut -d' ' -f2 | tr -d '"'); do
-        for FN in $(find /lib/kbd/keymaps -type f -name $INCL\*); do
-            findkeymap $FN
-        done
-    done
-}
-
-
 # vim:ts=8:sw=4:sts=4:et
diff --git a/modules/00dash b/modules/00dash
new file mode 100755
index 0000000..8af1e7c
--- /dev/null
+++ b/modules/00dash
@@ -0,0 +1,6 @@
+#!/bin/bash
+# Prefer dash as /bin/sh if it is available.
+if [[ -f /bin/dash ]]; then
+    inst /bin/dash
+    ln -sf /bin/dash "${initdir}/bin/sh"
+fi
\ No newline at end of file
diff --git a/modules/10redhat-i18n b/modules/10redhat-i18n
old mode 100644
new mode 100755
diff --git a/modules/90crypt b/modules/90crypt
new file mode 100755
index 0000000..e4f1876
--- /dev/null
+++ b/modules/90crypt
@@ -0,0 +1,2 @@
+#!/bin/bash
+inst cryptsetup
\ No newline at end of file
diff --git a/modules/90kernel-modules b/modules/90kernel-modules
new file mode 100755
index 0000000..8265b60
--- /dev/null
+++ b/modules/90kernel-modules
@@ -0,0 +1,8 @@
+#!/bin/bash
+# FIXME: hard-coded module list of doom.
+instmods ${modules:-=ata =block =drm dm-crypt aes sha256 cbc}
+
+# Grab modules for all filesystem types we currently have mounted
+while read d mp t rest; do
+    instmods "$t"
+done </proc/mounts
diff --git a/modules/90lvm b/modules/90lvm
new file mode 100755
index 0000000..d75062a
--- /dev/null
+++ b/modules/90lvm
@@ -0,0 +1,2 @@
+#!/bin/bash
+inst lvm
\ No newline at end of file
diff --git a/modules/95debug b/modules/95debug
new file mode 100755
index 0000000..4579212
--- /dev/null
+++ b/modules/95debug
@@ -0,0 +1,2 @@
+#!/bin/bash
+dracut_install ln ps grep more dmesg cat
\ No newline at end of file
diff --git a/modules/95terminfo b/modules/95terminfo
new file mode 100755
index 0000000..7f14aa1
--- /dev/null
+++ b/modules/95terminfo
@@ -0,0 +1,3 @@
+#!/bin/bash
+# terminfo bits make things work better if you fall into interactive mode
+dracut_install $(find /lib/terminfo -type f)
\ No newline at end of file
diff --git a/modules/95udev-rules b/modules/95udev-rules
new file mode 100755
index 0000000..50a69f8
--- /dev/null
+++ b/modules/95udev-rules
@@ -0,0 +1,8 @@
+#!/bin/bash
+# FIXME: would be nice if we didn't have to know which rules to grab....
+# ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
+# of the rules we want so that we just copy those in would be best
+mkdir -p "$initdir/lib/udev/rules.d"
+for rule in /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* /lib/udev/rules.d/95* $rulesdir/*.rules ; do
+  inst "$rule" "/lib/udev/rules.d/${rule##*/}"
+done
diff --git a/modules/99base b/modules/99base
new file mode 100755
index 0000000..c47f62b
--- /dev/null
+++ b/modules/99base
@@ -0,0 +1,13 @@
+#!/bin/bash
+dracut_install mount mknod mkdir modprobe udevd udevadm pidof sleep \
+	       chroot echo sed sh ls /lib/udev/vol_id /lib/udev/console_init
+
+# install our scripts and hooks
+inst "$initfile" "/init"
+inst "$switchroot" "/sbin/switch_root"
+for hookdir in $hookdirs; do
+    for hook in "$dsrc/$hookdir"/*; do
+	[[ -f $hook ]] && inst "$hook" "/$hookdir/${hook##*/}"
+    done
+done
+
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
