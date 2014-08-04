From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] [ARM] Introduce ARM specific modules needed by drm
Date: Mon,  4 Aug 2014 22:04:39 +0200
Message-ID: <1407182679-22580-4-git-send-email-kwizart@gmail.com>
References: <1407182679-22580-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d+hUZqIDKX62vUWxBNodukLoa8kw4aM5Ypy9hicBr2I=;
        b=C6we18x7UXZYEEDyaSGSXvzO7M6JHhwmE9jb+XKFHVnjIK/BF5v0sGOr2r38PIktXz
         WHloK4s7KjI37x591U/MJyMTN66Lai4dc45DO1uNNOLZXIqEkHOwKS8yKQ5DfZrhS/3O
         B0QEGsd0caRqEBi0QHw30JOcBJjAzSuohuU9r89yMuS+RAuAa3GPmhZoIXEUlZpn0+NN
         mp3Et5PGbtbnK6YP4LISegtaFuXolz/tjhZIj2WJRjuMmKuVu73KfR8Mv1SO9J2QwtNq
         gHM82Ng1jQPBHdAjPIlNigbrGYF5ginqo2sld8uj586tJauyeZ0Mh5zfaYnJAVziSPfy
         VhsQ==
In-Reply-To: <1407182679-22580-1-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/50drm/module-setup.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/modules.d/50drm/module-setup.sh b/modules.d/50drm/module-setup.sh
index 9a48aaf..a42bcba 100755
--- a/modules.d/50drm/module-setup.sh
+++ b/modules.d/50drm/module-setup.sh
@@ -51,6 +51,17 @@ installkernel() {
         return 0
     }
 
+    if [[ "$(uname -p)" == arm* ]]; then
+        # arm specific modules needed by drm
+        instmods \
+            "=drivers/gpu/drm/i2c" \
+            "=drivers/gpu/drm/panel" \
+            "=drivers/pwm" \
+            "=drivers/video/backlight" \
+            "=drivers/video/fbdev/omap2/displays-new" \
+            ${NULL}
+    fi
+
     for _modname in $(find_kernel_modules_by_path drivers/gpu/drm \
         | drm_module_filter) ; do
         # if the hardware is present, include module even if it is not currently loaded,
-- 
1.8.3.1
