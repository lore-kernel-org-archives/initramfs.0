From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 1/3] wait host devs in base module
Date: Fri, 17 Aug 2012 20:35:20 +0800
Message-ID: <20120817123905.089958024@redhat.com>
References: <20120817123519.082687047@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=0816-1-wait-host-devs.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

each dev in host_devs[] should be waited in initqueue to make sure they
are oneline before initqueue finish.

Add a new wait_host_devs.sh in base module to make this a generic thing.
Because all the devs in fstab lines are also added to host_devs, so no need
do same wait in fstab-sys module anymore.

Chaowang: add slave devices to host_devs as well.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.sh                               |   19 +++++++++++++++++++
 modules.d/95fstab-sys/module-setup.sh   |    1 -
 modules.d/95fstab-sys/wait-mount-dev.sh |   22 ----------------------
 modules.d/99base/module-setup.sh        |    1 +
 modules.d/99base/wait-host-devs.sh      |   20 ++++++++++++++++++++
 5 files changed, 40 insertions(+), 23 deletions(-)

--- dracut.orig/dracut.sh
+++ dracut/dracut.sh
@@ -769,6 +769,20 @@ for dev in "${host_devs[@]}"; do
     done
 done
 
+_get_block_dev() {
+    echo `readlink -f /dev/block/$1`; return 1;
+}
+
+for dev in "${host_devs[@]}"; do
+    unset _dev
+    for _dev in $(check_block_and_slaves _get_block_dev $(get_maj_min $dev)); do
+       [ -b "$_dev" ] || continue
+        if ! strstr " ${host_devs[*]} " " $_dev ";then
+            push host_devs "$_dev"
+        fi
+    done
+done
+
 [[ -d $udevdir ]] \
     || udevdir=$(pkg-config udev --variable=udevdir 2>/dev/null)
 if ! [[ -d "$udevdir" ]]; then
@@ -903,6 +917,11 @@ done
 
 dinfo "*** Including modules done ***"
 
+## save host_devs which we need bring up
+for _dev in ${host_devs[@]}; do
+    echo $_dev >> $initdir/etc/host_devs
+done
+
 ## final stuff that has to happen
 if [[ $no_kernel != yes ]]; then
 
--- dracut.orig/modules.d/95fstab-sys/module-setup.sh
+++ dracut/modules.d/95fstab-sys/module-setup.sh
@@ -13,5 +13,4 @@ depends() {
 install() {
     [ -f /etc/fstab.sys ] && inst_simple /etc/fstab.sys
     inst_hook pre-pivot 00 "$moddir/mount-sys.sh"
-    inst_hook cmdline 00 "$moddir/wait-mount-dev.sh"
 }
--- dracut.orig/modules.d/95fstab-sys/wait-mount-dev.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
-# ex: ts=8 sw=4 sts=4 et filetype=sh
-
-type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
-type det_fs >/dev/null 2>&1 || . /lib/fs-lib.sh
-
-fstab_wait_dev() {
-    local _dev _mp _fs _opts _dump _pass _rest
-    test -e "$1" || return 1
-    while read _dev _mp _fs _opts _dump _pass _rest; do
-        [ -z "${_dev%%#*}" ] && continue # Skip comment lines
-        case "$_dev" in
-        /dev/?*)
-            wait_for_dev $_dev;;
-        *) ;;
-        esac
-    done < $1
-    return 0
-}
-
-[ -f /etc/fstab ] && fstab_wait_dev /etc/fstab
--- dracut.orig/modules.d/99base/module-setup.sh
+++ dracut/modules.d/99base/module-setup.sh
@@ -41,6 +41,7 @@ install() {
     dracut_install switch_root || dfatal "Failed to install switch_root"
 
     inst_simple "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
+    inst_hook cmdline 00 "$moddir/wait-host-devs.sh"
     inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
     mkdir -p "${initdir}/var"
     [ -x /lib/systemd/systemd-timestamp ] && inst /lib/systemd/systemd-timestamp
--- /dev/null
+++ dracut/modules.d/99base/wait-host-devs.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+
+wait_host_devs() {
+    local _dev
+
+    while read _dev; do
+        case "$_dev" in
+        /dev/?*)
+            wait_for_dev $_dev
+            ;;
+        *) ;;
+        esac
+    done < $1
+}
+
+[ -f /etc/host_devs ] && wait_host_devs /etc/host_devs
