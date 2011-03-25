From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 4/9] dracut-functions: logging functions adjusted to dracut-logger
Date: Fri, 25 Mar 2011 15:56:47 +0100
Message-ID: <1301065012-16356-4-git-send-email-aidecoe@aidecoe.name>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301065012-16356-3-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut-functions |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 2e2e37c..1f3ba12 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -246,7 +246,7 @@ inst_simple() {
     if [[ -e "${src%/*}/.${src##*/}.hmac" ]]; then
         inst "${src%/*}/.${src##*/}.hmac" "${target%/*}/.${target##*/}.hmac"
     fi
-    dinfo "Installing $src"
+    ddebug "Installing $src" 
     cp -pfL "$src" "${initdir}$target"
 }
 
@@ -298,7 +298,7 @@ inst_library() {
     # Create additional symlinks.  See rev_symlinks description.
     for symlink in $(rev_lib_symlinks $src) $(rev_lib_symlinks $reallib); do
         [[ ! -e $initdir$symlink ]] && {
-            dinfo "Creating extra symlink: $symlink"
+            ddebug "Creating extra symlink: $symlink"
             inst_symlink $symlink
         }
     done
@@ -333,9 +333,9 @@ inst_binary() {
     LC_ALL=C ldd $bin 2>/dev/null | while read line; do
         [[ $line = 'not a dynamic executable' ]] && return 1
         if [[ $line =~ not\ found ]]; then
-            derror "Missing a shared library required by $bin."
-            derror "Run \"ldd $bin\" to find out what it is."
-            derror "dracut cannot create an initrd."
+            dfatal "Missing a shared library required by $bin."
+            dfatal "Run \"ldd $bin\" to find out what it is."
+            dfatal "dracut cannot create an initrd."
             exit 1
         fi
         so_regex='([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*)'
@@ -418,7 +418,7 @@ inst() {
             [[ $initdir = $2 ]] && set $1;;
         3) [[ -z $initdir ]] && export initdir=$2
             set $1 $3;;
-        *) derror "inst only takes 1 or 2 or 3 arguments"
+        *) dfatal "inst only takes 1 or 2 or 3 arguments"
             exit 1;;
     esac
     for x in inst_symlink inst_script inst_binary inst_simple; do
@@ -432,11 +432,11 @@ inst() {
 # All hooks should be POSIX/SuS compliant, they will be sourced by init.
 inst_hook() {
     if ! [[ -f $3 ]]; then
-        derror "Cannot install a hook ($3) that does not exist."
-        derror "Aborting initrd creation."
+        dfatal "Cannot install a hook ($3) that does not exist."
+        dfatal "Aborting initrd creation."
         exit 1
     elif ! strstr "$hookdirs" "$1"; then
-        derror "No such hook type $1. Aborting initrd creation."
+        dfatal "No such hook type $1. Aborting initrd creation." 
         exit 1
     fi
     inst_simple "$3" "/${1}/${2}${3##*/}"
@@ -450,9 +450,10 @@ dracut_install() {
     while (($# > 0)); do
         if ! inst "$1" ; then
             if [[ $optional = yes ]]; then
-                dwarning "Skipping program $1 as it cannot be found and is flagged to be optional"
+                dwarn "Skipping program $1 as it cannot be found and is" \
+                    "flagged to be optional"
             else
-                derror "Failed to install $1"
+                dfatal "Failed to install $1"
                 exit 1
             fi
         fi
@@ -638,7 +639,7 @@ check_module_dir() {
     for mod in $modcheck; do
         strstr "$mods_to_load" "$mod" && continue
         strstr "$omit_dracutmodules" "$mod" && continue
-        dwarning "Dracut module \"$mod\" cannot be found."
+        derror "Dracut module \"$mod\" cannot be found."
     done
 }
 
@@ -661,7 +662,8 @@ install_kmod_with_fw() {
             fi
         done
         if [[ $found != yes ]]; then
-            dinfo "Possible missing firmware \"${fw}\" for kernel module \"${mod}.ko\""
+            dwarn "Possible missing firmware \"${fw}\" for kernel module" \
+                "\"${mod}.ko\""
         fi
     done
     return 0
-- 
1.7.4.1
