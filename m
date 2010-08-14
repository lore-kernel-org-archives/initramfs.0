From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/16] Trivial cleanups in dracut-functions
Date: Sat, 14 Aug 2010 14:23:24 -0500 (CDT)
Message-ID: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id:from
         :subject:to:x-mailer:date;
        bh=Xic5P+mK7zf9NmA4to3+iP4OAemIH6uS1YPJeqW9JBs=;
        b=D4wDrE+L3TG6efaw70UsqeosqYHWbolw9dBgQQERzT+tC+451n1F/JbtcyuUzEyQ4K
         cJ0fgw89cf8aKi3zummZr9CYtsalqWAQeTfj/DL3mmGJWnkPlKqfwMCJMnexMEhyfBbe
         wpLGvwKIqlX9ekjq8Tqat/BmpucOOCvmYcXqY=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a patch series I have been playing with for awhile.

It cleans up some of the dracut code and adds a PKGBUILD file to make
it easier to use in Arch Linux.

---
 dracut-functions |   57 +++++++++++++++++++----------------------------------
 1 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 56ebd88..f2b7ffb 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -168,7 +168,7 @@ check_block_and_slaves() {
     [[ -b /dev/block/$2 ]] || return 1 # Not a block device? So sorry.
     "$1" $2 && return
     check_vol_slaves "$@" && return 0
-    if [[ -f "/sys/dev/block/$2/../dev" ]]; then
+    if [[ -f /sys/dev/block/$2/../dev ]]; then
 	check_block_and_slaves $1 $(cat "/sys/dev/block/$2/../dev") &&  return 0
     fi
     [[ -d /sys/dev/block/$2/slaves ]] || return 1
@@ -214,22 +214,22 @@ check_vol_slaves() {
 # and a symlink ${initdir}/lib -> lib64.
 inst_dir() {
     local dir="$1"
-    [[ -e "${initdir}$dir" ]] && return 0
+    [[ -e ${initdir}$dir ]] && return 0
 
     # iterate over parent directories
     local file=""
     local IFS="/"
     for part in $dir; do
-        [ -z "$part" ] && continue
+        [[ $part ]] || continue
         file="$file/$part"
-        [[ -e "${initdir}$file" ]] && continue
+        [[ -e ${initdir}$file ]] && continue
 
-        if [ -L "$file" ]; then
+        if [[ -L $file ]]; then
             # create link as the original
             local target=$(readlink "$file")
             ln -sfn "$target" "${initdir}$file" || return 1
             # resolve relative path and recursively install destionation
-            [[ "$target" = "${target##*/}" ]] && target="${file%/*}/$target"
+            [[ $target = ${target##*/} ]] && target="${file%/*}/$target"
             inst_dir "$target"
         else
             # create directory
@@ -408,18 +408,12 @@ inst_rules() {
 inst() {
     case $# in
         1) ;;
-        2)
-            [[ -z $initdir ]] && [[ -d $2 ]] && export initdir=$2
-            [[ $initdir = $2 ]] && set $1
-            ;;
-        3)
-	    [[ -z $initdir ]] && export initdir=$2 
-            set $1 $3
-            ;;
-        *)
-            derror "inst only takes 1 or 2 or 3 arguments"
-            exit 1
-            ;;
+        2) [[ ! $initdir && -d $2 ]] && export initdir=$2
+           [[ $initdir = $2 ]] && set $1;;
+        3) [[ -z $initdir ]] && export initdir=$2 
+           set $1 $3;;
+        *) derror "inst only takes 1 or 2 or 3 arguments"
+           exit 1;;
     esac
     for x in inst_symlink inst_script inst_binary inst_simple; do
        $x "$@" && return 0
@@ -537,7 +531,7 @@ should_source_module() {
         [[ -x $1/installkernel ]] && return 0
         return 1
     fi
-    [[ -x $1/install ]] || [[ -x $1/installkernel ]] || return 1
+    [[ -x $1/install || -x $1/installkernel ]] || return 1
     [[ -x $1/check ]] || return 0
     "$1/check" $hostonly || continue
     for dep in $("$1/check" -d); do
@@ -642,14 +636,10 @@ filter_kernel_modules () (
     fi
     for modname in $(eval $filtercmd); do
         case $modname in
-            *.ko)
-                "$1" "$modname" && echo "$modname"
-                ;;
-            *.ko.gz)
-                gzip -dc "$modname" > $initdir/$$.ko
-                $1 $initdir/$$.ko && echo "$modname"
-                rm -f $initdir/$$.ko
-                ;;
+            *.ko) "$1" "$modname" && echo "$modname";;
+            *.ko.gz) gzip -dc "$modname" > $initdir/$$.ko
+                     $1 $initdir/$$.ko && echo "$modname"
+                     rm -f $initdir/$$.ko;;
         esac
     done
 )
@@ -671,15 +661,10 @@ instmods() {
 		    instmods $mpargs $(find "$srcmods" -path "*/${mod#=}/*")
 		fi
 		;;
-	    --*) 
-	        mod=${mod##*/}
-                mpargs+=" $mod";;
-            i2o_scsi)
-                    # Must never run this diagnostic-only module
-                    shift; continue;
-                ;;
-	    *)  
-	        mod=${mod##*/}
+	    --*) mod=${mod##*/}
+                 mpargs+=" $mod";;
+            i2o_scsi) shift; continue;; # Do not load this diagnostic-only module
+	    *)  mod=${mod##*/}
                 # if we are already installed, skip this module and go on
 	        # to the next one.
 	        [[ -f $initdir/$1 ]] && { shift; continue; }
-- 
1.7.2.1
