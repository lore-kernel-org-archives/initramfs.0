From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 1/3] Add old style ide drivers if available
Date: Fri, 16 Oct 2009 11:00:02 +0200
Message-ID: <1255683604-10667-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

Some distros, including debian unstable with 2.6.30, still ship
old style ide drivers. These should be installed as well.

Sadly there are no symbols to use for nm, so a simple =ide needs
to suffice.
---
 modules.d/90kernel-modules/installkernel |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90kernel-modules/installkernel b/modules.d/90kernel-modules/installkernel
index 2e74a85..b5e4c93 100755
--- a/modules.d/90kernel-modules/installkernel
+++ b/modules.d/90kernel-modules/installkernel
@@ -5,7 +5,7 @@ if [[ -z $drivers ]]; then
 
 	 nm -uPA "$1" | egrep -q "$blockfuncs"
     }
-    instmods pcmcia sd_mod $(filter_kernel_modules block_module_test) "=drivers/pcmcia"
+    instmods pcmcia sd_mod $(filter_kernel_modules block_module_test) "=drivers/pcmcia" =ide
     # if not on hostonly mode, install all known filesystems.
     if [[ $hostonly = '' ]]; then
 	instmods '=fs'
-- 
1.6.0.4
