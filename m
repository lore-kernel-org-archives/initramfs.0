From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 42/42] dracut: nbd: Only complain of missing binary in hostonly mode if
Date: Thu, 11 Dec 2014 15:46:33 +0100
Message-ID: <1418309193-11208-43-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

 rootfs is on nbd

In not hostonly mode, require_binaries will still complain.
If in hostonly mode and the module is explicitly added via -a nbd, then
install() section will still complain later:
dracut-install: ERROR: installing 'nbd-client'

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95nbd/module-setup.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/modules.d/95nbd/module-setup.sh b/modules.d/95nbd/module-setup.sh
index 4f9e350..3cb6f49 100755
--- a/modules.d/95nbd/module-setup.sh
+++ b/modules.d/95nbd/module-setup.sh
@@ -3,8 +3,6 @@
 # called by dracut
 check() {
     local _rootdev
-    # If our prerequisites are not met, fail.
-    require_binaries nbd-client || return 1
 
     # if an nbd device is not somewhere in the chain of devices root is
     # mounted on, fail the hostonly check.
@@ -15,6 +13,7 @@ check() {
         [[ -b /dev/block/$_rootdev ]] || return 1
         check_block_and_slaves is_nbd "$_rootdev" || return 255
     }
+    require_binaries nbd-client || return 1
 
     return 0
 }
-- 
1.8.5.2
