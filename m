From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 30/33] dracut.sh: Avoid duplicate devices in host_devs
Date: Thu, 20 Nov 2014 15:57:05 +0100
Message-ID: <1416495428-36978-31-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index c657649..f384f73 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -219,6 +219,16 @@ push() {
     done
 }
 
+# Fills up host_devs stack variable and makes sure there are no duplicates
+push_host_devs() {
+    local _dev
+    for _dev in ${host_devs[@]}; do
+        [ "$_dev" = "$1" ] && return
+    done
+    push host_devs "$1"
+}
+
+
 # function pop()
 # pops the last value from a stack
 # assigns value to second argument variable
@@ -1062,25 +1072,25 @@ declare -A host_fs_types
 for line in "${fstab_lines[@]}"; do
     set -- $line
     #dev mp fs fsopts
-    push host_devs "$1"
+    push_host_devs "$1"
     host_fs_types["$1"]="$3"
 done
 
 for f in $add_fstab; do
     [[ -e $f ]] || continue
     while read dev rest; do
-        push host_devs "$dev"
+        push_host_devs "$dev"
     done < "$f"
 done
 
 for dev in $add_device; do
-    push host_devs "$dev"
+    push_host_devs "$dev"
 done
 
 if (( ${#add_device_l[@]} )); then
     while pop add_device_l val; do
         add_device+=" $val "
-        push host_devs "$val"
+        push_host_devs "$val"
     done
 fi
 
@@ -1109,9 +1119,9 @@ if [[ $hostonly ]]; then
         _dev=$(find_block_device "$mp")
         _bdev=$(readlink -f "/dev/block/$_dev")
         [[ -b $_bdev ]] && _dev=$_bdev
-        push host_devs $_dev
+        push_host_devs $_dev
         [[ "$mp" == "/" ]] && root_dev="$_dev"
-        push host_devs "$_dev"
+        push_host_devs "$_dev"
     done
 
     if [[ -f /proc/swaps ]] && [[ -f /etc/fstab ]]; then
@@ -1140,7 +1150,7 @@ if [[ $hostonly ]]; then
                     done < /etc/crypttab
                 fi
 
-                push host_devs "$(readlink -f "$dev")"
+                push_host_devs "$(readlink -f "$dev")"
                 break
             done < /etc/fstab
         done < /proc/swaps
@@ -1205,7 +1215,7 @@ for dev in "${!host_fs_types[@]}"; do
     fi
     if [[ $journaldev ]]; then
         dev="$(readlink -f "$dev")"
-        push host_devs "$dev"
+        push_host_devs "$dev"
         _get_fs_type "$dev"
         check_block_and_slaves_all _get_fs_type "$(get_maj_min "$dev")"
     fi
-- 
1.8.5.2
