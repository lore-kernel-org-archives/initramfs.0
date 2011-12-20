From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/6] Allow to add mount points even not in hostonly mode
Date: Tue, 20 Dec 2011 14:09:56 +0800
Message-ID: <1324361401-6908-2-git-send-email-amwang@redhat.com>
References: <1324361401-6908-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1324361401-6908-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Don't force --mount only working in hostonly mode, let users decide.
With this patch, people can still combine -H --mount '...' if they
want to use it in hostonly mode.

Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut |   77 +++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/dracut b/dracut
index 8449fc1..3a7c4fe 100755
--- a/dracut
+++ b/dracut
@@ -525,40 +525,25 @@ trap 'exit 1;' SIGINT
 # Need to be able to have non-root users read stuff (rpcbind etc)
 chmod 755 "$initdir"
 
+for line in "${fstab_lines[@]}"; do
+    set -- $line
+    #dev mp fs fsopts
+    dev="$(get_maj_min $1)"
+    push host_devs "${dev:-$1}"
+    push host_fs_types "$dev|$3"
+done
+
+for f in $add_fstab; do
+    [ -e $f ] || continue
+    while read dev rest; do
+        push host_devs $dev
+    done < $f
+done
+
 if [[ $hostonly ]]; then
     # in hostonly mode, determine all devices, which have to be accessed
     # and examine them for filesystem types
 
-    unset host_fs_types
-
-    _get_fs_type() (
-        [[ $1 ]] || return
-        if [[ -b /dev/block/$1 ]] && get_fs_env /dev/block/$1; then
-            echo "$1|$ID_FS_TYPE"
-            return 1
-        fi
-        if fstype=$(find_dev_fstype $1); then
-            echo "$1|$fstype"
-            return 1
-        fi
-        return 1
-    )
-
-    for line in "${fstab_lines[@]}"; do
-        set -- $line
-        #dev mp fs fsopts
-        dev="$(get_maj_min $1)"
-        push host_devs "${dev:-$1}"
-        push host_fs_types "$dev|$3"
-    done
-
-    for f in $add_fstab; do
-        [ -e $f ] || continue
-        while read dev rest; do
-            push host_devs $dev
-        done < $f
-    done
-
     push host_mp \
         "/" \
         "/etc" \
@@ -573,17 +558,31 @@ if [[ $hostonly ]]; then
         mountpoint "$mp" >/dev/null 2>&1 || continue
         push host_devs $(find_block_device "$mp")
     done
-    for dev in "${host_devs[@]}"; do
-        unset fs_type
-        for fstype in $(_get_fs_type $dev) \
-            $(check_block_and_slaves _get_fs_type $dev); do
-            if ! strstr " ${host_fs_types[*]} " " $fstype ";then
-                push host_fs_types "$fstype"
-            fi
-        done
-    done
 fi
 
+_get_fs_type() (
+    [[ $1 ]] || return
+    if [[ -b /dev/block/$1 ]] && get_fs_env /dev/block/$1; then
+        echo "$1|$ID_FS_TYPE"
+        return 1
+    fi
+    if fstype=$(find_dev_fstype $1); then
+        echo "$1|$fstype"
+        return 1
+    fi
+    return 1
+)
+
+for dev in "${host_devs[@]}"; do
+    unset fs_type
+    for fstype in $(_get_fs_type $dev) \
+        $(check_block_and_slaves _get_fs_type $dev); do
+        if ! strstr " ${host_fs_types[*]} " " $fstype ";then
+            push host_fs_types "$fstype"
+        fi
+    done
+done
+
 export initdir dracutbasedir dracutmodules drivers \
     fw_dir drivers_dir debug no_kernel kernel_only \
     add_drivers mdadmconf lvmconf filesystems \
-- 
1.7.7.4
