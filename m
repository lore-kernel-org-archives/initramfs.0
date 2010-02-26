From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] udev: install distro specific firmware handler
Date: Fri, 26 Feb 2010 15:39:29 +0100
Message-ID: <1267195175-15554-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Debian Unstable still calls its firmware handling script
'firmware.agent' instead of 'firmware.sh'. This patch ensures that
either the .agent or the .sh gets installed.
---
 modules.d/95udev-rules/install |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
index b903a41..287cc03 100755
--- a/modules.d/95udev-rules/install
+++ b/modules.d/95udev-rules/install
@@ -15,7 +15,9 @@ inst_rules "$moddir/01-ignore.rules"
 
 # for firmware loading
 inst_rules 50-firmware.rules
-dracut_install /lib/udev/firmware.sh
+for i in firmware.sh firmware.agent hotplug.functions ; do
+    [ -e /lib/udev/$i ] && dracut_install /lib/udev/$i
+done
 dracut_install cat uname
 
 if [ ! -x /lib/udev/vol_id ]; then
@@ -31,7 +33,6 @@ ata_id \
 cdrom_id \
 create_floppy_devices \
 edd_id \
-firmware.sh \
 fw_unit_symlinks.sh \
 hid2hci \
 path_id \
-- 
1.7.0
