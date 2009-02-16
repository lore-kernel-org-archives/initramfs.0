From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 21/50] Simplified get_dso_deps
Date: Mon, 16 Feb 2009 14:06:27 -0500
Message-ID: <200902161906.n1GJ6RP5028069@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=8667f2b7331a24ac863917fe32f2cd29800ab6e4
Commit:     8667f2b7331a24ac863917fe32f2cd29800ab6e4
Parent:     375a5b4084db4e1d51746fea8dc8bb2b731e5b67
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:20 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 21/50] Simplified get_dso_deps
    
    This takes advantage of several bash specific constructs to make
    get_dso_deps easier to read and understand.
---
 dracut-functions |   85 +++++++++++++++++------------------------------------
 1 files changed, 27 insertions(+), 58 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 26254a4..d7717d8 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -21,73 +21,42 @@
 #       Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 #       Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 #       Jakub Jelinek <jakub-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
-#
-#
 
 IF_RTLD=""
 IF_dynamic=""
 get_dso_deps() {
     local bin="$1" ; shift
+    local FILES=() LDSO NAME IO FILE ADDR I1 n f TLIBDIR
 
-    declare -a FILES
-    declare -a NAMES
-
-    local LDSO=$(LANG=C eu-readelf -l $bin 2>/dev/null  |grep interpreter |awk {'print $4;'} |sed -e 's/]$//')
-    [ -z "$LDSO" -o "$LDSO" == "$bin" ] && local LDSO="$IF_RTLD"
-    [ -z "$LDSO" -o "$LDSO" == "$bin" ] && return 1
-    [ -z "$IF_RTLD" ] && IF_RTLD="$LDSO"
+    LDSO=$(LANG=C eu-readelf -l $bin 2>/dev/null | \
+	awk '/interpreter/ {print $4}' |sed -e 's/]$//')
+    [[ $LDSO && $LDSO != $bin ]] || LDSO="$IF_RTLD"
+    [[ $LDSO && $LDSO != $bin ]] || return 1
+    [[ $IF_RTLD ]] || IF_RTLD="$LDSO"
 
-    # I hate shell.
-    declare -i n=0
+    # I love bash!
     while read NAME I0 FILE ADDR I1 ; do
-        [ "$FILE" == "not" ] && FILE="$FILE $ADDR"
-        [ "$NAME" == "not" ] && NAME="$NAME $I0"
-        NAMES[$n]="$NAME"
-        FILES[$n]="$FILE"
-        let n++
-    done << EOF
-        $(LD_TRACE_PRELINKING=1 LD_WARN= LD_TRACE_LOADED_OBJECTS=1 \
+	[[ $FILE = $bin ]] && continue
+        [[ $FILE = not || $NAME = not ]] && {
+	    echo "Missing a shared library required by $bin." >&2
+	    echo "dracut cannot create an initrd." >&2
+	    return 1
+	}
+	# see if we are loading an optimized version of a shared lib.
+	[[ $FILE =~ '(/lib[^/]*).*' ]] && {
+            TLIBDIR=${BASH_REMATCH[1]}
+            BASE="${FILE##*/}"
+	    # prefer nosegneg libs, then unoptimized ones.
+	    for f in "$TLIBDIR/i686/nosegneg" "$TLIBDIR"; do
+		[[ -f $f/$BASE ]] || continue
+		FILE="$f/$BASE"
+		break
+	    done
+            IF_dynamic="yes"
+	}
+        FILES+=("$FILE")
+    done < <(LD_TRACE_PRELINKING=1 LD_WARN= LD_TRACE_LOADED_OBJECTS=1 \
             $LDSO $bin 2>/dev/null)
-EOF
-
-    [ ${#FILES[*]} -eq 0 ] && return 1
-
-    # we don't want the name of the binary in the list
-    if [ "${FILES[0]}" == "$bin" ]; then
-        FILES[0]=""
-        NAMES[0]=""
-        [ ${#FILES[*]} -eq 1 ] && return 1
-    fi
-
-    declare -i n=0
-    while [ $n -lt ${#FILES[*]} ]; do
-        local FILE="${FILES[$n]}"
-        local NAME="${NAMES[$n]}"
-        if [ "$FILE" == "not found" -o "$NAME" == "not found" ]; then
-            cat 1>&2 <<EOF
-There are missing files on your system.  The dynamic object $bin
-requires ${NAMES[$n]} n order to properly function.  mkinitrd cannot continue.
-EOF
-            return 1
-        fi
-        case "$FILE" in
-            /lib*)
-                TLIBDIR=`echo "$FILE" | sed 's,\(/lib[^/]*\)/.*$,\1,'`
-                BASE=`basename "$FILE"`
-                # Prefer nosegneg libs over direct segment accesses on i686.
-                if [ -f "$TLIBDIR/i686/nosegneg/$BASE" ]; then
-                    FILE="$TLIBDIR/i686/nosegneg/$BASE"
-                # Otherwise, prefer base libraries rather than their optimized
-                # variants.
-                elif [ -f "$TLIBDIR/$BASE" ]; then
-                    FILE="$TLIBDIR/$BASE"
-                fi
-                FILES[$n]="$FILE"
-                ;;
-        esac
-        IF_dynamic="yes"
-        let n++
-    done
 
     echo "${FILES[@]}"
 }
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
