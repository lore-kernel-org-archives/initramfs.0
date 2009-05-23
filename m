From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] Style cleanups in main dracut script.
Date: Fri, 22 May 2009 19:24:29 -0700 (PDT)
Message-ID: <97274286f3d147cdb21897569d71a1cf5ff4eb07.1243045308.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=Eeldn5cp0wTWa2u3MSLQQB70YuIp7CFpP6FXy2H6HuU=;
        b=gf83XP/5gG/GgV9B4+OQ2mt3KNO4e17ihPbunIag9owdzt4hN3Rl2VpS7n4FGQtrxR
         ergOGmOsTKzn64klZIfAKKehtNtrVtuKgaDVvV7/aQhDAORUN0ySo+SJjqYf4QOwccoF
         4jQVBtvNmRig8QiioLR8jhe0dCU4q+yaFpPkI=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch series applies on top of my previous patch series, and
is mainly concerned with coding style updates and better documentation.

Apparently [[ ]] && { ; } type flow control is scary, so translate
most instances of them into standard if-then and case constructs.
---
 dracut |   39 ++++++++++++++++++++++++---------------
 1 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/dracut b/dracut
index 0170fbb..e024fa4 100755
--- a/dracut
+++ b/dracut
@@ -57,8 +57,13 @@ while (($# > 0)); do
     shift
 done
 
-[[ -f $conffile ]] || ( [[ -f /etc/dracut.conf ]] && conffile="/etc/dracut.conf" )
+# if we were not passed a config file, try the default one
+[[ ! -f $conffile ]] && conffile="/etc/dracut.conf"
+
+# source our config file
 [[ -f $conffile ]] && . "$conffile"
+
+# these options override the stuff in the config file
 [[ $dracutmodules_l ]] && dracutmodules=$dracutmodules_l
 [[ $omit_dracutmodules_l ]] && omit_dracutmodules=$omit_dracutmodules_l
 [[ $modules_l ]] && modules=$modules_l
@@ -74,16 +79,18 @@ fi
 dracutfunctions=$dsrc/dracut-functions
 export dracutfunctions
 
-[[ $dracutmodules ]] || dracutmodules="auto"
-[[ $dracutmodules = "auto" ]] && {
-    dracutmodules="all"
-    skipmissing="yes"
-}
-[[ $dracutmodules = "hostonly" ]] && {
-    dracutmodules="all"
-    skipmissing="yes"
-    hostonly="-h"
-}
+# this logic is weird and convoluted.  We should simplify it.
+case $dracutmodules in
+	""|auto)
+		dracutmodules="all"
+    		skipmissing="yes"
+		;;
+	hostonly)
+    		dracutmodules="all"
+    		skipmissing="yes"
+    		hostonly="-h"
+		;;
+esac
 
 
 [[ $2 ]] && kernel=$2 || kernel=$(uname -r)
@@ -106,6 +113,8 @@ for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do
     mkdir -p "$initdir/$d"; 
 done
 
+# these bits are fugly, and need some cleanup.
+# Actually documenting how dracut modules work these days would be good.
 skip_missing() {
     # $1 = location of module
     [[ $skipmissing ]] || return 0
@@ -134,18 +143,18 @@ unset moddir
 ## final stuff that has to happen
 
 # generate module dependencies for the initrd
-/sbin/depmod -a -b "$initdir" $kernel || {
+if ! /sbin/depmod -a -b "$initdir" $kernel; then
     echo "\"/sbin/depmod -a $kernel\" failed."
     exit 1
-}
+fi
 
 # make sure that library links are correct and up to date
 ldconfig -n -r "$initdir" /lib* /usr/lib*
 
-[[ $include_src && $include_target ]] && {
+if [[ $include_src && $include_target ]]; then
     mkdir -p "$initdir$include_target"
     cp -a -t "$initdir$include_target" "$include_src"/*
-}
+fi
 
 [[ "$beverbose" = "yes" ]] && (du -c "$initdir" | sort -n)
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
