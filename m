From: Olivier Blin <dev-RZzICDNEOQ/YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] 90kernel-modules/module-setup.sh: install xhci-hcd
Date: Thu, 10 May 2012 22:58:22 +0200
Message-ID: <1336683502-5495-1-git-send-email-dev@blino.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Olivier Blin <dev-RZzICDNEOQ/YtjvyW6yDsg@public.gmane.org>

to allow booting and using kbd devices from USB 3.0
---
 modules.d/90kernel-modules/module-setup.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 26f4784..97e1de8 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -36,7 +36,7 @@ installkernel() {
         hostonly='' instmods usb_storage sdhci sdhci-pci
 
         # install keyboard support
-        hostonly='' instmods atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-logitech hid-logitech-dj hid-microsoft ehci-hcd ohci-hcd uhci-hcd
+        hostonly='' instmods atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-logitech hid-logitech-dj hid-microsoft ehci-hcd ohci-hcd uhci-hcd xhci-hcd
         # install unix socket support
         hostonly='' instmods unix
         instmods "=drivers/pcmcia" =ide "=drivers/usb/storage"
-- 
1.7.10
