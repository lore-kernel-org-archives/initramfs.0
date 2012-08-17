From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 2/3] Add for_each_host_dev for device only checking
Date: Fri, 17 Aug 2012 20:35:21 +0800
Message-ID: <20120817123905.206266546@redhat.com>
References: <20120817123519.082687047@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=0816-2-add-for-each-dev.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

For lvm, multipath, iscsi modules they do not care about the filesystem,
Also there could be devcie in host_devs but it does not get formated.

For these kind of modules, use for_each_host_dev will be better than use
for_each_host_dev_fs, here add a new function to iterate the host_devs.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh                   |   15 +++++++++++++++
 modules.d/90lvm/module-setup.sh       |    2 +-
 modules.d/90multipath/module-setup.sh |    2 +-
 modules.d/95iscsi/module-setup.sh     |    2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

--- dracut.orig/dracut-functions.sh
+++ dracut/dracut-functions.sh
@@ -387,6 +387,21 @@ find_mp_fstype() {
 # finds the major:minor of the block device backing the root filesystem.
 find_root_block_device() { find_block_device /; }
 
+# for_each_host_dev <func>
+# Execute "<func> <dev>" for every "<dev>" found
+# in ${host_devs[@]}
+for_each_host_dev()
+{
+    local _func="$1"
+    local _dev
+    local _ret=1
+    for _dev in ${host_devs[@]}; do
+        [[ -b "$_dev" ]] || continue
+        $_func $_dev && _ret=0
+    done
+    return $_ret
+}
+
 # for_each_host_dev_fs <func>
 # Execute "<func> <dev> <filesystem>" for every "<dev>|<fs>" pair found
 # in ${host_fs_types[@]}
--- dracut.orig/modules.d/90lvm/module-setup.sh
+++ dracut/modules.d/90lvm/module-setup.sh
@@ -22,7 +22,7 @@ check() {
     }
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
-        for_each_host_dev_fs check_lvm || return 1
+        for_each_host_dev check_lvm || return 1
     }
 
     return 0
--- dracut.orig/modules.d/90multipath/module-setup.sh
+++ dracut/modules.d/90multipath/module-setup.sh
@@ -16,7 +16,7 @@ check() {
     }
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
-        for_each_host_dev_fs is_mpath || return 1
+        for_each_host_dev is_mpath || return 1
     }
 
     return 0
--- dracut.orig/modules.d/95iscsi/module-setup.sh
+++ dracut/modules.d/95iscsi/module-setup.sh
@@ -23,7 +23,7 @@ check() {
     )
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
-        for_each_host_dev_fs is_iscsi || return 1
+        for_each_host_dev is_iscsi || return 1
     }
     return 0
 }
