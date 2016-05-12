From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] systemd-initrd: install new initrd-root-device.target
Date: Thu, 12 May 2016 15:11:14 -0600
Message-ID: <1463087474-22316-1-git-send-email-drake@endlessm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=SgHv2ZuoYDPIfjBHpklOE1ZPU3viXkOF8E42rfUuhFc=;
        b=xRWYhcdjcC3bk8DWYWpPe9SWAXByir3r6NVfcfUV03o4efs0BiScvYpQ7/QlBsqBaH
         JwkCsjHNx7hr9nl1nouhD9s7lHsRDTCwSk+WZqKW40Vox3rul1gGVAc8Szj7FxMxEssY
         lKZl1pXcSzIW73mpy+hZLu7gKJgefxZeFFhIuLMRJOe9Cwhq0t9P3l5t80NkZ949+xph
         Bl7QZgaM1zl53Ha3PkQkP2IeIlRD3+6RMJqO/POqY4q0hKiZKA6ortG+pp1BXJwAY33y
         wmhWN+vjnphceoeLBVu/qCLHjxHOXavgVj0bI10G0iy+pu9MEfAds31Ykr5KEZHfQGDI
         xJdA==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

systemd has a new initramfs target useful for inserting custom initramfs
code after the root device is available, before it has been checked and
mounted.
https://github.com/systemd/systemd/pull/3239

Make that available in dracut initramfs as standard.
---
 modules.d/01systemd-initrd/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/01systemd-initrd/module-setup.sh b/modules.d/01systemd-initrd/module-setup.sh
index fb6a9ea..c1ccd2a 100755
--- a/modules.d/01systemd-initrd/module-setup.sh
+++ b/modules.d/01systemd-initrd/module-setup.sh
@@ -28,6 +28,7 @@ install() {
     inst_multiple -o \
         $systemdsystemunitdir/initrd.target \
         $systemdsystemunitdir/initrd-fs.target \
+        $systemdsystemunitdir/initrd-root-device.target \
         $systemdsystemunitdir/initrd-root-fs.target \
         $systemdsystemunitdir/initrd-switch-root.target \
         $systemdsystemunitdir/initrd-switch-root.service \
-- 
2.7.4
