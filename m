From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch v2 2/3] Add for_each_host_dev_and_slaves for device only checking
Date: Thu, 23 Aug 2012 11:02:23 +0800
Message-ID: <20120823030628.133563734@redhat.com>
References: <20120823030221.587864989@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=0816-2-add-for-each-dev-and-slave.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

For lvm, multipath, iscsi modules they do not care about the filesystem,
Also there could be devcie in host_devs but it does not get formated.

For these kind of modules, use for_each_host_dev_and_slaves will be better than use
for_each_host_dev_fs, here add a new function to iterate the host_devs and
their slave devices.

In original for_each_host_dev_fs, it will call check_block_and_slaves which
will return once helper function return 0, but this is not enough for kdump
iscsi setup. For kdump iscsi case, it need setup each slave devices so that
the iscsi target can be properly setuped in initramfs.

Thus, this patch also add new functions check_block_and_slaves_all and
for_each_host_dev_and_slaves_all.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Tested-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh                   |   48 +++++++++++++++++++++++++++++++++-
 modules.d/90lvm/module-setup.sh       |    4 +-
 modules.d/90multipath/module-setup.sh |    5 +--
 modules.d/95iscsi/module-setup.sh     |    5 +--
 4 files changed, 53 insertions(+), 9 deletions(-)

--- dracut.orig/dracut-functions.sh
+++ dracut/dracut-functions.sh
@@ -383,7 +383,6 @@ find_mp_fstype() {
     return 1
 }
 
-
 # finds the major:minor of the block device backing the root filesystem.
 find_root_block_device() { find_block_device /; }
 
@@ -429,6 +428,53 @@ check_block_and_slaves() {
     return 1
 }
 
+check_block_and_slaves_all() {
+    local _x _ret=1
+    [[ -b /dev/block/$2 ]] || return 1 # Not a block device? So sorry.
+    if "$1" $2; then
+          _ret=0
+    fi
+    check_vol_slaves "$@" && return 0
+    if [[ -f /sys/dev/block/$2/../dev ]]; then
+        check_block_and_slaves_all $1 $(cat "/sys/dev/block/$2/../dev") && _ret=0
+    fi
+    [[ -d /sys/dev/block/$2/slaves ]] || return 1
+    for _x in /sys/dev/block/$2/slaves/*/dev; do
+        [[ -f $_x ]] || continue
+        check_block_and_slaves_all $1 $(cat "$_x") && _ret=0
+    done
+    return $_ret
+}
+# for_each_host_dev_and_slaves <func>
+# Execute "<func> <dev>" for every "<dev>" found
+# in ${host_devs[@]} and their slaves
+for_each_host_dev_and_slaves_all()
+{
+    local _func="$1"
+    local _dev
+    local _ret=1
+    for _dev in ${host_devs[@]}; do
+        [[ -b "$_dev" ]] || continue
+        echo host_devs: $_dev
+        if check_block_and_slaves_all $_func $(get_maj_min $_dev); then
+               _ret=0
+        fi
+    done
+    return $_ret
+}
+
+for_each_host_dev_and_slaves()
+{
+    local _func="$1"
+    local _dev
+    for _dev in ${host_devs[@]}; do
+        [[ -b "$_dev" ]] || continue
+        echo host_devs: $_dev
+        check_block_and_slaves_all $_func $(get_maj_min $_dev) && return 0
+    done
+    return 1
+}
+
 # ugly workaround for the lvm design
 # There is no volume group device,
 # so, there are no slave devices for volume groups.
--- dracut.orig/modules.d/90lvm/module-setup.sh
+++ dracut/modules.d/90lvm/module-setup.sh
@@ -9,7 +9,7 @@ check() {
 
     check_lvm() {
         local DM_VG_NAME DM_LV_NAME DM_UDEV_DISABLE_DISK_RULES_FLAG
-        eval $(udevadm info --query=property --name=$1|egrep '(DM_VG_NAME|DM_LV_NAME|DM_UDEV_DISABLE_DISK_RULES_FLAG)=')
+        eval $(udevadm info --query=property --name=/dev/block/$1|egrep '(DM_VG_NAME|DM_LV_NAME|DM_UDEV_DISABLE_DISK_RULES_FLAG)=')
         [[ "$DM_UDEV_DISABLE_DISK_RULES_FLAG" = "1" ]] && return 1
         [[ ${DM_VG_NAME} ]] && [[ ${DM_LV_NAME} ]] || return 1
         if ! strstr " ${_activated[*]} " " ${DM_VG_NAME}/${DM_LV_NAME} "; then
@@ -22,7 +22,7 @@ check() {
     }
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
-        for_each_host_dev_fs check_lvm || return 1
+        for_each_host_dev_and_slaves check_lvm || return 1
     }
 
     return 0
--- dracut.orig/modules.d/90multipath/module-setup.sh
+++ dracut/modules.d/90multipath/module-setup.sh
@@ -8,15 +8,14 @@ check() {
     type -P multipath >/dev/null || return 1
 
     is_mpath() {
-        local _dev
-        _dev=$(get_maj_min $1)
+        local _dev=$1
         [ -e /sys/dev/block/$_dev/dm/uuid ] || return 1
         [[ $(cat /sys/dev/block/$_dev/dm/uuid) =~ mpath- ]] && return 0
         return 1
     }
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
-        for_each_host_dev_fs is_mpath || return 1
+        for_each_host_dev_and_slaves is_mpath || return 1
     }
 
     return 0
--- dracut.orig/modules.d/95iscsi/module-setup.sh
+++ dracut/modules.d/95iscsi/module-setup.sh
@@ -11,8 +11,7 @@ check() {
     # booting from root.
 
     is_iscsi() (
-        local _dev
-        _dev=$(get_maj_min $1)
+        local _dev=$1
 
         [[ -L /sys/dev/block/$_dev ]] || return
         cd "$(readlink -f /sys/dev/block/$_dev)"
@@ -23,7 +22,7 @@ check() {
     )
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
-        for_each_host_dev_fs is_iscsi || return 1
+        for_each_host_dev_and_slaves is_iscsi || return 1
     }
     return 0
 }
