From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 22/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:20 -0800 (PST)
Message-ID: <bfb88c10b40a2e80d84a4a77da4ddef64a2f3839.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=MTSTJCq8o14OhCYNvscvBWLC+GJAlj15TBJnELLIyr8=;
        b=bJGUQaPkPatym907yhkP9X1KyRkJaRkXfDlbeE6WTi68XLhVCnF/nyE+LY1/5gZYsn
         NwVGJvw5C7ZEEEQnFk2DaYfq3ZRjk5g6Q/JaY15YdQZY+VuoYL9WuBVCsw6dAe6E9p5J
         HGgNhS7bELjMyE6kJXeW9N4Ea0X6S+oqRYYsA=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Bashify inst function where ot makes things easier to read.

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
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
