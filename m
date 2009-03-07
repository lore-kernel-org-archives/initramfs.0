From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] combine --skip-missing to /check infrastructure
Date: Sat, 7 Mar 2009 12:59:13 +0100
Message-ID: <49B26191.3090300@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This patch introduces --skip-missing to skip modules failing /check,
allowing to use the check infrastructure not only for
dracutmodules="auto". 

Result: dracutmodules="auto" becomes obsolete, automatically setting
dracutmodules="all" and skipmissing="yes"

Patch is built on top of Harald Hoyers merge tree
(git://git.surfsite.org/pub/git/dracut.git) 


---
diff --git a/dracut b/dracut
index d1167e5..2911c9f 100755
--- a/dracut
+++ b/dracut
@@ -18,7 +18,7 @@ while (($# > 0)); do
 	-v|--verbose) set -x;;
 	-c|--conf) conffile="$2"; shift;;
 	-l|--local) allowlocal="yes" ;;
-	--allow-missing) : ;;
+	--skip-missing) skipmissing="yes" ;;
 	*) break ;;
     esac
     shift
@@ -32,7 +32,11 @@ done
 [[ $allowlocal && -f dracut-functions ]] && dsrc="." || dsrc=/usr/lib/dracut
 . $dsrc/dracut-functions
 
-[[ $dracutmodules ]] || dracutmodules="all" 
+[[ $dracutmodules ]] || dracutmodules="auto" 
+[[ $dracutmodules = "auto" ]] && {
+    dracutmodules="all"
+    skipmissing="yes"
+}
 
 
 [[ $2 ]] && kernel=$2 || kernel=$(uname -r)
@@ -59,12 +63,16 @@ can_source_module() {
     # $1 = location of module
     mod=${1##*/}; mod=${mod#[0-9][0-9]};
     case $dracutmodules in
-	all) return 0;;
-	auto) [[ -x $1/check ]] || return 0
-	    "$1/check" >/dev/null 2>&1 && return 0 ;;
-	*) strstr "$dracutmodules " "$mod " && return 0;;
+	all) [[ $skipmissing ]] || return 0;;
+	*) strstr "$dracutmodules " "$mod " || return 1;;
     esac
-    return 1
+
+    [[ $skipmissing ]] && [[ -x $1/check ]] && {
+        return $("$1/check" >/dev/null 2>&1);
+    }
+
+    [[ $skipmissing ]] || return 1
+    return 0
 }
 
 # source all our modules
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
