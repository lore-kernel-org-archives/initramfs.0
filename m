From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Rework drm/kernel modules selection on ARM
Date: Mon, 19 May 2014 00:29:55 +0200
Message-ID: <1400452195-29005-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lAsLhu4rYTJ+DK6ONOjaCxio7M/qXJARGLIZjJCLf7c=;
        b=Q3XCULMjd7ymvI15+7EIEAccJbtjSs4G+G5Ls0ckLilaVBb+bOhSy4lyUqGsMsEA1y
         MDTxVWBLxQrCi7E+wexnA75Hg8jQw/0KxNvrtdJRxsw/5+H3bB4gYCq6a/lwVzNG66ge
         8p5Zwxz1azWv1xFppXgUhaBZzJ5IiwQiI1lVIYA6MpZKWKUPCH1akPbgK9Eyjy26xq0q
         MEUKPCSC89zhD24N77eIIz7zP9gtq4YEbhhz86icwniaVi/xaxRBDSuQW0GD7AJaXMTx
         0P5J6tzDwr6lMCkEu1GR7Xo5iHzUcgyPrTpO3Fiw4A/YpG03zyZXcDSQsMRIpC6pPmwE
         DJ4w==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is a wip version as plymouth still doesn't work for me.
(Testing tegra on Toshiba AC100/Trimslice)
This should avoid to recreate an image for rootfs on sata with Wandboard
WIP for fixing rtc during early boot

v2 - Merged patch for kernel-modules for ahci_imx
   - Use "=drivers/ata" to select all ATA drivers
   - Install rtc drivers on ARM - initially reported as rhbz#1074002
    (WIP) need to install hwclock and sync time beforce network time sync
   - Use case in for drm on ARM when modalias is handled by
    a different module than the KMS one
   - Add backlight and pwm to the bundle for drm
   - Fix unbalanced parenthesis
---
 modules.d/50drm/module-setup.sh            | 12 ++++++++++--
 modules.d/90kernel-modules/module-setup.sh |  7 ++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/modules.d/50drm/module-setup.sh b/modules.d/50drm/module-setup.sh
index e25fc9f..2f5b75c 100755
--- a/modules.d/50drm/module-setup.sh
+++ b/modules.d/50drm/module-setup.sh
@@ -51,14 +51,22 @@ installkernel() {
         return 0
     }
 
+    # Some modules don't have drm_crtc_init but modalias needed by hostonly detection
+    local _drm_needed=$(find_kernel_modules_by_path drivers/gpu/{host1x,drm/{i2c,panel}})
+
+    local _video_backlight=$(find_kernel_modules_by_path drivers/{pwm,video/backlight})
+
     for _modname in $(find_kernel_modules_by_path drivers/gpu/drm \
-        | drm_module_filter) ; do
+        | drm_module_filter) $_drm_needed $_video_backlight ; do
         # if the hardware is present, include module even if it is not currently loaded,
         # as we could e.g. be in the installer; nokmsboot boot parameter will disable
         # loading of the driver if needed
         if [[ $hostonly ]] && modinfo -F alias $_modname | sed -e 's,\?,\.,g' -e 's,\*,\.\*,g' \
-            | grep -qxf - /sys/bus/pci/devices/*/modalias 2>/dev/null; then
+            | grep -qxf - /sys/bus/{pci/devices,soc/devices/soc?}/*/modalias 2>/dev/null; then
             hostonly='' instmods $_modname
+            case "$_modname" in
+                 host1x) hostonly='' instmods tegra-drm ;;
+            esac
             continue
         fi
         instmods $_modname
diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 2378663..0299ec1 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -51,9 +51,10 @@ installkernel() {
 
         if [[ "$(uname -p)" == arm* ]]; then
             # arm specific modules
-            hostonly='' instmods sdhci_esdhc_imx mmci sdhci_tegra mvsdio omap omapdrm \
-                omap_hsmmc panel-tfp410 sdhci_dove ahci_platform pata_imx sata_mv \
-                ehci-tegra mmc_block usb_storage
+            hostonly='' instmods sdhci_esdhc_imx mmci sdhci_tegra mvsdio \
+                omap_hsmmc sdhci_dove ahci_platform ahci_imx ahci_sunxi sata_mv \
+                ehci-tegra mmc_block usb_storage \
+                "=drivers/ata" "=drivers/rtc" "=drivers/mmc/host"
         fi
 
         # install virtual machine support
-- 
1.8.3.1
