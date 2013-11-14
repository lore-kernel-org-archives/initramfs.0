From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] kernel-modules: Add ohci-pci module needed in (at least) kernel 3.12.0
Date: Thu, 14 Nov 2013 08:05:31 +0000
Message-ID: <1384416331-22482-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

https://bugs.mageia.org/show_bug.cgi?id=11645
---
 modules.d/90kernel-modules/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 2100336..e2aa952 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -37,7 +37,7 @@ installkernel() {
         }
 
         hostonly='' instmods sr_mod sd_mod scsi_dh ata_piix \
-            ehci-hcd ehci-pci ehci-platform ohci-hcd uhci-hcd xhci-hcd hid_generic \
+            ehci-hcd ehci-pci ehci-platform ohci-hcd ohci-pci uhci-hcd xhci-hcd hid_generic \
             unix
 
         instmods yenta_socket scsi_dh_rdac scsi_dh_emc \
-- 
1.8.4.3
