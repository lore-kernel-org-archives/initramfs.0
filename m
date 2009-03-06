From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: dracut and ubuntu 8.10
Date: Fri, 6 Mar 2009 16:18:53 +0100
Message-ID: <49B13EDD.2080700@bfh.ch>
References: <49A8602D.7020708@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49A8602D.7020708-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Followup: Harald Hoyers "Merge" repository boots on ub8.10 with a dracut.conf similar to the following one and the attached patch applied

> cat dracut.conf
modules="ata_piix sd_mod sg"
dracutmodules="dash kernel-modules debug terminfo udev-rules.ub810 base"

---
diff --git a/modules.d/95udev-rules.ub810/install b/modules.d/95udev-rules.ub810/install
new file mode 100755
index 0000000..f4067dd
--- /dev/null
+++ b/modules.d/95udev-rules.ub810/install
@@ -0,0 +1,25 @@
+#!/bin/bash
+# udev rules for ubuntu 8.10
+# content from /usr/share/initramfs-tools/hooks/udev
+mkdir -p "$initdir/etc/udev/rules.d"
+mkdir -p "$initdir/var/run"
+
+dracut_install udevd udevadm pkill
+dracut_install /etc/udev/udev.conf
+
+for rules in 05-options.rules 20-names.rules 40-basic-permissions.rules 60-persistent-storage.rules 61-persistent-s
+    dracut_install /etc/udev/rules.d/$rules 
+done
+
+dracut_install /lib/udev/dvb_device_name 
+dracut_install /lib/udev/usb_device_name 
+dracut_install /lib/udev/ata_id 
+dracut_install /lib/udev/usb_id 
+dracut_install /lib/udev/vol_id 
+dracut_install /lib/udev/scsi_id 
+dracut_install /lib/udev/path_id 
+dracut_install /lib/udev/edd_id 
+dracut_install /lib/udev/firmware_helper 
+dracut_install /lib/udev/ide_media 
+dracut_install /lib/udev/vio_type 
+dracut_install /lib/udev/watershed 
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 7ff6e4a..3616adc 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -55,7 +55,7 @@ getarg 'break=pre-udev' && emergency_shell
 source_all pre-udev
 
 # start up udev and trigger cold plugs
-udevd --daemon --resolve-names=never
+udevd --daemon $( [ $(udevd --version) -ge 137 ] && echo --resolve-names=never )
 udevadm trigger >/dev/null 2>&1
 udevadm settle --timeout=30 >/dev/null 2>&1
 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
