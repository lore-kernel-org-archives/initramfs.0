From: Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] dracut: add --force-add option
Date: Mon,  1 Aug 2011 10:01:23 +0800
Message-ID: <1312164084-11496-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

This patch adds a new option --force-add, which
can force dracut to load some module when -H
is specified.

Signed-off-by: Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut           |    8 ++++++++
 dracut-functions |   24 ++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/dracut b/dracut
index aa8cb58..c9fb6d5 100755
--- a/dracut
+++ b/dracut
@@ -195,6 +195,7 @@ verbosity_mod_l=0
 while (($# > 0)); do
     case ${1%%=*} in
         -a|--add)      push_arg add_dracutmodules_l  "$@" || shift;;
+        --force-add)   push_arg force_add_dracutmodules_l  "$@" || shift;;
         --add-drivers) push_arg add_drivers_l        "$@" || shift;;
         -m|--modules)  push_arg dracutmodules_l      "$@" || shift;;
         -o|--omit)     push_arg omit_dracutmodules_l "$@" || shift;;
@@ -301,6 +302,13 @@ if (( ${#add_dracutmodules_l[@]} )); then
     done
 fi
 
+if (( ${#force_add_dracutmodules_l[@]} )); then
+    while pop force_add_dracutmodules_l val; do
+        force_add_dracutmodules+=" $val "
+    done
+fi
+
+
 if (( ${#add_drivers_l[@]} )); then
     while pop add_drivers_l val; do
         add_drivers+=" $val "
diff --git a/dracut-functions b/dracut-functions
index 61e10e8..f0abe9f 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -607,21 +607,27 @@ inst_opt_decompress() {
 module_check() {
     local _moddir=$(echo ${dracutbasedir}/modules.d/??${1})
     local _ret
+    local _forced=0
+    local _hostonly=$hostonly
+    [ $# -eq 2 ] && _forced=$2
     [[ -d $_moddir ]] || return 1
     if [[ ! -f $_moddir/module-setup.sh ]]; then
         # if we do not have a check script, we are unconditionally included
         [[ -x $_moddir/check ]] || return 0
+        [ $_forced -ne 0 ] && unset hostonly
         $_moddir/check $hostonly
-        return $?
+        _ret=$?
     else
         unset check depends install installkernel
         . $_moddir/module-setup.sh
         is_func check || return 0
-        check
+        [ $_forced -ne 0 ] && unset hostonly
+        check $hostonly
         _ret=$?
         unset check depends install installkernel
-        return $_ret
     fi
+    hostonly=$_hostonly
+    return $_ret
 }
 
 module_depends() {
@@ -696,8 +702,12 @@ check_module() {
 
     strstr " $omit_dracutmodules " " $_mod " && return 1
 
-    if strstr " $dracutmodules $add_dracutmodules " " $_mod "; then
-        module_check $_mod; ret=$?
+    if strstr " $dracutmodules $add_dracutmodules $force_add_dracutmodules" " $_mod "; then
+        if strstr " $force_add_dracutmodules" " $_mod"; then
+            module_check $_mod 1; ret=$?
+        else
+            module_check $_mod 0; ret=$?
+        fi
         # explicit module, so also accept ret=255
         [[ $ret = 0 || $ret = 255 ]] || return 1
     else
@@ -715,6 +725,8 @@ check_module() {
         # handle deps as if they were manually added
         strstr " $add_dracutmodules " " $_moddep " || \
             add_dracutmodules+=" $_moddep "
+        strstr " $force_add_dracutmodules " " $_moddep " || \
+            force_add_dracutmodules+=" $_moddep "
         # if a module we depend on fail, fail also
         check_module $_moddep || return 1
     done
@@ -736,7 +748,7 @@ check_module_dir() {
     done
 
     # Report any missing dracut modules, the user has specified
-    _modcheck=$add_dracutmodules
+    _modcheck="$add_dracutmodules $force_add_dracutmodules"
     [[ $dracutmodules != all ]] && _modcheck="$m $dracutmodules"
     for _mod in $_modcheck; do
         strstr "$mods_to_load" "$_mod" && continue
-- 
1.7.4.4
