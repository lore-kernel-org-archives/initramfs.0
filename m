From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 21/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:15 -0800 (PST)
Message-ID: <f81e4c7fec7010a32da9bd6e98c19eec70874af0.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=uYSpVTyUP9u2+R9lmh9vXN4gnmbdlehKcKjnpKY4ubs=;
        b=Odn7wlJWvxBcKnQ/9QcEueMmnLMtA9e21k/FcMX2WW8L7xn8KSXK07dqrIJfPg0ZHY
         zSRt7/SBW4D/KSb3+Iy1l0UlivoIjnELC/LDXWWCUfDwwbT3956z2CSSF15RXzWRIQ/Y
         1x8VZXGonKXvGf0WMG4726wKg+DaccqWpyCus=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Simplified get_dso_deps

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
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
