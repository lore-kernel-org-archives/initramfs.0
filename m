From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] return proper value in function dracut_install
Date: Mon, 8 Oct 2012 17:40:08 +0800
Message-ID: <20121008094008.GA19986@localhost.localdomain>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

dracut_install should return the real return value, so module install function
can detect the install failure.

Such as below in 99base:
dracut_install switch_root || dfatal "Failed to install switch_root"

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- dracut.orig/dracut-functions.sh
+++ dracut/dracut-functions.sh
@@ -563,9 +563,12 @@ if [[ $DRACUT_INSTALL ]]; then
     }
 
     dracut_install() {
+        local ret
         #dinfo "initdir=$initdir $DRACUT_INSTALL -l $@"
         $DRACUT_INSTALL ${initdir+-D "$initdir"} -a ${DRACUT_RESOLVE_DEPS+-l}  ${DRACUT_FIPS_MODE+-H} "$@"
-        (($? != 0)) && derror $DRACUT_INSTALL ${initdir+-D "$initdir"} -a ${DRACUT_RESOLVE_DEPS+-l}  ${DRACUT_FIPS_MODE+-H} "$@" || :
+        ret=$?
+        (($ret != 0)) && derror $DRACUT_INSTALL ${initdir+-D "$initdir"} -a ${DRACUT_RESOLVE_DEPS+-l}  ${DRACUT_FIPS_MODE+-H} "$@" || :
+        return $ret
     }
 
     inst_library() {
