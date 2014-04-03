From: Julian Wolf <juwolf-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH] udev-rules: include 59-scsi-sg3_utils.rules
Date: Thu, 03 Apr 2014 14:55:19 +0200
Message-ID: <5313441.RfDPQevkKo@e117>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Without the 59-scsi-sg3_utils.rules udev-rule a couple of devices are missing 
in /dev/disk/by-id.

If the luks device is specified by-id in /etc/crypttab and rd.luks.uuid not 
passed as a commandline parameter during boot, systemd tries to start its 
crypto services which depend on those missing devices until it times out and 
exits to dracut rescue shell.

Signed-off-by: Julian Wolf <juwolf-IBi9RG/b67k@public.gmane.org>
---
 modules.d/95udev-rules/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-
rules/module-setup.sh
index 2d36712..fab4ffc 100755
--- a/modules.d/95udev-rules/module-setup.sh
+++ b/modules.d/95udev-rules/module-setup.sh
@@ -32,6 +32,7 @@ install() {
         60-pcmcia.rules \
         50-udev.rules 95-late.rules \
         50-firmware.rules \
+        59-scsi-sg3_utils.rules \
         75-net-description.rules \
         80-net-name-slot.rules 80-net-setup-link.rules \
         "$moddir/59-persistent-storage.rules" \
-- 
1.8.1.4
