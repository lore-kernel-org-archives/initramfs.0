From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/8] filter_kernel_modules is a specialized filter_kernel_modules_by_path
Date: Tue, 30 Aug 2011 21:39:30 -0700
Message-ID: <4E5DBB02.3020803@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dracut-functions |   31 +++----------------------------
 1 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index f6ffa1d..15a75b9 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -863,34 +863,9 @@ filter_kernel_modules_by_path () (
     done
 )
-# filter kernel modules to install certain modules that meet specific
-# requirements.
-# $1 = function to call with module name to filter.
-#      This function will be passed the full path to the module to test.
-# The behaviour of this function can vary depending on whether $hostonly is set.
-# If it is, we will only look at modules that are already in memory.
-# If it is not, we will look at all kernel modules
-# This function returns the full filenames of modules that match $1
-filter_kernel_modules () (
-    local _modname _filtercmd
-    if ! [[ $hostonly ]]; then
-        _filtercmd='find "$srcmods/kernel/drivers" "$srcmods/extra"'
-        _filtercmd+=' "$srcmods/weak-updates" -name "*.ko" -o -name "*.ko.gz"'
-        _filtercmd+=' 2>/dev/null'
-    else
-        _filtercmd='cut -d " " -f 1 </proc/modules|xargs modinfo -F filename '
-        _filtercmd+='-k $kernel 2>/dev/null'
-    fi
-    for _modname in $(eval $_filtercmd); do
-        case $_modname in
-            *.ko) "$1" "$_modname" && echo "$_modname";;
-            *.ko.gz) gzip -dc "$_modname" > $initdir/$$.ko
-                $1 $initdir/$$.ko && echo "$_modname"
-                rm -f $initdir/$$.ko
-                ;;
-        esac
-    done
-)
+filter_kernel_modules () {
+    filter_kernel_modules_by_path  drivers  "$1"
+}
  # install kernel modules along with all their dependencies.
 instmods() {
-- 
1.7.6


-- 
