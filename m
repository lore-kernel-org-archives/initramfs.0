From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/18] Simplify dracut_install a bit, an make a minor fixup to check_module_deps
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <bd4c4bcb76902578a6a35f4a3bcae390fe0f1b40.1250455879.git.victor.lowther@gmail.com>
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
 dracut-functions |   33 ++++++++++++++-------------------
 1 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index c82c7c7..ffc2724 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -203,32 +203,27 @@ inst_hook() {
 }
 
 dracut_install() {
-    local optional=
+    if [[ $1 = '-o' ]]; then 
+	local optional=yes
+	shift
+    fi
     while (($# > 0)); do
-        # Might be nice to optionally install a binary
-        if [[ $1 = '-o' ]]; then
-           optional=yes
-           shift
-           continue
-        fi
-	if inst "$1" ; then
-            shift 
-            continue
-        fi
-        if [ "$optional" == "yes" ]; then
-          dwarning "Skipping program $1 as it cannot be found and is flagged to be optional"
-          shift
-          continue
-        else
-          derror "Failed to install $1"; exit 1
-        fi
+	if ! inst "$1" ; then
+	    if [[ $optional = yes ]]; then
+		dwarning "Skipping program $1 as it cannot be found and is flagged to be optional"
+	    else
+		derror "Failed to install $1"
+		exit 1
+            fi
+	fi
+	shift
     done
 }
 
 check_module_deps() {
     local moddir dep ret
     # if we are already set to be loaded, we do not have to be checked again.
-    strstr "$mods_to_load" " $1 "
+    strstr "$mods_to_load" " $1 " && return
     # turn a module name into a directory, if we can.
     moddir=$(echo ${dsrc}/modules.d/??${1})
     [[ -d $moddir && -x $moddir/install ]] || return 1
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
