From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] Modify instmods to not rely on the existence of modules.* files
Date: Wed, 04 Mar 2009 18:51:36 -0800 (PST)
Message-ID: <c79c304ad7c2ef19b138c43f89f9b7244b57a6f4.1236220864.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=x69FAk3zQzFg6/mxxIJf/CcHhqVETxqBhc49sGPDRjo=;
        b=S4cKPFY3B3lvZheLYakCMER4Fb4kyEAbNg2wfOHjiEKySwFqSHlz9lo3BqxVmxbuRu
         zgRm2Bm8glJdzG2K4rj8vLxQzTJ/ywLIPW0k70FpQHLtd4G9BvC3HWaQ+2l244gFDxsL
         mw/Te+6BplaPpycOrS+TcFNxxFAF6fnhjzHuU=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch series is a resend of the distro independence patch series I sent
earlier today.  It takes into account some of the feedback I recieved from the
previous patch series, and callously ignores the rest because I am a mean, lazy
coder. :)

It applies on top of the hookify-finding-root patch series, and is avaialble
as the distro-independence branch at git://git.fnordovax.org/dracut

depmod does not create these files on all distros (Debian, specifically),
so modify instmods to use pathname components and find to do what we want.

As a bonus, this removes the special-case for =ata.
---
 dracut-functions |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 852ce36..4a98019 100755
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
 	case $mod in
-	    =ata) instmods $mpargs $(cat "${modcat}.block" |egrep 'ata|ahci');;
-	    =*) instmods $mpargs $(cat "${modcat}.${mod#=}");;
+	    =*) instmods $mpargs $(find "$srcmods" -path "*/${mod#=}/*");;
 	    --*) mpargs+=" $mod";;
-	    *) modprobe $mpargs --set-version $kernel --show-depends $mod \
-		2>/dev/null |while read cmd modpath; do
+            *)  mod=${mod##*/}
+	        modprobe $mpargs --set-version $kernel --show-depends $mod \
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
