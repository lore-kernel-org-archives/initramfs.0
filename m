From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 03/10] 95dasd_mod: make dasd_cio_free optional
Date: Wed, 27 Nov 2013 16:44:14 +0100
Message-ID: <1385567061-13247-4-git-send-email-hare@suse.de>
References: <1385567061-13247-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385567061-13247-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

dasd_cio_free is a RedHat-specific tool, so make it optional.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 dracut-functions.sh                    | 9 +++++++++
 modules.d/95dasd_mod/module-setup.sh   | 3 ++-
 modules.d/95dasd_mod/parse-dasd-mod.sh | 4 +++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 2872516..c2cf67a 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -741,6 +741,15 @@ inst_multiple() {
     return $ret
 }
 
+inst_multiple_optional() {
+    local ret
+        #dinfo "initdir=$initdir $DRACUT_INSTALL -l $@"
+    $DRACUT_INSTALL ${initdir:+-D "$initdir"} -o -a ${DRACUT_RESOLVE_DEPS:+-l}  ${DRACUT_FIPS_MODE:+-H} "$@"
+    ret=$?
+    (($ret != 0)) && derror $DRACUT_INSTALL ${initdir:+-D "$initdir"} -o -a ${DRACUT_RESOLVE_DEPS:+-l}  ${DRACUT_FIPS_MODE:+-H} "$@" || :
+    return $ret
+}
+
 dracut_install() {
     inst_multiple "$@"
 }
diff --git a/modules.d/95dasd_mod/module-setup.sh b/modules.d/95dasd_mod/module-setup.sh
index 011010d..4546059 100755
--- a/modules.d/95dasd_mod/module-setup.sh
+++ b/modules.d/95dasd_mod/module-setup.sh
@@ -23,6 +23,7 @@ installkernel() {
 # called by dracut
 install() {
     inst_hook cmdline 31 "$moddir/parse-dasd-mod.sh"
-    inst_multiple dasd_cio_free grep sed seq
+    inst_multiple grep sed seq
+    inst_multiple_optional dasd_cio_free
 }
 
diff --git a/modules.d/95dasd_mod/parse-dasd-mod.sh b/modules.d/95dasd_mod/parse-dasd-mod.sh
index 87c88ed..0236d12 100755
--- a/modules.d/95dasd_mod/parse-dasd-mod.sh
+++ b/modules.d/95dasd_mod/parse-dasd-mod.sh
@@ -15,4 +15,6 @@ if [ -n "$mod_args" ]; then
 fi
 
 unset dasd_arg
-dasd_cio_free
+if [ -x /sbin/dasd_cio_free ] ; then
+    dasd_cio_free
+fi
-- 
1.8.1.4
