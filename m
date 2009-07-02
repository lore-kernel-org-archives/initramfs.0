From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Don't use absolute paths for utilities
Date: Thu, 2 Jul 2009 16:03:39 +0200
Message-ID: <4A4CBE3B.10703@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

diff --git a/dracut b/dracut
index 826fbda..1d440ef 100755
--- a/dracut
+++ b/dracut
@@ -61,6 +61,8 @@ while (($# > 0)); do
     shift
 done
 
+PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
+
 [[ $debug ]] && { 
     export PS4='${BASH_SOURCE}@${LINENO}(${FUNCNAME[0]}): ';
     set -x
@@ -138,8 +140,8 @@ echo $mods_to_load
 ## final stuff that has to happen
 
 # generate module dependencies for the initrd
-if ! /sbin/depmod -a -b "$initdir" $kernel; then
-    echo "\"/sbin/depmod -a $kernel\" failed."
+if ! depmod -a -b "$initdir" $kernel; then
+    echo "\"depmod -a $kernel\" failed."
     exit 1
 fi
 
diff --git a/dracut-functions b/dracut-functions
index 8fbfa97..e525179 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -307,7 +307,7 @@ instmods() {
 		    fi
 		    inst_simple "$modpath"
 		done
-		for fw in $(/sbin/modinfo -F firmware $mod 2>/dev/null); do
+		for fw in $(modinfo -F firmware $mod 2>/dev/null); do
 		    if [[ -f /lib/firmware/$fw ]]; then
 			inst_simple "/lib/firmware/$fw"
 		    else
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
