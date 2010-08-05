From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] Fix ahci detection in kernel 2.6.35
Date: Thu, 05 Aug 2010 20:06:57 +0400
Message-ID: <20100805160657.29650.45441.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Kernel 2.6.35 (may be, earlier) split ahci into libahci.ko and ahci.ko
and added ahci_platform.ko. As a result, drivers ahci and ahci_platform
do not contain any symbol that are checked for storage modules (it is
libahci.ko that references ata_scsi_ioctl now). So add additional
symbol ahci_init_controller; it seems this is expected to be called by
every driver based on libahci.ko.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 modules.d/90kernel-modules/installkernel |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90kernel-modules/installkernel b/modules.d/90kernel-modules/installkernel
index 2171e5a..e679b10 100755
--- a/modules.d/90kernel-modules/installkernel
+++ b/modules.d/90kernel-modules/installkernel
@@ -1,7 +1,7 @@
 #!/bin/bash
 if [[ -z $drivers ]]; then
     block_module_test() {
-	local blockfuncs='ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device'
+	local blockfuncs='ahci_init_controller|ata_scsi_ioctl|scsi_add_host|blk_init_queue|register_mtd_blktrans|scsi_esp_register|register_virtio_device'
 
 	egrep -q "$blockfuncs" "$1"
     }
