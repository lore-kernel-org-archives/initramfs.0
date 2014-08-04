From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] [ARM] Test soc path for modalias needed by drm
Date: Mon,  4 Aug 2014 22:04:37 +0200
Message-ID: <1407182679-22580-2-git-send-email-kwizart@gmail.com>
References: <1407182679-22580-1-git-send-email-kwizart@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkPqBa0E+Lw0VlnY/WLoUwV1xV2QMnL+2QmEcQrGBZo=;
        b=hqftk7b9gFPsnGmgrKOlFsBcU+xLwz4RdgbeRAnqfN7jannjWzttFidhFJTL6fvJfV
         jn5CgwK/BZvqErhJPuLY5u7kSnF1nVueVyNN3H2av5ZzGMsH/Ue69xWJViuCL8Uirk+s
         Fs1+9dn9jhQylDsz1uAixpAT4T74whjWo2IoK2puocV09NM27vwyJjGBnDp1n4pimAVF
         S+cXSjHvtUjVY3CopgJKb6/kXSibowEyvfp0/K83Yfd60rypl7+ZHvEldXscxjFbcmYa
         ln9HKlIkTBue/t/TAGbpTWj1DdSMtMDf/aPHL4O6/rO2+dBS/VMNFBKAcFUsieznUmqo
         fdEw==
In-Reply-To: <1407182679-22580-1-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On ARM, both pci and soc path can be tested for drm.

With this patchset, that was missing in recent kernel,
the tegra_drm case is not needed anymore:
http://patchwork.ozlabs.org/patch/361765/
http://www.spinics.net/lists/linux-tegra/msg17948.html
---
 modules.d/50drm/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/50drm/module-setup.sh b/modules.d/50drm/module-setup.sh
index e25fc9f..9a48aaf 100755
--- a/modules.d/50drm/module-setup.sh
+++ b/modules.d/50drm/module-setup.sh
@@ -57,7 +57,7 @@ installkernel() {
         # as we could e.g. be in the installer; nokmsboot boot parameter will disable
         # loading of the driver if needed
         if [[ $hostonly ]] && modinfo -F alias $_modname | sed -e 's,\?,\.,g' -e 's,\*,\.\*,g' \
-            | grep -qxf - /sys/bus/pci/devices/*/modalias 2>/dev/null; then
+            | grep -qxf - /sys/bus/{pci/devices,soc/devices/soc?}/*/modalias 2>/dev/null; then
             hostonly='' instmods $_modname
             continue
         fi
-- 
1.8.3.1
