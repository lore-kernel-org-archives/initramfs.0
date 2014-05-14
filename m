From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] Add ahci_imx to the ARM specific disk drivers
Date: Wed, 14 May 2014 19:34:56 +0200
Message-ID: <1400088897-3258-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EhhXx9dEKoftegzLgFHxlJRT80h4io3kjIAO1p5RovM=;
        b=G5nPLoCFGnzYMgownO5+jeWXswZqy4l0rVm/EIVQZqbAYJCRHo4yKnLOD7Pk+wLSlJ
         MMGZ86G7h5wbSW+FPPqGyXNVBC23Wo3MJXkV6prMo5aWTXzkrJCu1LwFE45zuIE5rDgi
         RHvB+CLj1aSG3CXXzjJHjYvsLGx2VSzoqPTIsBlwWqZW6FIbH/c6KSmhHzp5PbIg9ln0
         54xoRtrmvmE3IRaCJsygnPZiYFHkwCq16tG64NUYMamIuXIQXmt840wso9Lno1vFyetl
         /4AVnVxme5mN1rG8vuHC15aPVDCtleZF+62GwaQVwlmmTSTuEMrk5K5TbJBCbAlJUUPw
         qTBg==
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
index 2378663..6852b76 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -52,7 +52,7 @@ installkernel() {
         if [[ "$(uname -p)" == arm* ]]; then
             # arm specific modules
             hostonly='' instmods sdhci_esdhc_imx mmci sdhci_tegra mvsdio omap omapdrm \
-                omap_hsmmc panel-tfp410 sdhci_dove ahci_platform pata_imx sata_mv \
+                omap_hsmmc panel-tfp410 sdhci_dove ahci_platform ahci_imx pata_imx sata_mv \
                 ehci-tegra mmc_block usb_storage
         fi
 
-- 
1.8.3.1
