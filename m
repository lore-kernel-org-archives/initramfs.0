From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] [RFC] Add tegra-drm/host1x case and ARM hostonly support
Date: Wed, 14 May 2014 19:34:57 +0200
Message-ID: <1400088897-3258-2-git-send-email-kwizart@gmail.com>
References: <1400088897-3258-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9d5mXrcDqw2QWgULN5+arYT3uDo1uUteXLTHv16MTRY=;
        b=cwSXNNFX1ptoA1ije1v1YsWVU2nC97iY4An7QTToJg9VyZRsst/PHIa+XDA0qsiPBs
         qlLDo9Uyg2e2D1ofjMpbXu+ZJCTYkOC6eyMfGebb51oYechHTBaYKBLszUIv3IVzKDex
         fnrBtDNhWKBI5y9/IaQ1dnyurmhjkuyz4i0xyA05256OdPo7GMQTHpgjVSfAgAGgmqys
         IjyDw8PlJ8nnFhopD2kltaiE4XGiGg1McI4YYblFYI7maulXL5s1qEoPYgkmI6cNSFWy
         m+uOkj8M+u2pxoFCNkUMnaa6RNmV9s37gVsPpuY26eqI3MAG+NbvWS+keZLMqxIvuYEz
         JhZQ==
In-Reply-To: <1400088897-3258-1-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is a wip version as plymouth still doesn't work for me

1/ On arm, aliases use a different path (soc)
2/ host1x has the matching device aliases
 whereas tegra_drm has the crt_init symbol
3/ Others ARM drivers may behave similarly
4/ backlight and pwm_bl also need to be bundled.

I'm currenly testing with fedora kernel 3.14 or 3.15
---
 modules.d/50drm/module-setup.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/modules.d/50drm/module-setup.sh b/modules.d/50drm/module-setup.sh
index e25fc9f..c3ca1e4 100755
--- a/modules.d/50drm/module-setup.sh
+++ b/modules.d/50drm/module-setup.sh
@@ -51,14 +51,18 @@ installkernel() {
         return 0
     }
 
+    # Some modules don't have drm_crtc_init but modalias needed by hostonly detection
+    local _drm_needed=$(find_kernel_modules_by_path drivers/gpu/{host1x,drm/{i2c,panel})
+
     for _modname in $(find_kernel_modules_by_path drivers/gpu/drm \
-        | drm_module_filter) ; do
+        | drm_module_filter) $_drm_needed ; do
         # if the hardware is present, include module even if it is not currently loaded,
         # as we could e.g. be in the installer; nokmsboot boot parameter will disable
         # loading of the driver if needed
         if [[ $hostonly ]] && modinfo -F alias $_modname | sed -e 's,\?,\.,g' -e 's,\*,\.\*,g' \
-            | grep -qxf - /sys/bus/pci/devices/*/modalias 2>/dev/null; then
+            | grep -qxf - /sys/bus/{pci/devices,soc/devices/soc?}/*/modalias 2>/dev/null; then
             hostonly='' instmods $_modname
+            hostonly='' [[ $_modname == host1x ]] && instmods tegra-drm
             continue
         fi
         instmods $_modname
-- 
1.8.3.1
