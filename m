From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] kernel-modules: Drop explicit modules that are found with block_module_filter
Date: Sun, 26 Oct 2014 11:48:15 +0000
Message-ID: <1414324095-29818-1-git-send-email-pbrobinson@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZyCoQPKBR2NLdyut9qcVYzHIyidkv5ppC+JehmFTOGM=;
        b=Y0CzeaR4wL7wokYx2RjReaBIR1eV50efI8+oiDqeJtqV2zLe7Tt6yMcfMkW9ABueB/
         p9hMw6dFkkSeRRjCWwQC4zalOoEFIlyoocxrPe/kTYe9DsYBkUzBlQnjq3/9uZnPtVsW
         drVnRm1t4cCmz9h00icJjDCpSr0ZUZtEEu12KaYTgAHyMRQfcUWlM/n8eF03Bxl0NKTq
         nld9WUXsW4H3oCpVpsv5vAemBwCrJk+pfuWponlDNhScCDdM9PU64My9cAAWeyxjF5Vo
         EJaWE4651ljg35IwcgQIPfv1lWGxwzlhosimNZe9EEXDS+yT8txjqDnAK+iHStjsbznB
         JKTQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The usb_storage, nvme and sdhci_acpi modules are discovered with the
block_module_filter so there's no need to explicitly list them here.

Signed-off-by: <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/90kernel-modules/module-setup.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 83b8995..2fa263c 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -44,8 +44,7 @@ installkernel() {
         instmods yenta_socket scsi_dh_rdac scsi_dh_emc \
             atkbd i8042 usbhid hid-apple hid-sunplus hid-cherry hid-logitech \
             hid-logitech-dj hid-microsoft hid-lcpower firewire-ohci \
-            pcmcia usb_storage nvme hid-hyperv hv-vmbus \
-            sdhci_acpi hyperv-keyboard
+            pcmcia hid-hyperv hv-vmbus hyperv-keyboard
 
         if [[ "$(uname -p)" == arm* ]]; then
             # arm specific modules
-- 
2.1.0
