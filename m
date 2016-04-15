From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH] dracut: add support for updating the CPU microcode
Date: Sat, 16 Apr 2016 01:18:52 +0200
Message-ID: <1460762332.3054.2.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is the initial version of a new "microcode" dracut module
that can be used to update the microcode on Intel(R) CPUs.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
 modules.d/00microcode/module-setup.sh |   26 ++++++++++++++++++++++++++
 modules.d/99base/init.sh              |    9 +++++++++
 2 files changed, 35 insertions(+)

diff -pruN dracut-git/modules.d/00microcode/module-setup.sh dracut-git-microcode-update/modules.d/00microcode/module-setup.sh
--- dracut-git/modules.d/00microcode/module-setup.sh	1970-01-01 01:00:00.000000000 +0100
+++ dracut-git-microcode-update/modules.d/00microcode/module-setup.sh	2016-04-16 01:11:20.719287468 +0200
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+# Dracut module to update the microcode on Intel(R) CPUs
+# Copyright 2016 Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
+
+# called by dracut
+check() {
+    [[ "$mount_needs" ]] && return 1
+
+    require_binaries microcode_ctl || return 1
+
+    return 0
+}
+
+# called by dracut
+depends() {
+    return 0
+}
+
+# called by dracut
+install() {
+    inst microcode_ctl
+
+    inst_dir /lib/firmware
+    inst /lib/firmware/microcode.dat
+}
diff -pruN dracut-git/modules.d/99base/init.sh dracut-git-microcode-update/modules.d/99base/init.sh
--- dracut-git/modules.d/99base/init.sh	2016-04-14 22:21:22.681548895 +0200
+++ dracut-git-microcode-update/modules.d/99base/init.sh	2016-04-16 01:09:58.517080944 +0200
@@ -62,6 +62,15 @@ if ! ismounted /dev/shm; then
     mount -t tmpfs -o mode=1777,noexec,nosuid,nodev,strictatime tmpfs /dev/shm >/dev/null
 fi
 
+# Update CPU microcode
+if [ -x /usr/sbin/microcode_ctl ]; then
+    MICROCODE_CTL=/usr/sbin/microcode_ctl
+elif [ -x /sbin/microcode_ctl ]; then
+    MICROCODE_CTL=/sbin/microcode_ctl
+fi
+[ $MICROCODE_CTL ] && [ ! -e /dev/cpu/microcode ] && echo "Creating microcode update device..." && mknod /dev/cpu/microcode c 10 184
+[ $MICROCODE_CTL ] && [ -e /lib/firmware/microcode.dat ] && $MICROCODE_CTL -u
+
 if ! ismounted /run; then
     mkdir -m 0755 /newrun
     if ! str_starts "$(readlink -f /bin/sh)" "/run/"; then
