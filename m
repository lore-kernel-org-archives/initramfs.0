From: mwilck-IBi9RG/b67k@public.gmane.org
Subject: [PATCH 2/2] 90kernel-modules: remove nfit from static module list
Date: Thu, 30 Jan 2020 16:18:21 +0100
Message-ID: <20200130151821.24042-2-mwilck@suse.com>
References: <20200130151821.24042-1-mwilck@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200130151821.24042-1-mwilck-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Daniel Molkentin <dmolkentin-l3A5Bk7waGM@public.gmane.org>, Thomas Blume <Thomas.Blume-IBi9RG/b67k@public.gmane.org>, Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>, Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Martin Wilck <mwilck-IBi9RG/b67k@public.gmane.org>

The 90nvdimm module now resolves the nfit dependency when it's
necessary, so it's not necessary any more to pack it always.
---
 modules.d/90kernel-modules/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 7ae8813..d8c7d43 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -28,7 +28,7 @@ installkernel() {
         hostonly='' instmods sr_mod sd_mod scsi_dh ata_piix
         instmods \
             scsi_dh_rdac scsi_dh_emc scsi_dh_alua \
-            =ide nvme vmd nfit \
+            =ide nvme vmd \
             virtio_blk
 
         dracut_instmods -o -s "${_blockfuncs}" "=drivers"
-- 
2.25.0

