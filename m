From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] udev-rules: add eudev rules
Date: Wed, 25 Dec 2013 14:00:26 +0400
Message-ID: <E1W5K2T-0000zh-LK@secretive.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=qpmIWrycWxGDkadpjKdDM8sLx+2KADgrLGWNjGIaBPI=;
	b=MEEf3qaU8ibwrfqNEY+4dEiU2A49h219OdPrKgCjvF7/h9DxhcJocPa0BjxFUB3XUf/kYlL7xF/gEqFHDEhe9hfHBDniRpah8YMjTej5rLliia02KRdRTUsuDisy4hzVTmxZMMQn+9MopJyIg2tyIoKHZZiSzLm+VIPTueVK2gY=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

eudev configured with "--enable-modules --disable-libkmod" installs
80-drivers-modprobe.rules instead of 80-drivers.rules

https://bugs.gentoo.org/show_bug.cgi?id=494188
---
 modules.d/95udev-rules/module-setup.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-rules/module-setup.sh
index 88c3da2..ebc4447 100755
--- a/modules.d/95udev-rules/module-setup.sh
+++ b/modules.d/95udev-rules/module-setup.sh
@@ -39,6 +39,8 @@ install() {
     prepare_udev_rules 59-persistent-storage.rules 61-persistent-storage.rules
     # debian udev rules
     inst_rules 91-permissions.rules
+    # eudev rules
+    inst_rules 80-drivers-modprobe.rules
 
     {
         for i in cdrom tape dialout floppy; do
-- 
1.8.3.2
