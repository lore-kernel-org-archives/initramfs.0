From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Add ahci_imx to the ARM specific disk drivers
Date: Sat, 23 Nov 2013 19:16:12 +0100
Message-ID: <1385230572-17588-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9Bpzqq/HqtEDLU6oYZ1l9T8ch6wzbmr9k73hKE9ISqQ=;
        b=jAUabc5W3ZgMmst/EEM3lMBUrr4GttphLPRBiS4kIQLjrO2UZZ8eoh7BnGnvjJQ/6j
         tiog/jCPlHi4I5BeJ6ms98ZXV0NsnCznxQuWdiDr73L2EPnBOMHLRmKI669uwxZHL56u
         MbH6iLbmGivlbnr8u6pPrkBnbgOJfDwK8jD/xwu8Amqx6/VAfCe0YECzeO0JuA3JqwfA
         EbFU9Epy8ixMVOmtMCBSiTavZsKlj3e/tInze704L4bqizIlVs7EFi4ZAbfMpTk4lEMv
         t4zDBQ2BcuLprsQ8NRwl4j9PsR8g2VFw52JHHq8rkg2bMJmdRgfD/BwU+iiKlhG3Qnqm
         g8EA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/90kernel-modules/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index d65e92b..e4ebe83 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -51,7 +51,7 @@ installkernel() {
         if [[ "$(uname -p)" == arm* ]]; then
             # arm specific modules
             hostonly='' instmods sdhci_esdhc_imx mmci sdhci_tegra mvsdio omap omapdrm \
-                omap_hsmmc panel-tfp410 sdhci_dove ahci_platform pata_imx sata_mv \
+                omap_hsmmc panel-tfp410 sdhci_dove ahci_platform ahci_imx pata_imx sata_mv \
                 ehci-tegra mmc_block usb_storage
         fi
 
-- 
1.8.3.1
