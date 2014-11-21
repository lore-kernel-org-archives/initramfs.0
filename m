From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 10/15] 90kernel-modules: install scsi_dh_alua
Date: Fri, 21 Nov 2014 14:20:46 +0100
Message-ID: <1416576051-62838-11-git-send-email-trenn@suse.de>
References: <1416576051-62838-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416576051-62838-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Install the missing scsi_dh_alua module, too.

References: bnc#871617

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90kernel-modules/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 2fa263c..1a8fcff 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -41,7 +41,7 @@ installkernel() {
             uhci-hcd \
             xhci-hcd
 
-        instmods yenta_socket scsi_dh_rdac scsi_dh_emc \
+        instmods yenta_socket scsi_dh_rdac scsi_dh_emc scsi_dh_alua \
             atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-logitech \
             hid-logitech-dj hid-microsoft hid-lcpower firewire-ohci \
             pcmcia hid-hyperv hv-vmbus hyperv-keyboard
-- 
1.8.5.2
