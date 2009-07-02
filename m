From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Add firmware loading support
Date: Thu,  2 Jul 2009 15:15:47 +0100 (BST)
Message-ID: <20090702141547.05B9B9D405C@zog.reactivated.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/95udev-rules/install |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
index 8a3d8e9..f8ea69a 100755
--- a/modules.d/95udev-rules/install
+++ b/modules.d/95udev-rules/install
@@ -12,6 +12,11 @@ inst_rules 50-udev.rules 95-late.rules
 # ignore some devices in the initrd
 inst_rules "$moddir/01-ignore.rules"
 
+# for firmware loading
+inst_rules 50-firmware.rules
+dracut_install /lib/udev/firmware.sh
+dracut_install cat uname
+
 if [ ! -x /lib/udev/vol_id ]; then
     dracut_install blkid
 fi
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
