From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 04/10] remove 50plymouth-pre0.7 module
Date: Fri,  3 Jul 2009 18:45:14 +0200
Message-ID: <1246639520-3094-5-git-send-email-harald@redhat.com>
References: <1246639520-3094-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246639520-3094-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/50plymouth-pre0.7/63-luks.rules          |   11 -------
 modules.d/50plymouth-pre0.7/check                  |    3 --
 modules.d/50plymouth-pre0.7/cryptroot-ask.sh       |    4 --
 modules.d/50plymouth-pre0.7/install                |    8 -----
 modules.d/50plymouth-pre0.7/plymouth-newroot.sh    |    4 --
 .../50plymouth-pre0.7/plymouth-populate-initrd     |   25 ----------------
 modules.d/50plymouth-pre0.7/plymouth-start.sh      |   31 --------------------
 7 files changed, 0 insertions(+), 86 deletions(-)
 delete mode 100644 modules.d/50plymouth-pre0.7/63-luks.rules
 delete mode 100755 modules.d/50plymouth-pre0.7/check
 delete mode 100755 modules.d/50plymouth-pre0.7/cryptroot-ask.sh
 delete mode 100755 modules.d/50plymouth-pre0.7/install
 delete mode 100755 modules.d/50plymouth-pre0.7/plymouth-newroot.sh
 delete mode 100755 modules.d/50plymouth-pre0.7/plymouth-populate-initrd
 delete mode 100755 modules.d/50plymouth-pre0.7/plymouth-start.sh

diff --git a/modules.d/50plymouth-pre0.7/63-luks.rules b/modules.d/50plymouth-pre0.7/63-luks.rules
deleted file mode 100644
index 711e865..0000000
--- a/modules.d/50plymouth-pre0.7/63-luks.rules
+++ /dev/null
@@ -1,11 +0,0 @@
-# hacky rules to try to try unlocking dm-crypt devs
-#
-# Copyright 2008, Red Hat, Inc.
-# Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
-
-
-SUBSYSTEM!="block", GOTO="luks_end"
-ACTION!="add|change", GOTO="luks_end"
-ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
-
-LABEL="luks_end"
diff --git a/modules.d/50plymouth-pre0.7/check b/modules.d/50plymouth-pre0.7/check
deleted file mode 100755
index 018c0e9..0000000
--- a/modules.d/50plymouth-pre0.7/check
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-[[ $1 = -d ]] && echo crypt
-[[ -x /sbin/plymouthd && -x /bin/plymouth && ! /usr/sbin/plymouth-set-default-theme ]]
diff --git a/modules.d/50plymouth-pre0.7/cryptroot-ask.sh b/modules.d/50plymouth-pre0.7/cryptroot-ask.sh
deleted file mode 100755
index fadb502..0000000
--- a/modules.d/50plymouth-pre0.7/cryptroot-ask.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-
-[ -b /dev/mapper/$2 ] || exec /bin/plymouth ask-for-password --command="/sbin/cryptsetup luksOpen -T1 $1 $2"
-
diff --git a/modules.d/50plymouth-pre0.7/install b/modules.d/50plymouth-pre0.7/install
deleted file mode 100755
index 4d3f7dc..0000000
--- a/modules.d/50plymouth-pre0.7/install
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-. "$moddir"/plymouth-populate-initrd
-inst_hook pre-udev 10 "$moddir"/plymouth-start.sh
-inst_hook pre-pivot 90 "$moddir"/plymouth-newroot.sh
-inst_rules "$moddir/63-luks.rules"
-inst "$moddir"/cryptroot-ask.sh /lib/udev/cryptroot-ask
-inst cryptsetup
-
diff --git a/modules.d/50plymouth-pre0.7/plymouth-newroot.sh b/modules.d/50plymouth-pre0.7/plymouth-newroot.sh
deleted file mode 100755
index c6f8c6d..0000000
--- a/modules.d/50plymouth-pre0.7/plymouth-newroot.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-
-[ -x /bin/plymouth ] && /bin/plymouth --newroot=$NEWROOT
-
diff --git a/modules.d/50plymouth-pre0.7/plymouth-populate-initrd b/modules.d/50plymouth-pre0.7/plymouth-populate-initrd
deleted file mode 100755
index 1802b25..0000000
--- a/modules.d/50plymouth-pre0.7/plymouth-populate-initrd
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-if ldd /sbin/plymouthd |grep -q lib64; then
-    LIBDIR="/usr/lib64"
-else
-    LIBDIR="/usr/lib"
-fi
-PLYMOUTH_LOGO_FILE="/usr/share/pixmaps/system-logo-white.png"
-PLYMOUTH_PLUGIN_NAME=$(plymouth-set-default-plugin)
-
-inst /sbin/plymouthd /bin/plymouthd
-dracut_install /bin/plymouth "${LIBDIR}/plymouth/text.so" \
-    "${LIBDIR}/plymouth/details.so" "${PLYMOUTH_LOGO_FILE}" \
-    /etc/system-release "${LIBDIR}/plymouth/${PLYMOUTH_PLUGIN_NAME:=text}.so"
-mkdir -p "${initdir}/usr/share/plymouth"
-
-[[ -f ${LIBDIR}/plymouth/default.so ]] && inst ${LIBDIR}/plymouth/default.so
-
-if [[ -d /usr/share/plymouth/${PLYMOUTH_PLUGIN_NAME} ]]; then
-    for x in "/usr/share/plymouth/${PLYMOUTH_PLUGIN_NAME}"/* ; do
-        [[ -f "$x" ]] || break
-        inst $x
-    done
-fi
-
-# vim:ts=8:sw=4:sts=4:et
diff --git a/modules.d/50plymouth-pre0.7/plymouth-start.sh b/modules.d/50plymouth-pre0.7/plymouth-start.sh
deleted file mode 100755
index 310042d..0000000
--- a/modules.d/50plymouth-pre0.7/plymouth-start.sh
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/bin/sh
-
-[ -c /dev/null ] || mknod /dev/null c 1 3
-mknod /dev/zero c 1 5
-mknod /dev/systty c 4 0
-mknod /dev/tty c 5 0
-[ -c /dev/console ] || mknod /dev/console c 5 1
-[ -c /dev/ptmx ] || mknod /dev/ptmx c 5 2
-mknod /dev/fb c 29 0
-mknod /dev/tty0 c 4 0
-mknod /dev/tty1 c 4 1
-mknod /dev/tty2 c 4 2
-mknod /dev/tty3 c 4 3
-mknod /dev/tty4 c 4 4
-mknod /dev/tty5 c 4 5
-mknod /dev/tty6 c 4 6
-mknod /dev/tty7 c 4 7
-mknod /dev/tty8 c 4 8
-mknod /dev/tty9 c 4 9
-mknod /dev/tty10 c 4 10
-mknod /dev/tty11 c 4 11
-mknod /dev/tty12 c 4 12
-mknod /dev/ttyS0 c 4 64
-mknod /dev/ttyS1 c 4 65
-mknod /dev/ttyS2 c 4 66
-mknod /dev/ttyS3 c 4 67
-/lib/udev/console_init tty0
-
-[ -x /bin/plymouthd ] && /bin/plymouthd 
-[ -x /bin/plymouth ] && /bin/plymouth --show-splash
-
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
