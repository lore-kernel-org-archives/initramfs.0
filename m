From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/18] No need to quote variable expansion in [[ ]]
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <98adb06ea3d2c41a2c1500be855881ada2b50cad.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dracut |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/dracut b/dracut
index 78cd2ef..6d4fccb 100755
--- a/dracut
+++ b/dracut
@@ -155,7 +155,7 @@ chmod 755 "$initdir"
 export initdir hookdirs dsrc dracutmodules drivers \
     fw_dir drivers_dir debug beverbose no_kernel kernel_only
 
-if [[ "$kernel_only" != "yes" ]]; then
+if [[ $kernel_only != yes ]]; then
     # Create some directory structure first
     for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot tmp dev/pts var/run; do 
 	mkdir -p "$initdir/$d"; 
@@ -170,11 +170,11 @@ check_modules
 for moddir in "$dsrc/modules.d"/[0-9][0-9]*; do
     mod=${moddir##*/}; mod=${mod#[0-9][0-9]}
     if strstr "$mods_to_load" " $mod "; then
-	if [[ "$kernel_only" = "yes" ]]; then
-	    [[ -x "$moddir/installkernel" ]] && . "$moddir/installkernel"
+	if [[ $kernel_only = yes ]]; then
+	    [[ -x $moddir/installkernel ]] && . "$moddir/installkernel"
 	else
 	    . "$moddir/install"
-	    if [[ "$no_kernel" != "yes" && -x "$moddir/installkernel" ]]; then
+	    if [[ $no_kernel != yes && -x $moddir/installkernel ]]; then
 		. "$moddir/installkernel"
 	    fi
 	fi
@@ -187,7 +187,7 @@ echo $mods_to_load
 ## final stuff that has to happen
 
 # generate module dependencies for the initrd
-if [ -d "$initdir/lib/modules/$kernel" ]; then
+if [[ -d $initdir/lib/modules/$kernel ]]; then
     if ! depmod -a -b "$initdir" $kernel; then
         echo "\"depmod -a $kernel\" failed."
         exit 1
@@ -207,10 +207,10 @@ for item in $install_items; do
 done
 unset item
 
-[[ "$beverbose" = "yes" ]] && (du -c "$initdir" | sort -n)
+[[ $beverbose = yes ]] && (du -c "$initdir" | sort -n)
 
 # strip binaries 
-if [ "$do_strip" = "yes" ] ; then
+if [[ $do_strip = yes ]] ; then
     for p in strip objdump sed grep find; do 
 	if ! which $p >/dev/null 2>&1; then
 	    derror "Could not find '$p'. You should run $0 with '--nostrip'."
@@ -219,7 +219,7 @@ if [ "$do_strip" = "yes" ] ; then
     done
 fi
 
-if [ "$do_strip" = "yes" ] ; then
+if [[ $do_strip = yes ]] ; then
     for f in $(find "$initdir" -type f \( -perm -0100 -or -perm -0010 -or -perm -0001 \) -exec file {} \; | 
 	grep -v ' shared object,' | 
 	sed -n -e 's/^\(.*\):[ 	]*ELF.*, not stripped/\1/p'); do
@@ -240,7 +240,7 @@ fi
 
 ( cd "$initdir"; find . |cpio -R 0:0 -H newc -o |gzip -9 > "$outfile"; )
 
-[[ "$beverbose" = "yes" ]] && ls -lh "$outfile"
+[[ $beverbose = yes ]] && ls -lh "$outfile"
 
 exit 0
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
