From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] drm: Look for DRM drivers in the staging directory
Date: Tue, 12 Dec 2017 14:27:18 +0000
Message-ID: <20171212142718.11451-1-carlo@caione.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=eox80iUXC18UsU8WWjeQiCzUrWrD6fnJ0sROh2zokq8=;
        b=eTJCqdfCAtrRQGPExhGe4vOI8MI/6IcOi7PBPERyzH/b1LvaMP70cniPOomF5Swk6i
         0CYjdyxi+l+HjOBNm5ySlkz5hgWPLRpyKCpe45dGXHJ8e2wAVR4Uvecd/75rDW0pTVxZ
         IBnwKxqd0ZwJfuJjJi9Lt3o0tWpzb9lubCcF/MDF1hCJZBtHmZv/ZIXC6eRL0XZqsZcS
         S8XjfWbm//4umAD+ePqBV/sMRhY77XAYfW27vCtpvCv8rT2X2BAw1ZyoJAYvzlCCypv2
         e3KPaizsCbBm7LezFjZTyIj57SIT2JzqQvfbwruWi+ybsA6AsGCqsNDEzsTpulkCBsCA
         mdUw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>

From: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>

The recently upstreamed virtualbox video driver (vboxvideo) is shipped
in the staging directory. We need to probe it before Xorg is loaded to
avoid a corrupted X.

In general it is a good practice to look also in the staging directory
for DRM drivers.

Signed-off-by: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
---
 modules.d/50drm/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/50drm/module-setup.sh b/modules.d/50drm/module-setup.sh
index 2014539a..382f51a9 100755
--- a/modules.d/50drm/module-setup.sh
+++ b/modules.d/50drm/module-setup.sh
@@ -40,6 +40,6 @@ installkernel() {
             fi
         done
     else
-        dracut_instmods -s "drm_crtc_init" "=drivers/gpu/drm"
+        dracut_instmods -s "drm_crtc_init" "=drivers/gpu/drm" "=drivers/staging"
     fi
 }
-- 
2.14.1
