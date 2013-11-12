From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] Include support for Logitec, Inc. Unifying Reveiver keyboard
Date: Tue, 12 Nov 2013 10:39:00 +0100
Message-ID: <1384249140-20683-3-git-send-email-colin@mageia.org>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384249140-20683-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

---
 modules.d/95udev-rules/module-setup.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-rules/module-setup.sh
index 88c3da2..f4498b3 100755
--- a/modules.d/95udev-rules/module-setup.sh
+++ b/modules.d/95udev-rules/module-setup.sh
@@ -36,6 +36,9 @@ install() {
         "$moddir/59-persistent-storage.rules" \
         "$moddir/61-persistent-storage.rules"
 
+    # Needed for some keyboards e.g. "Logitech, Inc. Unifying Receiver"
+    inst_hwdb 20-usb-vendor-model.hwdb
+
     prepare_udev_rules 59-persistent-storage.rules 61-persistent-storage.rules
     # debian udev rules
     inst_rules 91-permissions.rules
-- 
1.8.4.2
