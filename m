From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 6/8] instmods: factor out egrep of "FATAL: Module .* not found"
Date: Tue, 30 Aug 2011 21:40:38 -0700
Message-ID: <4E5DBB46.3060001@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dracut-functions |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index dc71f51..6278eb4 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -820,7 +820,7 @@ install_kmod_with_fw() {
 for_each_kmod_dep() {
     local _func=$1 _kmod=$2 _cmd _modpath _options _found=0
     shift 2
-    modprobe "$@" --ignore-install --show-depends $_kmod 2>"$initdir/modprobe.err" | (
+    modprobe "$@" --ignore-install --show-depends $_kmod 2>&$modprobe_stderr | (
         while read _cmd _modpath _options; do
             [[ $_cmd = insmod ]] || continue
             $_func ${_modpath} || exit $?
@@ -829,9 +829,6 @@ for_each_kmod_dep() {
         [[ $_found -eq 0 ]] && exit 1
         exit 0
     )
-    egrep -v 'FATAL: Module .* not found.' "$initdir/modprobe.err" | derror
-    rm -f "$initdir/modprobe.err"
-    return $?
 }
  # filter kernel modules to install certain modules that meet specific
@@ -934,16 +931,23 @@ instmods() {
         esac
     }
-    local _mpargs _ret=0
-    if (($# == 0)); then  # filenames from stdin
-        local _mod
-        while read _mod; do
-            inst1mod "${_mod%.ko*}"
+    function instmods_1() {
+        local _ret=0 _mod _mpargs
+        if (($# == 0)); then  # filenames from stdin
+            while read _mod; do
+                inst1mod "${_mod%.ko*}"
+            done
+        fi
+        while (($# > 0)); do  # filenames as arguments
+            inst1mod ${1%.ko*}
+            shift
         done
-    fi
-    while (($# > 0)); do  # filenames as args
-        inst1mod ${1%.ko*}
-        shift
-    done
-    return $_ret
+        return $_ret
+    }
+
+    # Capture all stderr from modprobe onto a new fd $modprobe_stderr,
+    # and pipe it into egrep.  See REDIRECTION in bash manpage.
+    ( instmods_1 "$@" ) {modprobe_stderr}>&1 \
+    | egrep -v 'FATAL: Module .* not found.' | derror
+    return $?
 }
-- 
1.7.6


-- 
