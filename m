From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 22/50] Bashify inst function where ot makes things easier to read.
Date: Mon, 16 Feb 2009 14:06:29 -0500
Message-ID: <200902161906.n1GJ6TxF028097@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=170b260bd9812de5307f394d030079549d95fc4d
Commit:     170b260bd9812de5307f394d030079549d95fc4d
Parent:     8667f2b7331a24ac863917fe32f2cd29800ab6e4
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:22 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 22/50] Bashify inst function where ot makes things easier to read.
---
 dracut-functions |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index d7717d8..8a237ec 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -62,36 +62,35 @@ get_dso_deps() {
 }
 
 inst() {
-    if [ "$#" != "2" -a "$#" != "3" ];then
+    if (($# != 2 && $# != 3));then
         echo "usage: inst <file> <root> [<destination file>]"
         return 1
     fi
     local file="$1" ; shift
-    local root="${1%%/}/" ; shift
+    local root="${1%%/}" ; shift
     local dest="${1##/}"
-    [ -z "$dest" ] && local dest="${file##/}"
+    [[ $dest ]] || dest="${file##/}"
 
-    mkdir -p "$root/$(dirname $dest)"
+    mkdir -p "$root/${dest%/*}"
 
     local RET=0
     local target=""
     [ -L "$file" ] && target=$(readlink "$file")
-    if [ -n "$target" -a "$dest" != "$target" ]; then
-        if [ -e "$root$dest" ]; then
+    if [[ $target && $dest != $target ]]; then
+        if [[ -e $root/$dest ]]; then
             RET=0
         else
-
-            ln -sf "$target" "$root$dest"
+            ln -sf "$target" "$root/$dest"
             #inst "$target" "$root"
-            local BASE=`basename "$target"`
+            local BASE=${target##*/}
             local LIBDIR=`echo "$file" | sed -e 's,\(\(.*\)/\)[^/]\+$,\1,'`
-            if [ "$LIBDIR" = "$BASE" ]; then
+            if [[ $LIBDIR = $BASE ]]; then
                 local LIBDIR=`echo "/$dest" | sed -e 's,\(\(.*\)/\)[^/]\+$,\1,'`
             fi
 
             local TLIBDIR=`echo "$target" | sed -e 's,\(^/lib[^/]*\)/.*$,\1/,' \
                                                 -e 's,\(\(.*\)/\)[^/]\+$,\1,'`
-            if [ "$TLIBDIR" = "$BASE" ]; then
+            if [[ $TLIBDIR = $BASE ]]; then
                 local TLIBDIR=`echo "/$dest" | sed \
                                                 -e 's,\(^/lib[^/]*\)/.*$,\1/,' \
                                                 -e 's,\(\(.*\)/\)[^/]\+$,\1,'`
@@ -104,7 +103,7 @@ inst() {
     fi
 
     local SHEBANG=$(dd if="$file" bs=2 count=1 2>/dev/null)
-    if [ "$SHEBANG" == '#!' ]; then
+    if [[ $SHEBANG = '#!' ]]; then
         # We're intentionally not playing the "what did this moron run
         # in his shell script" game.  There's nothing but pain in that.
         local interp=$(head -1 "$file" | sed 's/^#! *//')
@@ -113,17 +112,17 @@ inst() {
         return $RET
     fi
 
-    if [ -e "$root$dest" ]; then
+    if [[ -e $root/$dest ]]; then
         RET=0
     else
-        if [ -n "$target" -a -L "$target" ]; then
+        if [[ $target && -L $target ]]; then
             inst "$target" "$root"
             RET=$?
         else
-            cp -aL "$file" "$root$dest"
+            cp -aL "$file" "$root/$dest"
 
             local DEPS=$(get_dso_deps "$file")
-            if [ -n "$DEPS" ]; then
+            if [[ $DEPS ]]; then
                 IF_dynamic="yes"
             fi
             for x in $DEPS ; do
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
