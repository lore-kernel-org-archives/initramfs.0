From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ARM: update modules for ARM host only options
Date: Sun, 20 Jul 2014 22:20:04 +0100
Message-ID: <1405891204-12001-1-git-send-email-pbrobinson@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AwWD9KyiJNiXiUft5Eoo6ze6oGFMuHijR3GsQMGNkWw=;
        b=zXy1WOQYK/7UunTCpVkXa2TgtGSpDUWwzbPTMBUwei6dRNX4Cu3X2t/NTV2hkfk+sL
         4CwpFDYMAIdKpp3liq8+SONRiulLNvwb3x9TcMwWLZh8jQ1/qJi6Tujjm1Khk/pSnTLF
         DMgCFS9gAGFmVYbMj4HTwi9HhH89LlBUfLDKwJPt6h8MmWLbFQxfFby/8ug7SgSqB/Qw
         AQUen9lVsZRNPD/BRy9HOMjIaOoyTpqVlWfcGLRqKLwDqQQ3ywO2e41W5ebAoANaPFkm
         pd31Wqb2mWur77SVEROm11+mBhz9ImvDNc+ZSce2jy6+asM32oE6Gc6nLAg8DW94bcsW
         u3og==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 modules.d/90kernel-modules/module-setup.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
index cc79b88..1ce133f 100755
--- a/modules.d/90kernel-modules/module-setup.sh
+++ b/modules.d/90kernel-modules/module-setup.sh
@@ -51,9 +51,10 @@ installkernel() {
 
         if [[ "$(uname -p)" == arm* ]]; then
             # arm specific modules
-            hostonly='' instmods omapdrm panel-tfp410
-            instmods i2c-tegra gpio-regulator as3722-regulator \
-                    phy-tegra-usb ehci-tegra sdhci-tegra
+            hostonly='' instmods \
+	        connector-hdmi connector-dvi encoder-tfp410 \
+	        encoder-tpd12s015 i2c-tegra gpio-regulator \
+		as3722-regulator orion-ehci ehci-tegra 
         fi
 
         # install virtual machine support
-- 
2.0.1
