From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/18] Split kernel module loading into smaller chunks.
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <ddfd1d10a08329d94f320aa0a22d8fec2c047dad.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This prepares to more tightly integrate dracut-gencmdline with the
rest of the dracut scripts, among other 
---
 dracut                                   |    2 +
 dracut-functions                         |   67 ++++++++++++++++++------------
 dracut-gencmdline                        |    7 ---
 modules.d/90kernel-modules/installkernel |    2 +-
 4 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/dracut b/dracut
index 6d4fccb..7e5f2d4 100755
--- a/dracut
+++ b/dracut
@@ -113,6 +113,8 @@ PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
 [[ $dracutbasedir ]] || dracutbasedir=/usr/share/dracut
 [[ $fw_dir ]] || fw_dir=/lib/firmware
 [[ $do_strip ]] || do_strip=yes
+# eliminate IFS hackery when messing with fw_dir
+fw_dir=${fw_dir//:/ }
 
 [[ $allowlocal && -f "$(dirname $0)/dracut-functions" ]] && dsrc="$(dirname $0)" || dsrc=$dracutbasedir
 
diff --git a/dracut-functions b/dracut-functions
index 79982ce..c57174c 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -31,7 +31,7 @@ if ! [[ $dracutlogfile ]]; then
        dracutlogfile=/tmp/dracut.log
     [[ -w $dracutlogfile ]] || dracutlogfile=/tmp/dracut.log
     >"$dracutlogfile"
-fi
+ fi
 
 dwarning() {
     echo "W: $@" >&2
@@ -275,7 +275,43 @@ check_modules() {
     done
 }
 
-# install kernel modules, and handle installing all their dependencies as well.
+# Install a single kernel module along with any firmware it may require.
+# $1 = full path to kernel module to install
+install_kmod_with_fw() {
+    local modname=${1##*/} fwdir found
+    modname=${modname%.ko}
+    inst_simple "$1" "/lib/modules/$kernel/${1##*/lib/modules/$kernel/}"
+    for fw in $(modinfo -k $kernel -F firmware $1 2>/dev/null); do
+	found=''
+	for fwdir in $fw_dir; do
+	    if [[ -d $fwdir && -f $fwdir/$fw ]]; then
+		inst_simple "$fwdir/$fw" "/lib/firmware/$fw"
+		found=yes
+	    fi
+	done
+	if [[ $found != yes ]]; then
+	    dwarning "Possible missing firmware ${fw} for module ${mod}.ko"
+	fi
+    done
+}
+
+# Do something with all the dependencies of a kernel module.
+# Note that kernel modules depend on themselves using the technique we use
+# $1 = function to call for each dependency we find 
+#      It will be passed the full path to the found kernel module 
+# $2 = module to get dependencies for
+# rest of args = arguments to modprobe
+for_each_kmod_dep() {
+    local func=$1 kmod=$2 cmd modpapth options
+    shift 2
+    modprobe "$@" --ignore-install --show-depends $kmod 2>/dev/null | \
+	while read cmd modpath options; do
+	    [[ $cmd = insmod ]] || continue
+	    $func $modpath
+    done
+}
+
+# install kernel modules along with all their dependencies.
 instmods() {
     [[ $no_kernel = yes ]] && return
     local mod mpargs modpath modname cmd
@@ -308,31 +344,8 @@ instmods() {
 		}
 		# ok, load the module, all its dependencies, and any firmware
 		# it may require
-                modprobe $mpargs --ignore-install --set-version $kernel -d ${srcmods%%/lib/modules/*}/ \
-		    --show-depends $mod 2>/dev/null | \
-		    while read cmd modpath options; do
-		    [[ $cmd = insmod ]] || continue
-		    modname=${modpath##*/}
-		    modname=${modname%.ko}
-		    if [[ ${mod/-/_} != ${modname/-/_} ]]; then
-			dinfo "Installing dependencies for $mod ($modpath)"
-			instmods $mpargs $modname
-		    fi
-		    inst_simple "$modpath" "/lib/modules/$kernel/${modpath##*/lib/modules/$kernel/}"
-		    for fw in $(modinfo -k $kernel -F firmware $modpath 2>/dev/null); do
-			unset found
-			IFS=: 
-			for fwdir in $fw_dir; do		    
-		            if [ -d "$fwdir" -a -f $fwdir/$fw ]; then
-				inst_simple "$fwdir/$fw" "/lib/firmware/$fw"
-				found=yes
-			    fi
-			done
-			if [[ $found != yes ]]; then
-			    dwarning "Possible missing firmware ${fw} for module ${mod}.ko"
-			fi
-		    done
-		done
+		for_each_kmod_dep install_kmod_with_fw $mod \
+		    --set-version $kernel -d ${srcmods%%/lib/modules/*}/
 		;;
 	esac      
 	shift
diff --git a/modules.d/90kernel-modules/installkernel b/modules.d/90kernel-modules/installkernel
index 94e3ba9..f9a1ab4 100755
--- a/modules.d/90kernel-modules/installkernel
+++ b/modules.d/90kernel-modules/installkernel
@@ -1,5 +1,5 @@
 #!/bin/bash
-if [ -z "$drivers" ]; then
+if [[ -z $drivers ]]; then
   drivers="sd_mod =fs"
   # Include block controller drivers
   blockfuncs='ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device'
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
