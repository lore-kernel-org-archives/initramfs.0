From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] kernel-modules: increase SDHCI driver inclusion
Date: Thu, 15 Jan 2015 11:27:47 -0600
Message-ID: <1421342867-6104-1-git-send-email-drake@endlessm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

The sdhci-pci module is currently not being included in the initramfs,
even though other sdhci modules are. This breaks boot on systems that
rely on this driver to access the root filesystem.

Instead of looking for modules that use sdhci_pltfm_init, look for
sdhci_add_host. I checked 3.18 kernel sources, and this change
does not remove any of the previously-matched SDHCI drivers.
It should result in the addition of sdhci-pci, sdhci-s3c, sdhci-spear
and sdhci-acpi.
---
 modules.d/90kernel-modules/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 5e292b0..a7b0853 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -4,7 +4,7 @@
 installkernel() {
     if [[ -z $drivers ]]; then
         block_module_filter() {
-            local _blockfuncs='ahci_platform_get_resources|ata_scsi_ioctl|scsi_add_host|blk_cleanup_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device|usb_stor_disconnect|mmc_add_host|sdhci_pltfm_init'
+            local _blockfuncs='ahci_platform_get_resources|ata_scsi_ioctl|scsi_add_host|blk_cleanup_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device|usb_stor_disconnect|mmc_add_host|sdhci_add_host'
             # subfunctions inherit following FDs
             local _merge=8 _side2=9
             function bmf1() {
-- 
2.1.0
