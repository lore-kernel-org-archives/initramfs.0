From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] Modify instmods to not rely on the existence of modules.* files
Date: Tue, 03 Mar 2009 16:21:10 -0800 (PST)
Message-ID: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=K9M0dnoXz8BUTpnM9NTQ39lmG0sW4FoH6cC/nH7WQAI=;
        b=rrYU4NIGRydcHo46VR0NDBYI/vP4e8ZlnzRYP2Hu/IjkGQPgM8qrWgtvWe3wUwOVJE
         m/aScEc6T0T4gGTDJIgIk9v6ir/tttOiLPSJnLLxMfmD+Aj5yrKhIxnlWf9HWl3lmTJB
         nlmxIorwFEPWUjYSzQqZDQ5xAOANEbJWXJ+eI=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch series aims to make dracut more distro-independent.  It includes
some of the functionality that Seewer Philippe posted to the list to make 
dracut work on Ubuntu.

depmod does not create these files on all distros (Debian, specifically),
so modify instmods to use pathname components and find to do what we want.

As a bonus, this removes the special-case for =ata.
---
 dracut-functions |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 852ce36..f40694e 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -167,17 +167,17 @@ dracut_install() {
     done
 }
 
-modcat="/lib/modules/$kernel/modules"
+srcmods="/lib/modules/$kernel/"
 instmods() {
     local mod mpargs modpath modname cmd
     while (($# > 0)); do
 	mod=${1%.ko}
+	mod=${mod##*/}
 	case $mod in
-	    =ata) instmods $mpargs $(cat "${modcat}.block" |egrep 'ata|ahci');;
-	    =*) instmods $mpargs $(cat "${modcat}.${mod#=}");;
+	    =*) instmods $mpargs $(find "$srcmods" -path "*/${mod#=}/*");;
 	    --*) mpargs+=" $mod";;
 	    *) modprobe $mpargs --set-version $kernel --show-depends $mod \
-		2>/dev/null |while read cmd modpath; do
+		2>/dev/null |while read cmd modpath options; do
 		    [[ $cmd = insmod ]] || continue
 		    modname=${modpath##*/}
 		    modname=${modname%.ko}
@@ -185,7 +185,7 @@ instmods() {
 			instmods $mpargs $modname
 			continue
 		    }
-		    inst_simple "$modpath" "/lib/modules/$kernel/$modname.ko"
+		    inst_simple "$modpath"
 		done
 		;;
 	esac
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
