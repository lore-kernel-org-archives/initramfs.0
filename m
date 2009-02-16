From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 43/50] Use ldd to find shared library deps.
Date: Mon, 16 Feb 2009 14:07:10 -0500
Message-ID: <200902161907.n1GJ7A92028832@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=7d18dca5c1b99cda942c7e0c95a3df2959dea2c2
Commit:     7d18dca5c1b99cda942c7e0c95a3df2959dea2c2
Parent:     15136762359cdf316bfdb62a20d07196b854f417
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:43:14 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 43/50] Use ldd to find shared library deps.
    
    This replaces the eu-readelf and ld-linux.so.2 hackery.
    
    As a bonus it will keep working if we (for some bizzare reason) need
    to load a non-elf executable or shared library on the initrd.
---
 dracut-functions |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 8beba8b..62038f6 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -66,16 +66,10 @@ inst_binary() {
     local bin="$1" target="${2:-$1}"
     local LDSO NAME IO FILE ADDR I1 n f TLIBDIR
     [[ -f $initdir$target ]] && return 0
-
-    LDSO=$(LANG=C eu-readelf -l $bin 2>/dev/null | \
-	awk '/interpreter/ {print $4}' |sed -e 's/]$//')
-    [[ $LDSO && $LDSO != $bin ]] || LDSO="$IF_RTLD"
-    [[ $LDSO && $LDSO != $bin ]] || return 1
-    [[ $IF_RTLD ]] || IF_RTLD="$LDSO"
-
     # I love bash!
-    while read NAME I0 FILE ADDR I1 ; do
-	[[ $FILE = $bin ]] && continue 
+    while read line; do
+	[[ $line =~ '([^ ]*/lib/[^ ]*\.so[^ ]*)' ]] || continue
+	FILE=${BASH_REMATCH[1]}
         [[ $FILE = not || $NAME = not ]] && {
 	    echo "Missing a shared library required by $bin." >&2
 	    echo "dracut cannot create an initrd." >&2
@@ -96,8 +90,7 @@ inst_binary() {
 	    continue
 	}
         inst_library "$FILE" 
-    done < <(LD_TRACE_PRELINKING=1 LD_WARN= LD_TRACE_LOADED_OBJECTS=1 \
-            $LDSO $bin 2>/dev/null)
+    done < <(ldd $bin 2>/dev/null)
     inst_simple "$bin" "$target"
 }
 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
