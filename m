From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/18] Some quotation cleanups in dracut-functions.
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <161efa1f40edd72d561b20b12b7dc4b435187209.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Quotes are generally not needed in when assigning one variable to another,
and are also not needed inside [[ ]] comaprisons, as word splitting and
pathname expansion are not performed in these cases.

---
 dracut-functions |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 73bf1fe..c82c7c7 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -29,23 +29,23 @@ if ! [[ $dracutlogfile ]]; then
     [[ $dsrc = /usr/share/dracut ]] && \
        dracutlogfile=/var/log/dracut.log || \
        dracutlogfile=/tmp/dracut.log
-    [[ -w "$dracutlogfile" ]] || dracutlogfile=/tmp/dracut.log
+    [[ -w $dracutlogfile ]] || dracutlogfile=/tmp/dracut.log
     >"$dracutlogfile"
 fi
 
 dwarning() {
     echo "W: $@" >&2
-    [[ -w "$dracutlogfile" ]] && echo "W: $@" >>"$dracutlogfile"
+    [[ -w $dracutlogfile ]] && echo "W: $@" >>"$dracutlogfile"
 }
 
 dinfo() {
     [[ $beverbose ]] && echo "I: $@" >&2
-    [[ -w "$dracutlogfile" ]] && echo "I: $@" >>"$dracutlogfile"
+    [[ -w $dracutlogfile ]] && echo "I: $@" >>"$dracutlogfile"
 }
 
 derror() {
     echo "E: $@" >&2
-    [[ -w "$dracutlogfile" ]] && echo "E: $@" >>"$dracutlogfile"
+    [[ -w $dracutlogfile ]] && echo "E: $@" >>"$dracutlogfile"
 }
 
 # $1 = file to copy to ramdisk
@@ -55,7 +55,7 @@ derror() {
 inst_simple() {
     local src target
     [[ -f $1 ]] || return 1
-    src=$1 target="${initdir}${2:-$1}"
+    src=$1 target=${initdir}${2:-$1}
     [[ -f $target ]] && return 0
     mkdir -p "${target%/*}"
     dinfo "Installing $src" 
@@ -69,10 +69,10 @@ inst_library() {
     local src=$1 dest=${2:-$1}
     [[ -f $initdir$dest ]] && return 0
     if [[ -L $src ]]; then
-	reallib="$(readlink -f "$src")"
+	reallib=$(readlink -f "$src")
 	lib=${src##*/}
 	inst_simple "$reallib" "$reallib"
-	mkdir -p ${initdir}${dest%/*}
+	mkdir -p "${initdir}${dest%/*}"
 	(cd "${initdir}${dest%/*}" && ln -s "$reallib" "$lib")
     else
 	inst_simple "$src" "$dest"
@@ -115,15 +115,15 @@ inst_binary() {
 	lib_regex='^(/lib[^/]*).*'
 	if [[ $FILE =~ $lib_regex ]]; then
             TLIBDIR=${BASH_REMATCH[1]}
-            BASE="${FILE##*/}"
+            BASE=${FILE##*/}
 	    # prefer nosegneg libs, then unoptimized ones.
 	    for f in "$TLIBDIR/i686/nosegneg" "$TLIBDIR"; do
 		[[ -f $f/$BASE ]] || continue
-		FILE="$f/$BASE"
+		FILE=$f/$BASE
 		break
 	    done
 	    inst_library "$FILE" "$TLIBDIR/$BASE"
-            IF_dynamic="yes"
+            IF_dynamic=yes
 	    continue
 	fi
         inst_library "$FILE" 
@@ -150,7 +150,7 @@ inst_symlink() {
     [[ -L $1 ]] || return 1
     [[ -L $target ]] && return 0
     realsrc=$(readlink -f "$src")
-    [[ $realsrc = ${realsrc##*/} ]] && realsrc="${src%/*}/$realsrc"
+    [[ $realsrc = ${realsrc##*/} ]] && realsrc=${src%/*}/$realsrc
     inst "$realsrc" && ln -s "$realsrc" "$target"
 }
 
@@ -166,10 +166,10 @@ find_rule() {
 # udev rules always get installed in the same place, so
 # create a function to install them to make life simpler.
 inst_rules() { 
-    local target="/etc/udev/rules.d"
+    local target=/etc/udev/rules.d
     mkdir -p "$initdir/lib/udev/rules.d" "$initdir$target"
     for rule in "$@"; do 
-	rule=$(find_rule $rule) && \
+	rule=$(find_rule "$rule") && \
 	    inst_simple "$rule" "$target/${rule##*/}"
     done
 }
@@ -206,8 +206,8 @@ dracut_install() {
     local optional=
     while (($# > 0)); do
         # Might be nice to optionally install a binary
-        if [ "$1" == "-o" ]; then
-           optional="yes"
+        if [[ $1 = '-o' ]]; then
+           optional=yes
            shift
            continue
         fi
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
