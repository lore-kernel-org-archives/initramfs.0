From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 03/13] 95dasd_mod: make dasd_cio_free optional
Date: Fri, 29 Nov 2013 13:13:44 +0100
Message-ID: <1385727234-5001-4-git-send-email-hare@suse.de>
References: <1385727234-5001-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385727234-5001-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
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
 modules.d/95dasd_mod/module-setup.sh   | 3 ++-
 modules.d/95dasd_mod/parse-dasd-mod.sh | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/modules.d/95dasd_mod/module-setup.sh b/modules.d/95dasd_mod/module-setup.sh
index 011010d..8fde525 100755
--- a/modules.d/95dasd_mod/module-setup.sh
+++ b/modules.d/95dasd_mod/module-setup.sh
@@ -23,6 +23,7 @@ installkernel() {
 # called by dracut
 install() {
     inst_hook cmdline 31 "$moddir/parse-dasd-mod.sh"
-    inst_multiple dasd_cio_free grep sed seq
+    inst_multiple grep sed seq
+    inst_multiple -o dasd_cio_free
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
