From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/6] i18n: Run console_init prior to udev startup.
Date: Wed, 23 Jan 2013 20:15:05 +0000
Message-ID: <1358972106-2395-6-git-send-email-colin@mageia.org>
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

In some cases udev will initialise the encrypted disks and ask for a
password before it initialises the console.

This can result in the password for encrypted partitions being asked for
with the wrong keymap loaded.

So this patch just attempts to initialise things statically. It might
fail but udev will do it properly later anyway.
---
 modules.d/10i18n/i18n-pre-udev.sh | 7 +++++++
 modules.d/10i18n/module-setup.sh  | 1 +
 2 files changed, 8 insertions(+)
 create mode 100755 modules.d/10i18n/i18n-pre-udev.sh

diff --git a/modules.d/10i18n/i18n-pre-udev.sh b/modules.d/10i18n/i18n-pre-udev.sh
new file mode 100755
index 0000000..2033948
--- /dev/null
+++ b/modules.d/10i18n/i18n-pre-udev.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+if [ -x /lib/udev/console_init -a -e /dev/tty0 ]; then
+    /lib/udev/console_init /dev/tty0
+fi
diff --git a/modules.d/10i18n/module-setup.sh b/modules.d/10i18n/module-setup.sh
index 1ed1db6..21b0c05 100755
--- a/modules.d/10i18n/module-setup.sh
+++ b/modules.d/10i18n/module-setup.sh
@@ -89,6 +89,7 @@ install() {
         inst ${moddir}/console_init.sh /lib/udev/console_init
         inst_rules ${moddir}/10-console.rules
         inst_hook cmdline 20 "${moddir}/parse-i18n.sh"
+        inst_hook pre-udev 10 "$moddir/i18n-pre-udev.sh"
     }
 
     install_all_kbd() {
-- 
1.8.1
