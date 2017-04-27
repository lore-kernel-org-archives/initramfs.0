From: Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] arm64: mmc drivers
Date: Wed, 26 Apr 2017 21:59:29 -0500
Message-ID: <20170427025929.10982-1-lintonrjeremy@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

It is common for arm64 devices to boot from mmc & sd devices
we need to assure that those drivers make it to the initrd.

Signed-off-by: Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/90kernel-modules/module-setup.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index b1bced69..863ce932 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -25,10 +25,12 @@ installkernel() {
 
 	if [[ "$(uname -m)" == arm* || "$(uname -m)" == aarch64 ]]; then
             # arm/aarch64 specific modules
+            _blockfuncs+='|dw_mc_probe|dw_mci_pltfm_register' 
             instmods \
                 "=drivers/clk" \
                 "=drivers/dma" \
                 "=drivers/i2c/busses" \
+                "=drivers/mfd" \
                 "=drivers/phy" \
                 "=drivers/power" \
                 "=drivers/regulator" \
-- 
2.12.2
