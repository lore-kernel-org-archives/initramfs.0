From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] Changed multiline conditional lists to if statements in dracut-functions
Date: Fri, 22 May 2009 19:24:31 -0700 (PDT)
Message-ID: <c8c67f682505552375405328bfd7483283507798.1243045308.git.victor.lowther@gmail.com>
References: <97274286f3d147cdb21897569d71a1cf5ff4eb07.1243045308.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=5HWWTMl7NswLPPXBl6KWgAGmF9hnJtZ2g1ny+2HUVmI=;
        b=IXtl/LhtCdlAxHrfMfzqKgAPmIQSfI7tWosgOADlTNwKLsFmqVcvmqmmk0PCbk3PG/
         unLKpliiXMkaetTaVxmUusedQmadILXbtizlN4Jr6Qx+99NGIh92jXi5DOFyw197+sUx
         IOT8K9R083bURaISrsOC70VgOrUT64Rx1Mx/Y=
In-Reply-To: <97274286f3d147cdb21897569d71a1cf5ff4eb07.1243045308.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

It seems that some people object to multiline conditional lists.
Oh, well, no accounting for taste.

---
 dracut-functions |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 2beaef2..16ec7d0 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -93,17 +93,17 @@ inst_binary() {
     # I love bash!
     ldd $bin 2>/dev/null | while read line; do
 	[[ $line = 'not a dynamic executable' ]] && return 1
-	[[ $line =~ not\ found ]] &&{
+	if [[ $line =~ not\ found ]]; then
 	    derror "Missing a shared library required by $bin."
 	    derror "Run \"ldd $bin\" to find out what it is."
 	    derror "dracut cannot create an initrd."
 	    exit 1
-	} 
+	fi
 	[[ $line =~ ([^ ]*/lib[^/]*/[^ ]*\.so[^ ]*) ]] || continue
 	FILE=${BASH_REMATCH[1]}
 	[[ -f ${initdir}$FILE ]] && continue
 	# see if we are loading an optimized version of a shared lib.
-	[[ $FILE =~ ^(/lib[^/]*).* ]] && {
+	if [[ $FILE =~ ^(/lib[^/]*).* ]]; then
             TLIBDIR=${BASH_REMATCH[1]}
             BASE="${FILE##*/}"
 	    # prefer nosegneg libs, then unoptimized ones.
@@ -115,7 +115,7 @@ inst_binary() {
 	    inst_library "$FILE" "$TLIBDIR/$BASE"
             IF_dynamic="yes"
 	    continue
-	}
+	fi
         inst_library "$FILE" 
     done
     inst_simple "$bin" "$target"
@@ -179,15 +179,14 @@ inst() {
 # $1 = type of hook, $2 = hook priority (lower runs first), $3 = hook
 # All hooks should be POSIX/SuS compliant, they will be sourced by init.
 inst_hook() {
-    [[ -f $3 ]] || {
+    if ! [[ -f $3 ]]; then
 	derror "Cannot install a hook ($3) that does not exist."
 	derror "Aborting initrd creation."
 	exit 1
-    }
-    strstr "$hookdirs" "$1" || {
+    elif ! strstr "$hookdirs" "$1"; then
 	derror "No such hook type $1. Aborting initrd creation." 
 	exit 1
-    }
+    fi
     inst_simple "$3" "/${1}/${2}${3##*/}"
 }
 
@@ -227,10 +226,10 @@ instmods() {
 		    [[ $cmd = insmod ]] || continue
 		    modname=${modpath##*/}
 		    modname=${modname%.ko}
-		    [[ ${mod/-/_} != ${modname/-/_} ]] && {
+		    if [[ ${mod/-/_} != ${modname/-/_} ]]; then
 			instmods $mpargs $modname
 			continue
-		    }
+		    fi
 		    inst_simple "$modpath"
 		done
 		;;
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
