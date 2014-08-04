From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] [ARM] Categorize needed modules on ARM
Date: Mon,  4 Aug 2014 22:04:38 +0200
Message-ID: <1407182679-22580-3-git-send-email-kwizart@gmail.com>
References: <1407182679-22580-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4hK0tvSIJdt9al8nX7qbkyoLY5kZeOE6vTNTaWPGo2U=;
        b=tuJYSJdwcTCY9z1jshfZOJki3NHhYM1H/DUclBYfoua7EsAw00a1+SkcAj14u0WS+6
         i1w/16tqDnrNUgQ+RcEdvvsCyHMV84bahC4EPFImzXYHTBkEg9YHyxFwHEqmvVuKxx9W
         xKJRd6sKX1GXk/OS+IOHxWX55TcANBhSVGakMWIREBUVbBLHu394cRou9bfsj14ol42M
         3SdH3f3vf9TpWjNOR3GVkLzWzE0YZ3id0Jtw2qUQUOk3zfEFtZ08CBI7FVm5mISfzMhS
         OMi9VdHSELECXBjEHGy1jwF5AE5pIGzcJENwFpFvuxvYQ28bKnARgzvLcwu8O9rJeSi8
         2wQw==
In-Reply-To: <1407182679-22580-1-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/90kernel-modules/module-setup.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index 1ce133f..f3e4f65 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -51,10 +51,13 @@ installkernel() {
 
         if [[ "$(uname -p)" == arm* ]]; then
             # arm specific modules
-            hostonly='' instmods \
-	        connector-hdmi connector-dvi encoder-tfp410 \
-	        encoder-tpd12s015 i2c-tegra gpio-regulator \
-		as3722-regulator orion-ehci ehci-tegra 
+            instmods \
+                "=drivers/i2c/busses" \
+                "=drivers/regulator" \
+                "=drivers/rtc" \
+                "=drivers/usb/host" \
+                "=drivers/usb/phy" \
+                ${NULL}
         fi
 
         # install virtual machine support
-- 
1.8.3.1
