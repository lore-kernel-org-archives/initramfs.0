From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Allow fstab-based remount to be controlled by modules
Date: Mon,  8 Nov 2010 19:41:28 +0000 (GMT)
Message-ID: <20101108194128.EBFEB9D401B@zog.reactivated.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

OLPC would like to be able to disable this behaviour through
a custom dracut module. Add a "no_fstab_remount" flag which can be
set by modules that want to disable this functionality.

(Background: having the correct rootfs info in /etc/fstab is a bit of a
 challenge for OLPC, because this info is not known at build time.)
---
 modules.d/95rootfs-block/mount-root.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index ff64209..7602731 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -73,6 +73,7 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
     rootopts=
     if getargbool 1 rd.fstab -n rd_NO_FSTAB \
         && ! getarg rootflags \
+        && [ -z "$no_fstab_remount" ] \
         && [ -f "$NEWROOT/etc/fstab" ] \
         && ! [ -L "$NEWROOT/etc/fstab" ]; then
         # if $NEWROOT/etc/fstab contains special mount options for 
-- 
1.7.3.2
