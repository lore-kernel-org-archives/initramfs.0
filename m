From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] priorize -m over dracut.conf, add --modules and get rid of
 automatic use of ./dracut.conf
Date: Sat, 7 Mar 2009 11:53:40 +0100
Message-ID: <49B25234.4020904@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Victor Lowther introduced -c to freely set dracut.conf. Means we can get
rid of automatic use of ./dracut.conf if -l is used, use -c instead.

Second this patch prefers options before config files and adds an option
-d|--drivers to set the modules= option.

Patch is built on top of Harald Hoyers merge tree
(git://git.surfsite.org/pub/git/dracut.git)


---
diff --git a/dracut b/dracut
index d8da6d6..dad6687 100755
--- a/dracut
+++ b/dracut
@@ -11,7 +11,8 @@
 while (($# > 0)); do
     case $1 in
 	-f|--force) force=yes;;
-	-m|--modules) dracutmodules="$2"; shift;;
+	-m|--modules) dracutmodules_l="$2"; shift;;
+	-d|--drivers) modules_l="$2"; shift;;
 	-h|--help) echo "Usage: $0 [-f] <initramfs> <kernel-version>"
 	    exit 1 ;;
 	-v|--verbose) set -x;;
@@ -22,11 +23,12 @@ while (($# > 0)); do
     esac
     shift
 done
-[[ -f $conffile ]] || {
-    conffile="/etc/dracut.conf"
-    [[ $allowlocal && -f dracut.conf ]] && conffile="dracut.conf"
-}
-. "$conffile"
+
+[[ -f $conffile ]] || [[ -f /etc/dracut.conf ]] && conffile="/etc/dracut.conf"
+[[ -f $conffile ]] && . "$conffile"
+
+[[ $dracutmodules_l ]] && dracutmodules=$dracutmodule_l
+[[ $modules_l ]] && modules=$modules_l
 
 [[ $allowlocal && -f dracut-functions ]] && dsrc="." || dsrc=/usr/lib/dracut
 . $dsrc/dracut-functions
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
