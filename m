From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 01/10] 95dasd: Install kernel modules only once
Date: Wed, 27 Nov 2013 16:44:12 +0100
Message-ID: <1385567061-13247-2-git-send-email-hare@suse.de>
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

Move kernel module selection to 95dasd_mod and make 95dasd depend
on that module.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95dasd/module-setup.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/modules.d/95dasd/module-setup.sh b/modules.d/95dasd/module-setup.sh
index 861df29..16207bc 100755
--- a/modules.d/95dasd/module-setup.sh
+++ b/modules.d/95dasd/module-setup.sh
@@ -11,15 +11,11 @@ check() {
 
 # called by dracut
 depends() {
+    echo "dasd_mod"
     return 0
 }
 
 # called by dracut
-installkernel() {
-    instmods dasd_mod dasd_eckd_mod dasd_fba_mod dasd_diag_mod
-}
-
-# called by dracut
 install() {
     inst_hook cmdline 30 "$moddir/parse-dasd.sh"
     inst_multiple dasdinfo dasdconf.sh normalize_dasd_arg
-- 
1.8.1.4
