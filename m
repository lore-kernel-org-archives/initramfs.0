From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 3/9] dracut-functions: code formatting corrected
Date: Fri, 25 Mar 2011 15:56:46 +0100
Message-ID: <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301065012-16356-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut-functions |  151 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 80 insertions(+), 71 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 915124a..2e2e37c 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -63,7 +63,7 @@ vercmp() {
 }
 
 is_func() {
-    [[ $(type -t $1) = "function" ]] 
+    [[ $(type -t $1) = "function" ]]
 }
 
 # Function prints global variables in format name=value line by line.
@@ -112,25 +112,25 @@ get_fs_uuid() (
 # finds the major:minor of the block device backing the root filesystem.
 find_block_device() {
     local x mpt majmin dev fs misc maj min
-    if [[ $use_fstab != yes ]]; then    
+    if [[ $use_fstab != yes ]]; then
         while read x x majmin x mpt x x fs dev misc; do
             [[ $fs = nfs ]] && { echo $dev; return 0;}
             [[ $fs = nfs3 ]] && { echo $dev; return 0;}
             [[ $fs = nfs4 ]] && { echo $dev; return 0;}
             [[ $fs = btrfs ]] && {
-                ls -nLl "$dev" | { 
-                    read x x x x maj min x;
-                    maj=${maj//,/}; 
-                    echo $maj:$min; 
+                ls -nLl "$dev" | {
+                    read x x x x maj min x
+                    maj=${maj//,/}
+                    echo $maj:$min
                 } && return 0
             }
             if [[ $mpt = $1 ]] && [[ ${majmin#0:} = $majmin ]]; then
-                echo $majmin; 
+                echo $majmin
                 return 0 # we have a winner!
             fi
-        done < /proc/self/mountinfo       
+        done < /proc/self/mountinfo
     fi
-    # fall back to /etc/fstab    
+    # fall back to /etc/fstab
     while read dev mpt fs misc; do
         if [[ $mpt = $1 ]]; then
             [[ $fs = nfs ]] && { echo $dev; return 0;}
@@ -139,14 +139,15 @@ find_block_device() {
             [[ $dev != ${dev#UUID=} ]] && dev=/dev/disk/by-uuid/${dev#UUID=}
             [[ $dev != ${dev#LABEL=} ]] && dev=/dev/disk/by-label/${dev#LABEL=}
             [[ -b $dev ]] || return 1 # oops, not a block device.
-            ls -nLl "$dev" | { 
-                read x x x x maj min x;
-                maj=${maj//,/}; 
-                echo $maj:$min; 
+            ls -nLl "$dev" | {
+                read x x x x maj min x
+                maj=${maj//,/}
+                echo $maj:$min
             } && return 0
         fi
     done < /etc/fstab
-    return 1;
+
+    return 1
 }
 
 find_root_block_device() { find_block_device /; }
@@ -155,24 +156,24 @@ find_root_block_device() { find_block_device /; }
 # Stop when our helper function returns success
 # $1 = function to call on every found block device
 # $2 = block device in major:minor format
-check_block_and_slaves() {    
-    local x 
+check_block_and_slaves() {
+    local x
     [[ -b /dev/block/$2 ]] || return 1 # Not a block device? So sorry.
     "$1" $2 && return
     check_vol_slaves "$@" && return 0
     if [[ -f /sys/dev/block/$2/../dev ]]; then
-        check_block_and_slaves $1 $(cat "/sys/dev/block/$2/../dev") &&  return 0
+        check_block_and_slaves $1 $(cat "/sys/dev/block/$2/../dev") && return 0
     fi
     [[ -d /sys/dev/block/$2/slaves ]] || return 1
     for x in /sys/dev/block/$2/slaves/*/dev; do
         [[ -f $x ]] || continue
-        check_block_and_slaves $1 $(cat "$x") &&  return 0
+        check_block_and_slaves $1 $(cat "$x") && return 0
     done
     return 1
 }
 
 get_numeric_dev() {
-    ls -lH "$1" | { read a b c d maj min rest; printf "%d:%d" ${maj%%,} $min;}
+    ls -lH "$1" | { read a b c d maj min rest; printf "%d:%d" ${maj%%,} $min; }
 }
 
 # ugly workaround for the lvm design
@@ -182,17 +183,16 @@ get_numeric_dev() {
 # but you cannot create the logical volume without the volume group.
 # And the volume group might be bigger than the devices the LV needs.
 check_vol_slaves() {
-    for i in /dev/mapper/*; do 
+    for i in /dev/mapper/*; do
         lv=$(get_numeric_dev $i)
         if [[ $lv = $2 ]]; then
             vg=$(lvm lvs --noheadings -o vg_name $i 2>/dev/null)
             # strip space
             vg=$(echo $vg)
             if [[ $vg ]]; then
-                for pv in $(lvm vgs --noheadings -o pv_name "$vg" 2>/dev/null); \
-                    do
-                    check_block_and_slaves $1 $(get_numeric_dev $pv) \
-                        &&  return 0
+                for pv in $(lvm vgs --noheadings -o pv_name "$vg" 2>/dev/null)
+                do
+                    check_block_and_slaves $1 $(get_numeric_dev $pv) && return 0
                 done
             fi
         fi
@@ -221,7 +221,7 @@ inst_dir() {
             local target=$(readlink "$file")
             ln -sfn "$target" "${initdir}$file" || return 1
             # resolve relative path and recursively install destination
-            [[ $target == ${target#/} ]] && target=$(dirname "$file")/$target
+            [[ $target == ${target#/} ]] && target="$(dirname "$file")/$target"
             inst_dir "$target"
         else
             # create directory
@@ -235,7 +235,7 @@ inst_dir() {
 # Location of the image dir is assumed to be $initdir
 # We never overwrite the target if it exists.
 inst_simple() {
-    local src target 
+    local src target
     [[ -f $1 ]] || return 1
     src=$1 target="${2:-$1}"
     if ! [[ -d ${initdir}$target ]]; then
@@ -243,10 +243,10 @@ inst_simple() {
         inst_dir "${target%/*}"
     fi
     # install checksum files also
-    if [[ -e  "${src%/*}/.${src##*/}.hmac" ]]; then 
-	inst "${src%/*}/.${src##*/}.hmac" "${target%/*}/.${target##*/}.hmac"
+    if [[ -e "${src%/*}/.${src##*/}.hmac" ]]; then
+        inst "${src%/*}/.${src##*/}.hmac" "${target%/*}/.${target##*/}.hmac"
     fi
-    dinfo "Installing $src" 
+    dinfo "Installing $src"
     cp -pfL "$src" "${initdir}$target"
 }
 
@@ -272,7 +272,7 @@ rev_lib_symlinks() {
         [[ -L ${fn} && $(readlink -f "${fn}") == ${orig} ]] && links+=" ${fn}"
     done
 
-    echo ${links}
+    echo "${links}"
 }
 
 # Same as above, but specialized to handle dynamic libraries.
@@ -282,15 +282,15 @@ inst_library() {
     local src=$1 dest=${2:-$1} lib reallib symlink
     [[ -e $initdir$dest ]] && return 0
     if [[ -L $src ]]; then
-	# install checksum files also
-        if [[ -e  "${src%/*}/.${src##*/}.hmac" ]]; then 
+        # install checksum files also
+        if [[ -e "${src%/*}/.${src##*/}.hmac" ]]; then
             inst "${src%/*}/.${src##*/}.hmac" "${dest%/*}/.${dest##*/}.hmac"
         fi
-	reallib=$(readlink -f "$src")
-	lib=${src##*/}
-	inst_simple "$reallib" "$reallib"
-	inst_dir "${dest%/*}"
-	(cd "${initdir}${dest%/*}" && ln -s "$reallib" "$lib")
+        reallib=$(readlink -f "$src")
+        lib=${src##*/}
+        inst_simple "$reallib" "$reallib"
+        inst_dir "${dest%/*}"
+        (cd "${initdir}${dest%/*}" && ln -s "$reallib" "$lib")
     else
         inst_simple "$src" "$dest"
     fi
@@ -357,7 +357,7 @@ inst_binary() {
             IF_dynamic=yes
             continue
             fi
-            inst_library "$FILE" 
+            inst_library "$FILE"
     done
     inst_simple "$bin" "$target"
 }
@@ -397,14 +397,14 @@ find_rule() {
 
 # udev rules always get installed in the same place, so
 # create a function to install them to make life simpler.
-inst_rules() { 
+inst_rules() {
     local target=/etc/udev/rules.d rule found
 
     inst_dir "/lib/udev/rules.d"
     inst_dir "$target"
-    for rule in "$@"; do 
-        found=$(find_rule "$rule") && \
-            inst_simple "$found" "$target/${found##*/}" \
+    for rule in "$@"; do
+        found=$(find_rule "$rule") \
+            && inst_simple "$found" "$target/${found##*/}" \
             || dinfo "Skipping udev rule: $rule"
     done
 }
@@ -416,7 +416,7 @@ inst() {
         1) ;;
         2) [[ ! $initdir && -d $2 ]] && export initdir=$2
             [[ $initdir = $2 ]] && set $1;;
-        3) [[ -z $initdir ]] && export initdir=$2 
+        3) [[ -z $initdir ]] && export initdir=$2
             set $1 $3;;
         *) derror "inst only takes 1 or 2 or 3 arguments"
             exit 1;;
@@ -436,14 +436,14 @@ inst_hook() {
         derror "Aborting initrd creation."
         exit 1
     elif ! strstr "$hookdirs" "$1"; then
-        derror "No such hook type $1. Aborting initrd creation." 
+        derror "No such hook type $1. Aborting initrd creation."
         exit 1
     fi
     inst_simple "$3" "/${1}/${2}${3##*/}"
 }
 
 dracut_install() {
-    if [[ $1 = '-o' ]]; then 
+    if [[ $1 = '-o' ]]; then
         local optional=yes
         shift
     fi
@@ -648,9 +648,10 @@ install_kmod_with_fw() {
     local modname=${1##*/} fwdir found
     modname=${modname%.ko*}
     # no need to go further if the module is already installed
-    [[ -e  "${initdir}/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" ]] && return 0
-    inst_simple "$1" "/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" || \
-	return $? 
+    [[ -e "${initdir}/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" ]] \
+        && return 0
+    inst_simple "$1" "/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" \
+        || return $?
     for fw in $(modinfo -k $kernel -F firmware $1 2>/dev/null); do
         found=''
         for fwdir in $fw_dir; do
@@ -668,20 +669,23 @@ install_kmod_with_fw() {
 
 # Do something with all the dependencies of a kernel module.
 # Note that kernel modules depend on themselves using the technique we use
-# $1 = function to call for each dependency we find 
-#      It will be passed the full path to the found kernel module 
+# $1 = function to call for each dependency we find
+#      It will be passed the full path to the found kernel module
 # $2 = module to get dependencies for
 # rest of args = arguments to modprobe
 for_each_kmod_dep() {
-    local func=$1 kmod=$2 cmd modpapth options 
+    local func=$1 kmod=$2 cmd modpapth options
     shift 2
-    modprobe "$@" --ignore-install --show-depends $kmod 2>/dev/null | ( \
-        local found=0;
-	while read cmd modpath options; do
-	    [[ $cmd = insmod ]] || continue
-	    $func ${modpath} || exit $?
+    modprobe "$@" --ignore-install --show-depends $kmod 2>/dev/null | (
+        local found=0
+        while read cmd modpath options; do
+            [[ $cmd = insmod ]] || continue
+            $func ${modpath} || exit $?
             found=1
-        done; [[ $found -eq 0 ]] && exit 1; exit 0;)
+        done
+        [[ $found -eq 0 ]] && exit 1
+        exit 0
+    )
     return $?
 }
 
@@ -695,16 +699,20 @@ for_each_kmod_dep() {
 # This function returns the full filenames of modules that match $1
 filter_kernel_modules () (
     if ! [[ $hostonly ]]; then
-        filtercmd='find "$srcmods/kernel/drivers" "$srcmods/extra" "$srcmods/weak-updates" -name "*.ko" -o -name "*.ko.gz" 2>/dev/null'
+        filtercmd='find "$srcmods/kernel/drivers" "$srcmods/extra"'
+        filtercmd+=' "$srcmods/weak-updates" -name "*.ko" -o -name "*.ko.gz"'
+        filtercmd+=' 2>/dev/null'
     else
-        filtercmd='cut -d " " -f 1 </proc/modules|xargs modinfo -F filename -k $kernel 2>/dev/null'
+        filtercmd='cut -d " " -f 1 </proc/modules|xargs modinfo -F filename '
+        filtercmd+='-k $kernel 2>/dev/null'
     fi
     for modname in $(eval $filtercmd); do
         case $modname in
             *.ko) "$1" "$modname" && echo "$modname";;
             *.ko.gz) gzip -dc "$modname" > $initdir/$$.ko
                 $1 $initdir/$$.ko && echo "$modname"
-                rm -f $initdir/$$.ko;;
+                rm -f $initdir/$$.ko
+                ;;
         esac
     done
 )
@@ -717,18 +725,19 @@ instmods() {
     while (($# > 0)); do
         mod=${1%.ko*}
         case $mod in
-            =*) 
+            =*)
                 # This introduces 2 incompatible meanings for =* arguments
                 # to instmods.  We need to decide which one to keep.
-                if [[ $mod = =ata && -f $srcmods/modules.block ]] ; then 
-                    instmods $mpargs $(egrep 'ata|ahci' "${srcmods}/modules.block")
+                if [[ $mod = =ata && -f $srcmods/modules.block ]]; then
+                    instmods $mpargs \
+                        $(egrep 'ata|ahci' "${srcmods}/modules.block")
                 elif [ -f $srcmods/modules.${mod#=} ]; then
                     instmods $mpargs $(cat ${srcmods}/modules.${mod#=} )
                 else
                     instmods $mpargs $(find "$srcmods" -path "*/${mod#=}/*")
                 fi
                 ;;
-            --*) 
+            --*)
                 mod=${mod##*/}
                 mpargs+=" $mod";;
             i2o_scsi) shift; continue;; # Do not load this diagnostic-only module
@@ -738,25 +747,25 @@ instmods() {
                 [[ -f $initdir/$1 ]] && { shift; continue; }
                 # If we are building a host-specific initramfs and this
                 # module is not already loaded, move on to the next one.
-                [[ $hostonly ]] && ! grep -qe "\<${mod//-/_}\>" /proc/modules && \
-                    ! echo $add_drivers | grep -qe "\<${mod}\>" &&  {
-                    shift; continue; 
-                }
+                [[ $hostonly ]] && ! grep -qe "\<${mod//-/_}\>" /proc/modules \
+                    && ! echo $add_drivers | grep -qe "\<${mod}\>" && {
+                        shift; continue
+                    }
 
                 # We use '-d' option in modprobe only if modules prefix path
                 # differs from default '/'.  This allows us to use Dracut with
                 # old version of modprobe which doesn't have '-d' option.
                 moddirname=${srcmods%%/lib/modules/*}
                 [[ -n ${moddirname} ]] && moddirname="-d ${moddirname}/"
-                
+
                 # ok, load the module, all its dependencies, and any firmware
                 # it may require
                 for_each_kmod_dep install_kmod_with_fw $mod \
                     --set-version $kernel ${moddirname}
                 ret=$((ret+$?))
                 ;;
-        esac      
+        esac
         shift
     done
     return $ret
-} 
+}
-- 
1.7.4.1
