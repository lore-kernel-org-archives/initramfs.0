From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 1/2] dracut-functions: update inst_binary()
Date: Tue, 10 May 2011 14:36:23 +0200
Message-ID: <1305030984-10284-2-git-send-email-soltys@ziu.info>
References: <1305030984-10284-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305030984-10284-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This update adds support for sort-of corner case - when explicitly
specified binary (e.g. through dracut_install or inst) is a library
itself.

In such case, we would expect the binary to undergo typical
library-related handling (symlinks and such).

Apart from that, the patch cleans indenting and a few unused variables
in inst_binary() (probably leftovers from the past ?)

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut-functions |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 41187e0..959c1d3 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -32,9 +32,6 @@ if ! type dinfo >/dev/null 2>&1; then
     dlog_init
 fi
 
-IF_RTLD=""
-IF_dynamic=""
-
 # Generic substring function.  If $2 is in $1, return 0.
 strstr() { [[ $1 =~ $2 ]]; }
 
@@ -330,14 +327,20 @@ find_binary() {
 # Same as above, but specialized to install binary executables.
 # Install binary executable, and all shared library dependencies, if any.
 inst_binary() {
-    local bin target
+    local bin target f self so_regex lib_regex TLIBDIR BASE FILE
+
     bin=$(find_binary "$1") || return 1
     target=${2:-$bin}
     inst_symlink $bin $target && return 0
-    local LDSO NAME IO FILE ADDR I1 n f TLIBDIR
     [[ -e $initdir$target ]] && return 0
+
+    # If the binary being installed is also a library, add it to the loop.
+    so_regex='([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*)'
+    [[ $bin =~ $so_regex ]] && self="\t${bin##*/} => ${bin} (0x0)\n"
+
+    lib_regex='^(/lib[^/]*).*'
     # I love bash!
-    LC_ALL=C ldd $bin 2>/dev/null | while read line; do
+    { LC_ALL=C ldd $bin 2>/dev/null; echo -en "$self"; } | while read line; do
         [[ $line = 'not a dynamic executable' ]] && return 1
         if [[ $line =~ not\ found ]]; then
             dfatal "Missing a shared library required by $bin."
@@ -345,28 +348,28 @@ inst_binary() {
             dfatal "dracut cannot create an initrd."
             exit 1
         fi
-        so_regex='([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*)'
         [[ $line =~ $so_regex ]] || continue
         FILE=${BASH_REMATCH[1]}
         [[ -e ${initdir}$FILE ]] && continue
-        # see if we are loading an optimized version of a shared lib.
-        lib_regex='^(/lib[^/]*).*'
+
+        # See if we are loading an optimized version of a shared lib.
         if [[ $FILE =~ $lib_regex ]]; then
             TLIBDIR=${BASH_REMATCH[1]}
             BASE=${FILE##*/}
-            # prefer nosegneg libs, then unoptimized ones.
+            # Prefer nosegneg libs to unoptimized ones.
             for f in "$TLIBDIR/i686/nosegneg" "$TLIBDIR"; do
                 [[ -e $f/$BASE ]] || continue
                 FILE=$f/$BASE
                 break
             done
             inst_library "$FILE" "$TLIBDIR/$BASE"
-            IF_dynamic=yes
-            continue
-            fi
+        else
             inst_library "$FILE"
+        fi
     done
-    inst_simple "$bin" "$target"
+
+    # Install the binary if it wasn't handled in the above loop.
+    [[ -z $self ]] && inst_simple "$bin" "$target"
 }
 
 # same as above, except for shell scripts.
-- 
1.7.2.1
