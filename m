From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/6] kernel-modules: Add ehci support for kernel 3.8+
Date: Wed, 23 Jan 2013 20:15:06 +0000
Message-ID: <1358972106-2395-7-git-send-email-colin@mageia.org>
References: <1358972106-2395-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358972106-2395-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas Backlund <tmb-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

From: Thomas Backlund <tmb-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

Kernel 3.8 split ehci-hcd into ehci-hcd, ehci-pci and ehci-platform,
so adapt the list to cope with this change.
---
 modules.d/90kernel-modules/module-setup.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 633a59d..f75bb61 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -41,7 +41,8 @@ installkernel() {
             sdhci_esdhc_imx mmci sdhci_tegra mvsdio \
             omap omapdrm omap_hsmmc sdhci_dove ahci_platform pata_imx sata_mv \
             atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-logitech \
-            hid-logitech-dj hid-microsoft ehci-hcd ohci-hcd uhci-hcd xhci-hcd hid_generic \
+            hid-logitech-dj hid-microsoft ehci-hcd ehci-pci ehci-platform \
+            ohci-hcd uhci-hcd xhci-hcd hid_generic \
             unix
 
         # install virtual machine support
-- 
1.8.1
