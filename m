From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 23/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:36:25 -0800 (PST)
Message-ID: <f393f138baf78d7bf99d31a4912b6ae313f1842f.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=Xlv32pF5cpw3z5oQ2QCSv1kIAKaYMsqaLeBJ2bIS0vs=;
        b=APcMBsGO3+Qg8wauLzGX2iUlJIHj2LiYn2d99W8A2mORiXVKtzcOhFxqfbnRgS9PXh
         JlmlskRMCPjyY/Pa7m/NbFL/B/BDhJ2PMyfWJm7+r7IxcM3WTcbERDeDgRIts+owIqGU
         H9qILANebpTwCmtzg4c/QhFvQIT5Uu9/xE4co=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Rip out old recursive module loading, replace with something simpler

bash allows unlimited recursion and several other tricks to make
finding all the dependencies of a kernel module much simpler.

This nukes about 130 lines, most of it in dracut-functions.

This diff also touches some cleanups made in the inst function, and
tightens up findkeymap
---
 dracut           |    6 +--
 dracut-functions |  205 +++++++++++++-----------------------------------------
 2 files changed, 50 insertions(+), 161 deletions(-)

diff --git a/dracut b/dracut
index 84abdb5..018b5aa 100755
--- a/dracut
+++ b/dracut
@@ -113,11 +113,7 @@ for d in etc proc sys sysroot dev/pts; do mkdir -p "$initdir/$d"; done
 # FIXME: hard-coded module list of doom.
 [[ $modules ]] || modules="=ata =block =drm dm-crypt aes sha256 cbc"
 
-mkdir -p "$initdir/lib/modules/$kernel"
-# expand out module deps, etc
-for mod in $(resolveAndExpandModules $modules) ; do
-    installmodule $mod "$initdir"
-done
+instmod $modules
 
 /sbin/depmod -a -b "$initdir" $kernel || {
     error "\"/sbin/depmod -a $kernel\" failed."
diff --git a/dracut-functions b/dracut-functions
index 8a237ec..732581e 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -62,7 +62,7 @@ get_dso_deps() {
 }
 
 inst() {
-    if (($# != 2 && $# != 3));then
+    if (($# != 2 && $# != 3)); then
         echo "usage: inst <file> <root> [<destination file>]"
         return 1
     fi
@@ -70,12 +70,10 @@ inst() {
     local root="${1%%/}" ; shift
     local dest="${1##/}"
     [[ $dest ]] || dest="${file##/}"
-
     mkdir -p "$root/${dest%/*}"
-
     local RET=0
     local target=""
-    [ -L "$file" ] && target=$(readlink "$file")
+    [[ -L $file ]] && target=$(readlink "$file")
     if [[ $target && $dest != $target ]]; then
         if [[ -e $root/$dest ]]; then
             RET=0
@@ -83,25 +81,22 @@ inst() {
             ln -sf "$target" "$root/$dest"
             #inst "$target" "$root"
             local BASE=${target##*/}
-            local LIBDIR=`echo "$file" | sed -e 's,\(\(.*\)/\)[^/]\+$,\1,'`
+            local LIBDIR=$(echo "$file" | sed -e 's,\(\(.*\)/\)[^/]\+$,\1,')
             if [[ $LIBDIR = $BASE ]]; then
-                local LIBDIR=`echo "/$dest" | sed -e 's,\(\(.*\)/\)[^/]\+$,\1,'`
-            fi
-
-            local TLIBDIR=`echo "$target" | sed -e 's,\(^/lib[^/]*\)/.*$,\1/,' \
-                                                -e 's,\(\(.*\)/\)[^/]\+$,\1,'`
+                local LIBDIR=$(echo "/$dest" | sed -e 's,\(\(.*\)/\)[^/]\+$,\1,')
+            fi  
+            local TLIBDIR=$(echo "$target" | sed -e 's,\(^/lib[^/]*\)/.*$,\1/,' \
+                -e 's,\(\(.*\)/\)[^/]\+$,\1,')
             if [[ $TLIBDIR = $BASE ]]; then
-                local TLIBDIR=`echo "/$dest" | sed \
-                                                -e 's,\(^/lib[^/]*\)/.*$,\1/,' \
-                                                -e 's,\(\(.*\)/\)[^/]\+$,\1,'`
+                local TLIBDIR=$(echo "/$dest" | sed \
+                    -e 's,\(^/lib[^/]*\)/.*$,\1/,' \
+                    -e 's,\(\(.*\)/\)[^/]\+$,\1,')
             fi
-
             inst "$LIBDIR/$BASE" "$root" "$TLIBDIR/$BASE"
             RET=$?
             return $RET
         fi
     fi
-
     local SHEBANG=$(dd if="$file" bs=2 count=1 2>/dev/null)
     if [[ $SHEBANG = '#!' ]]; then
         # We're intentionally not playing the "what did this moron run
@@ -111,7 +106,6 @@ inst() {
         RET=$?
         return $RET
     fi
-
     if [[ -e $root/$dest ]]; then
         RET=0
     else
@@ -120,162 +114,61 @@ inst() {
             RET=$?
         else
             cp -aL "$file" "$root/$dest"
-
             local DEPS=$(get_dso_deps "$file")
             if [[ $DEPS ]]; then
-                IF_dynamic="yes"
+		for x in $DEPS; do
+                    local TLIBDIR=$(echo "$x" | sed 's,\(/lib[^/]*\)/.*$,\1,')
+                    local BASE=$(basename "$x")
+                    inst "$x" "$root" "$TLIBDIR/$BASE"
+		done
+		RET=$?
             fi
-            for x in $DEPS ; do
-                local TLIBDIR=`echo "$x" | sed 's,\(/lib[^/]*\)/.*$,\1,'`
-                local BASE=`basename "$x"`
-                inst "$x" "$root" "$TLIBDIR/$BASE"
-            done
-            RET=$?
-        fi
+	fi
     fi
     return $RET
 }
 
-# module dep finding and installation functions
-moduledep() {
-    MPARGS=""
-    if [ "$1" == "--ignore-install" ]; then
-        MPARGS="$MPARGS --ignore-install"
-        shift
-    fi
-    deps=""
-    deps=$(modprobe $MPARGS --set-version $kernel --show-depends $1 2>/dev/null| awk '/^insmod / { print gensub(".*/","","g",$2) }' | while read foo ; do [ "${foo%%.ko}" != "$1" ] && echo -n "${foo%%.ko} " ; done)
-}
-
-locatemodule() {
-    MPARGS=""
-    if [ "$1" == "--ignore-install" ]; then
-        MPARGS="$MPARGS --ignore-install"
-        shift
-    fi
-    fmPath=$(modprobe $MPARGS --set-version $kernel --show-depends $1 2>/dev/null | awk '/^insmod / { print $2; }' | tail -1)
-    if [ -n "$fmPath" -a -f "$fmPath" ]; then
-        return 0
-    fi
-    for modExt in o.gz o ko ; do
-        for modDir in /lib/modules/$kernel/updates /lib/modules/$kernel ; do
-            if [ -d $modDir ]; then
-                fmPath=$(find $modDir -name $1.ko |awk {'print $1; exit;'})
-                if [ -n "$fmPath" -a -f "$fmPath" ]; then
-                    return 0
-                fi
-            fi
-        done
+modcat="/lib/modules/$kernel/modules"
+instmods() {
+    local mod mpargs modpath modname cmd
+    while (($# > 0)); do
+	mod=${1%.ko}
+	case $mod in
+	    =ata) instmods $mpargs $(cat "${modcat}.block" |egrep 'ata|ahci');;
+	    =*) instmods $mpargs $(cat "${modcat}.${mod#=}");;
+	    --*) mpargs+=" $mod";;
+	    *) modprobe $mpargs --set-version $kernel --show-depends $mod \
+		2>/dev/null |while read cmd modpath; do
+		    [[ $cmd = insmod ]] || continue
+		    modname=${modpath##*/}
+		    modname=${modname%.ko}
+		    [[ ${mod/-/_} != ${modname/-/_} ]] && {
+			instmods $mpargs $modname
+			continue
+		    }
+		    inst "$modpath" "$initdir" "/lib/modules/$kernel/$modname.ko"
+		done
+		;;
+	esac
+	shift
     done
-    return 1
-}
-
-resolveAndExpandModules() {
-    items=$*
-
-    mods=$(expandModules $items)
-    resdeps mods
-    echo $resolved
-}
-
-expandModules() {
-    items=$*
-
-    for m in $items ; do
-	char=$(echo $m | cut -c1)
-	if [ $char = '=' ]; then
-	    NAME=$(echo $m | cut -c2-)
-	    if [ "$NAME" = "ata" ]; then
-		MODS="$MODS $(cat /lib/modules/$kernel/modules.block |egrep '(ata|ahci)' |sed -e 's/.ko//')"
-	    else
-                # Ignore if group list does not exist
-                if [ -e /lib/modules/$kernel/modules.$NAME ]; then
-		    MODS="$MODS $(cat /lib/modules/$kernel/modules.$NAME |sed -e 's/.ko//')"
-                fi
-	    fi
-	else
-	    MODS="$MODS $m"
-	fi
-    done
-    echo $MODS
-}
-
-installmodule()
-{
-    MPARGS=""
-    if [ "$1" == "--ignore-install" ]; then
-        MPARGS="$MPARGS --ignore-install"
-        shift
-    fi
-    MODULE=$1
-    MNTIMAGE=$2
-    fmPath=""
-    locatemodule $MPARGS $MODULE
-    MODULE=$fmPath
-    if [ -z "$MODULE" ]; then
-        return
-    fi
-    if [ -x /usr/bin/strip ]; then
-        /usr/bin/strip -g  $MODULE -o $MNTIMAGE/lib/modules/$kernel/$(basename $MODULE)
-    else
-        inst "$MODULE" "$MNTIMAGE" "/lib/modules/$kernel/$(basename $MODULE)"
-    fi
-    for fw in $(/sbin/modinfo -F firmware $MODULE 2>/dev/null); do
+    for fw in $(/sbin/modinfo -F firmware $mod 2>/dev/null); do
         if [ -f /lib/firmware/$fw ]; then
-            inst "/lib/firmware/$fw" "$MNTIMAGE" "/lib/firmware/$fw"
+            inst_simple "/lib/firmware/$fw"
         fi
     done
-}
-
-# This loops to make sure it resolves dependencies of dependencies of...
-resdeps () {
-    modlist="$1"
-
-    before=1
-    after=2
-
-    items=$(eval echo \${$modlist})
-    while [ $before != $after ]; do
-        before=$(echo $items | wc -c)
-        list=""
-
-        for i in $items ; do
-            deps=""
-            moduledep $i
-            list="$list $deps"
-        done
-        items=$(for n in $items $list; do echo $n; done | sort -u)
-        after=`echo $items | wc -c`
-    done
-
-    resolved="$items"
-}
+} 
 
 findkeymap () {
     local MAP=$1
-
-    if [ ! -f "$MAP" ]; then
-        MAP=$(find /lib/kbd/keymaps -type f -name $MAP -o -name $MAP.\* | head -n1)
-    fi
-
-    case " $KEYMAPS " in
-        *" $MAP "*)
-            return
-            ;;
-    esac
-
+    [[ ! -f $MAP ]] && \
+	MAP=$(find /lib/kbd/keymaps -type f -name $MAP -o -name $MAP.\* | head -n1)
+    [[ " $KEYMAPS " = *" $MAP "* ]] && return
     KEYMAPS="$KEYMAPS $MAP"
-
     case $MAP in
-        *.gz)
-            cmd=zgrep
-            ;;
-        *.bz2)
-            cmd=bzgrep
-            ;;
-        *)
-            cmd=grep
-            ;;
+        *.gz) cmd=zgrep;;
+        *.bz2) cmd=bzgrep;;
+        *) cmd=grep ;;
     esac
 
     for INCL in $($cmd "^include " $MAP | cut -d' ' -f2 | tr -d '"'); do
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
