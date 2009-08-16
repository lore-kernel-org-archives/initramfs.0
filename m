From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/18] More quotation fixups in dracut-functions
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <0c1a8ebc37f1bdb19cbd65b98266e554e8f2e92b.1250455879.git.victor.lowther@gmail.com>
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
 dracut-functions |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index ffc2724..79982ce 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -245,7 +245,7 @@ check_module_deps() {
 should_source_module() {
     local dep
     [[ -x $1/install ]] || return 1
-    if [[ "$kernel_only" = "yes" ]]; then
+    if [[ $kernel_only = yes ]]; then
         [[ -x $1/installkernel ]] && return 0
         return 1
     fi
@@ -277,14 +277,14 @@ check_modules() {
 
 # install kernel modules, and handle installing all their dependencies as well.
 instmods() {
-    [[ "$no_kernel" = "yes" ]] && return
+    [[ $no_kernel = yes ]] && return
     local mod mpargs modpath modname cmd
     while (($# > 0)); do
 	mod=${1%.ko}
 	case $mod in
 	    =*) # This introduces 2 incompatible meanings for =* arguments
                 # to instmods.  We need to decide which one to keep.
-		if [ "$mod" = "=ata" -a -f $srcmods/modules.block ] ; then 
+		if [[ $mod = =ata && -f $srcmods/modules.block ]] ; then 
 		    instmods $mpargs $(egrep 'ata|ahci' "${srcmods}/modules.block")
 		elif [ -f $srcmods/modules.${mod#=} ]; then
 		    instmods $mpargs $(cat ${srcmods}/modules.${mod#=} )
@@ -306,6 +306,8 @@ instmods() {
 		[[ $hostonly ]] && ! grep -q "$mod" /proc/modules && { 
 		    shift; continue; 
 		}
+		# ok, load the module, all its dependencies, and any firmware
+		# it may require
                 modprobe $mpargs --ignore-install --set-version $kernel -d ${srcmods%%/lib/modules/*}/ \
 		    --show-depends $mod 2>/dev/null | \
 		    while read cmd modpath options; do
@@ -326,7 +328,7 @@ instmods() {
 				found=yes
 			    fi
 			done
-			if [ "$found" != "yes" ]; then
+			if [[ $found != yes ]]; then
 			    dwarning "Possible missing firmware ${fw} for module ${mod}.ko"
 			fi
 		    done
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
