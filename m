From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] kernel-modules: Fix storage module selection for sdhci/mmc/ahci
Date: Fri, 23 May 2014 12:28:22 +0100
Message-ID: <1400844502-4753-1-git-send-email-pbrobinson@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Rv+JdhdKgyLPCPUTNs+i79/DNOn7TlE83v3yGJfN+VE=;
        b=LfhZ3Sq0P3xCtLRNEiAQzRwn8x5DB8Zyjpq4KjmREtSSyUpi1KdPgLlybcwe9HTJgf
         D+P4UnEYL42iYxmkdPXfoujqxRGp2/+mug9N6OdmG8p7IZ3H3dRqT8DkGgKqvPbcImF+
         gAGFDxfFh8wiaBZ4mDRDjtTMiveGKOicJETGwC60Q4/rnt2IClHNnl9OwLx9xGnuZdVd
         FPkcHwqNsr2R6zkxVAuxO1+Jh25yxqlqQAAMVqQA9uaGKk5JWH26eqBUOzvOGexOtCy9
         /2/pcArIjXc3K7TfRrb0AKJEaGALh1Uo0PhHAIJFk17PB9eHnypEa9EAbfM4tUWYejtV
         qqqA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Currently the block driver detection for generic initrd doesn't include
the SD/MMC drivers so we fail to boot generic images on any device using
those platforms as boot devices when using a generic initrd. Add logic
to detect those modules. This primarily fixes embedded ARM devices but
also likely intel tablets/dev boards and enterprise hypervisors that
have the ability to boot from SD.

Also the ahci_init_controller misses a number of drivers that use the
libahci_platform module for the init so this fixes some missing achi
moduless too.

Finally it cleans up the ARM storage module hacks that the above now
deals with in a more generic manner.

Signed-off-by: <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/90kernel-modules/module-setup.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 2378663..5271438 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -6,7 +6,7 @@
 installkernel() {
     if [[ -z $drivers ]]; then
         block_module_filter() {
-            local _blockfuncs='ahci_init_controller|ata_scsi_ioctl|scsi_add_host|blk_cleanup_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device|usb_stor_disconnect'
+            local _blockfuncs='ahci_platform_get_resources|ata_scsi_ioctl|scsi_add_host|blk_cleanup_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device|usb_stor_disconnect|mmc_add_host|sdhci_pltfm_init'
             # subfunctions inherit following FDs
             local _merge=8 _side2=9
             function bmf1() {
@@ -51,9 +51,7 @@ installkernel() {
 
         if [[ "$(uname -p)" == arm* ]]; then
             # arm specific modules
-            hostonly='' instmods sdhci_esdhc_imx mmci sdhci_tegra mvsdio omap omapdrm \
-                omap_hsmmc panel-tfp410 sdhci_dove ahci_platform pata_imx sata_mv \
-                ehci-tegra mmc_block usb_storage
+            hostonly='' instmods omapdrm panel-tfp410
         fi
 
         # install virtual machine support
-- 
1.9.3
