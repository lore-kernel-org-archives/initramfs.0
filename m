From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 24/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:29 -0800 (PST)
Message-ID: <0b6a7c11f52cdfd456e1912a84d259f1756d18e4.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=TIEnXaE5CVNqUMvJF2Z0OKKHVMTGXJ7Sx9qvtnUtR3U=;
        b=D+1Lcv+uvJzBL10M/KUWuvJAC+eJWBSDLwPMJ2saQ59zumHkfPMBLTbqCQzS9og+8g
         r+d/ZRlsnPlqCUw4s5mG413MdqqJKONlExEvVzqBGR1hTIo/EvavhjEjta34V4whY1rz
         t7vwTQX2NvbrV91wINi+0iig+8MQ905azVOs8=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Replace inst function with a family of specialized functions

This makes things shorter and easier to read.
---
 dracut           |   20 ++++----
 dracut-functions |  140 +++++++++++++++++++++++++++---------------------------
 init             |    2 +-
 3 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/dracut b/dracut
index 018b5aa..8bebbd6 100755
--- a/dracut
+++ b/dracut
@@ -50,7 +50,7 @@ udevexe="/lib/udev/vol_id /lib/udev/console_init"
 
 # install base files
 for binary in $exe $debugexe $udevexe $lvmexe $cryptexe ; do
-  inst $binary "$initdir"
+  inst $binary
 done
 
 # FIXME: would be nice if we didn't have to know which rules to grab....
@@ -73,12 +73,12 @@ if [[ -f /etc/sysconfig/keyboard || -f /etc/sysconfig/console/default.kmap ]]; t
         [[ $KEYTABLE && -d /lib/kbd/keymaps ]] && KEYMAP="$KEYTABLE.map"
     fi
     if [[ $KEYMAP ]]; then
-        [ -f /etc/sysconfig/keyboard ] && inst /etc/sysconfig/keyboard "$initdir"
-        inst /bin/loadkeys "$initdir"
+        [ -f /etc/sysconfig/keyboard ] && inst /etc/sysconfig/keyboard
+        inst /bin/loadkeys
         findkeymap $KEYMAP
 
         for FN in $KEYMAPS; do
-            inst $FN "$initdir"
+            inst $FN
             case $FN in
                 *.gz) gzip -d "$initdir$FN" ;;
                 *.bz2) bzip2 -d "$initdir$FN" ;;
@@ -89,19 +89,19 @@ fi
 
 if [ -f /etc/sysconfig/i18n ]; then
     . /etc/sysconfig/i18n
-    inst /etc/sysconfig/i18n "$initdir"
+    inst /etc/sysconfig/i18n
     [[ $SYSFONT ]] || SYSFONT=latarcyrheb-sun16
-    inst /bin/setfont "$initdir"
+    inst /bin/setfont
 
     for FN in /lib/kbd/consolefonts/$SYSFONT.* ; do
-        inst "$FN" "$initdir"
+        inst "$FN"
         case $FN in
             *.gz) gzip -d "$initdir$FN" ;;
             *.bz2) bzip2 -d "$initdir$FN" ;;
         esac
     done
-    [[ $SYSFONTACM ]] && inst /lib/kbd/consoletrans/$SYSFONTACM "$initdir"
-    [[ $UNIMAP ]] && inst /lib/kbd/unimaps/$UNIMAP "$initdir"
+    [[ $SYSFONTACM ]] && inst /lib/kbd/consoletrans/$SYSFONTACM
+    [[ $UNIMAP ]] && inst /lib/kbd/unimaps/$UNIMAP
 fi
 
 # install our files
@@ -113,7 +113,7 @@ for d in etc proc sys sysroot dev/pts; do mkdir -p "$initdir/$d"; done
 # FIXME: hard-coded module list of doom.
 [[ $modules ]] || modules="=ata =block =drm dm-crypt aes sha256 cbc"
 
-instmod $modules
+instmods $modules
 
 /sbin/depmod -a -b "$initdir" $kernel || {
     error "\"/sbin/depmod -a $kernel\" failed."
diff --git a/dracut-functions b/dracut-functions
index 732581e..1ded3d8 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -24,9 +24,41 @@
 
 IF_RTLD=""
 IF_dynamic=""
-get_dso_deps() {
-    local bin="$1" ; shift
-    local FILES=() LDSO NAME IO FILE ADDR I1 n f TLIBDIR
+
+# $1 = file to copy to ramdisk
+# $2 (optional) Name for the file on the ramdisk
+# Location of the image dir is assumed to be $initdir
+inst_simple() {
+    local src=$1 target="${initdir}${2:-$1}"
+    [[ -f $target ]] && return 0
+    echo "Installing $src to $target"
+    mkdir -p "${target%/*}"
+    cp -fL "$src" "$target"
+}
+
+inst_library() {
+    local src=$1 dest=${2:-$1}
+    [[ -f $initdir$dest ]] && return 0
+    if [[ -L $src ]]; then
+	reallib="$(readlink "$src")"
+	lib=${src##*/}
+	realsrc="${src%/*}/$reallib"
+	realdest="${dest%/*}/$reallib"
+	inst_simple "$realsrc" "$realdest"
+	(cd "${initdir}${dest%/*}" && ln -s "$reallib" "$lib")
+    else
+	inst_simple "$src" "$dest"
+    fi
+}
+	
+	
+
+# Same as above.
+# If the file is a binary executable, install all its
+# shared library dependencies, if any.
+inst_binary() {
+    local bin="$1" target="${2:-$1}"
+    local LDSO NAME IO FILE ADDR I1 n f TLIBDIR
 
     LDSO=$(LANG=C eu-readelf -l $bin 2>/dev/null | \
 	awk '/interpreter/ {print $4}' |sed -e 's/]$//')
@@ -36,14 +68,14 @@ get_dso_deps() {
 
     # I love bash!
     while read NAME I0 FILE ADDR I1 ; do
-	[[ $FILE = $bin ]] && continue
+	[[ $FILE = $bin ]] && continue 
         [[ $FILE = not || $NAME = not ]] && {
 	    echo "Missing a shared library required by $bin." >&2
 	    echo "dracut cannot create an initrd." >&2
-	    return 1
+	    exit 1
 	}
 	# see if we are loading an optimized version of a shared lib.
-	[[ $FILE =~ '(/lib[^/]*).*' ]] && {
+	[[ $FILE =~ '^(/lib[^/]*).*' ]] && {
             TLIBDIR=${BASH_REMATCH[1]}
             BASE="${FILE##*/}"
 	    # prefer nosegneg libs, then unoptimized ones.
@@ -52,80 +84,48 @@ get_dso_deps() {
 		FILE="$f/$BASE"
 		break
 	    done
+	    inst_library "$FILE" "$TLIBDIR/$BASE"
             IF_dynamic="yes"
+	    continue
 	}
-        FILES+=("$FILE")
+        inst_library "$FILE" 
     done < <(LD_TRACE_PRELINKING=1 LD_WARN= LD_TRACE_LOADED_OBJECTS=1 \
             $LDSO $bin 2>/dev/null)
+    inst_simple "$bin" "$target"
+}
 
-    echo "${FILES[@]}"
+# same as above, except for shell scripts.
+# If your shell script does not start with shebang, it is not a shell script.
+inst_script() {
+    local src=$1 target=${2:-$1} line
+    read -r -n 80 line <"$src"
+    [[ $line =~ '(#! *)(/[^ ]+).*' ]] || return 1
+    inst "${BASH_REMATCH[2]}" && inst_simple "$src" "$target"
 }
 
+# same as above, but specialized for symlinks
+inst_symlink() {
+    local src=$1 target=$initdir${2:-$1} realsrc
+    [[ -L $1 ]] || return 1
+    [[ -L $target ]] && return 0
+    realsrc=$(readlink "$src")
+    [[ $realsrc = ${realsrc##*/} ]] && realsrc="${src%/*}/$realsrc"
+    inst "$realsrc" && ln -s "$realsrc" "$target"
+}
+
+# general purpose installation function
+# Same args as above.
+# Just tries to install as a binary, a shell script, then a simple data file.
 inst() {
-    if (($# != 2 && $# != 3)); then
+    if (($# != 1 && $# != 2)); then
         echo "usage: inst <file> <root> [<destination file>]"
         return 1
     fi
-    local file="$1" ; shift
-    local root="${1%%/}" ; shift
-    local dest="${1##/}"
-    [[ $dest ]] || dest="${file##/}"
-    mkdir -p "$root/${dest%/*}"
-    local RET=0
-    local target=""
-    [[ -L $file ]] && target=$(readlink "$file")
-    if [[ $target && $dest != $target ]]; then
-        if [[ -e $root/$dest ]]; then
-            RET=0
-        else
-            ln -sf "$target" "$root/$dest"
-            #inst "$target" "$root"
-            local BASE=${target##*/}
-            local LIBDIR=$(echo "$file" | sed -e 's,\(\(.*\)/\)[^/]\+$,\1,')
-            if [[ $LIBDIR = $BASE ]]; then
-                local LIBDIR=$(echo "/$dest" | sed -e 's,\(\(.*\)/\)[^/]\+$,\1,')
-            fi  
-            local TLIBDIR=$(echo "$target" | sed -e 's,\(^/lib[^/]*\)/.*$,\1/,' \
-                -e 's,\(\(.*\)/\)[^/]\+$,\1,')
-            if [[ $TLIBDIR = $BASE ]]; then
-                local TLIBDIR=$(echo "/$dest" | sed \
-                    -e 's,\(^/lib[^/]*\)/.*$,\1/,' \
-                    -e 's,\(\(.*\)/\)[^/]\+$,\1,')
-            fi
-            inst "$LIBDIR/$BASE" "$root" "$TLIBDIR/$BASE"
-            RET=$?
-            return $RET
-        fi
-    fi
-    local SHEBANG=$(dd if="$file" bs=2 count=1 2>/dev/null)
-    if [[ $SHEBANG = '#!' ]]; then
-        # We're intentionally not playing the "what did this moron run
-        # in his shell script" game.  There's nothing but pain in that.
-        local interp=$(head -1 "$file" | sed 's/^#! *//')
-        inst "$interp" "$root"
-        RET=$?
-        return $RET
-    fi
-    if [[ -e $root/$dest ]]; then
-        RET=0
-    else
-        if [[ $target && -L $target ]]; then
-            inst "$target" "$root"
-            RET=$?
-        else
-            cp -aL "$file" "$root/$dest"
-            local DEPS=$(get_dso_deps "$file")
-            if [[ $DEPS ]]; then
-		for x in $DEPS; do
-                    local TLIBDIR=$(echo "$x" | sed 's,\(/lib[^/]*\)/.*$,\1,')
-                    local BASE=$(basename "$x")
-                    inst "$x" "$root" "$TLIBDIR/$BASE"
-		done
-		RET=$?
-            fi
-	fi
-    fi
-    return $RET
+    local src=$1 dest=${2:-$1}
+    for x in inst_symlink inst_binary inst_script inst_simple; do
+	$x "$src" "$dest" && return 0
+    done
+    return 1
 }
 
 modcat="/lib/modules/$kernel/modules"
@@ -146,7 +146,7 @@ instmods() {
 			instmods $mpargs $modname
 			continue
 		    }
-		    inst "$modpath" "$initdir" "/lib/modules/$kernel/$modname.ko"
+		    inst_simple "$modpath" "/lib/modules/$kernel/$modname.ko"
 		done
 		;;
 	esac
diff --git a/init b/init
index 599f8ad..d5095ea 100755
--- a/init
+++ b/init
@@ -44,7 +44,7 @@ mknod /dev/tty1 c 4 1
 
 # start plymouth if it's available
 # arguably we need some of udev run first for fbmods and above devnodes :/
-[ -x /bin/plymouthd ] && plymouthd --attach-to-session
+[ -x /bin/plymouthd ] && plymouthd
 [ -x /bin/plymouth ] && plymouth --show-splash
 
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
