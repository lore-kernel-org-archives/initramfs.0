From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/6] lvm: Ensure LVM is initialised in non-hostonly mode.
Date: Wed, 23 Jan 2013 20:15:02 +0000
Message-ID: <1358972106-2395-3-git-send-email-colin@mageia.org>
References: <1358972106-2395-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358972106-2395-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

This is a bit of a hack, but it's needed if /usr is on LVM.
---
 modules.d/90lvm/module-setup.sh          | 3 +++
 modules.d/90lvm/non-hostonly-init-lvm.sh | 8 ++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 modules.d/90lvm/non-hostonly-init-lvm.sh

diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module-setup.sh
index a537b1a..611379a 100755
--- a/modules.d/90lvm/module-setup.sh
+++ b/modules.d/90lvm/module-setup.sh
@@ -49,6 +49,9 @@ install() {
             sed -i -e 's/\(^[[:space:]]*\)use_lvmetad[[:space:]]*=[[:space:]]*[[:digit:]]/\1use_lvmetad = 0/' ${initdir}/etc/lvm/lvm.conf
         fi
     fi
+    if ! [[ $hostonly ]]; then
+        inst_hook pre-udev 30 "$moddir/non-hostonly-init-lvm.sh"
+    fi
 
     inst_rules 11-dm-lvm.rules
     # Gentoo ebuild for LVM2 prior to 2.02.63-r1 doesn't install above rules
diff --git a/modules.d/90lvm/non-hostonly-init-lvm.sh b/modules.d/90lvm/non-hostonly-init-lvm.sh
new file mode 100644
index 0000000..2e9212c
--- /dev/null
+++ b/modules.d/90lvm/non-hostonly-init-lvm.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+printf 'cancel_wait_for_dev /dev/non-hostonly-lvm; rm "$job";' \
+    "$hookdir" >> $hookdir/initqueue/timeout/non-hostonly-lvm.sh
+
+wait_for_dev "/dev/non-hostonly-lvm"
-- 
1.8.1
