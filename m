From: Vaughan Cao <vaughan.cao-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Add hyperv-keyboard kernel module for Hyper-V Gen2 VM
Date: Fri, 26 Sep 2014 18:02:03 +0800
Message-ID: <1411725723-13919-1-git-send-email-vaughan.cao@oracle.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: vaughan.cao-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org

The synthetic keyboard of a Gen2 Linux VM doesn't work before the
hyperv_keyboard module is loaded. Without it, we can't cancel the media check
phase if boot with rd.live.check option.
Gen1 Linux VM doesn't have the same issue because the host emulates the legacy
i8042 keyboard for Gen1 VM.

Signed-off-by: Vaughan Cao <vaughan.cao-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90kernel-modules/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index eea30e6..83b8995 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -45,7 +45,7 @@ installkernel() {
             atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-logitech \
             hid-logitech-dj hid-microsoft hid-lcpower firewire-ohci \
             pcmcia usb_storage nvme hid-hyperv hv-vmbus \
-            sdhci_acpi
+            sdhci_acpi hyperv-keyboard
 
         if [[ "$(uname -p)" == arm* ]]; then
             # arm specific modules
-- 
1.9.0
