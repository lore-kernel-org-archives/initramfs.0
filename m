From: Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] arm64: mmc drivers
Date: Thu, 20 Apr 2017 01:58:47 -0500
Message-ID: <20170420065847.18368-1-lintonrjeremy@gmail.com>
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
 modules.d/90kernel-modules/module-setup.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index b1bced69..5d022a9b 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -29,6 +29,9 @@ installkernel() {
                 "=drivers/clk" \
                 "=drivers/dma" \
                 "=drivers/i2c/busses" \
+                "=drivers/mfd" \
+                "=drivers/mmc/core" \
+                "=drivers/mmc/host" \
                 "=drivers/phy" \
                 "=drivers/power" \
                 "=drivers/regulator" \
-- 
2.12.2
