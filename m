From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] Gentoo ebuild for LVM2 prior to 2.02.63-r1 doesn't install rules:
Date: Wed,  2 Mar 2011 18:02:57 +0100
Message-ID: <1299085377-5109-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

  10-dm.rules
  11-dm-lvm.rules
  13-dm-disk.rules
  95-dm-notify.rules

but provides only 64-device-mapper.rules combining more or less the
above rules files.
---
 modules.d/90dm/module-setup.sh     |    3 +++
 modules.d/90dmraid/module-setup.sh |    3 +++
 modules.d/90lvm/module-setup.sh    |    3 +++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/modules.d/90dm/module-setup.sh b/modules.d/90dm/module-setup.sh
index 11985fd..67b4d40 100755
--- a/modules.d/90dm/module-setup.sh
+++ b/modules.d/90dm/module-setup.sh
@@ -22,5 +22,8 @@ install() {
 
     type -P dmeventd >/dev/null && dracut_install dmeventd
     inst_rules 10-dm.rules 95-dm-notify.rules
+    # Gentoo ebuild for LVM2 prior to 2.02.63-r1 doesn't install above rules
+    # files, but provides the one below:
+    inst_rules 64-device-mapper.rules
 }
 
diff --git a/modules.d/90dmraid/module-setup.sh b/modules.d/90dmraid/module-setup.sh
index f437712..6950d3c 100755
--- a/modules.d/90dmraid/module-setup.sh
+++ b/modules.d/90dmraid/module-setup.sh
@@ -43,6 +43,9 @@ install() {
     done
 
     inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules 
+    # Gentoo ebuild for LVM2 prior to 2.02.63-r1 doesn't install above rules
+    # files, but provides the one below:
+    inst_rules 64-device-mapper.rules
 
     inst "$moddir/dmraid.sh" /sbin/dmraid_scan
 
diff --git a/modules.d/90lvm/module-setup.sh b/modules.d/90lvm/module-setup.sh
index 2555728..f3da242 100755
--- a/modules.d/90lvm/module-setup.sh
+++ b/modules.d/90lvm/module-setup.sh
@@ -47,6 +47,9 @@ install() {
     fi
 
     inst_rules 10-dm.rules 13-dm-disk.rules 95-dm-notify.rules 11-dm-lvm.rules
+    # Gentoo ebuild for LVM2 prior to 2.02.63-r1 doesn't install above rules
+    # files, but provides the one below:
+    inst_rules 64-device-mapper.rules
 
     inst "$moddir/lvm_scan.sh" /sbin/lvm_scan
     inst_hook cmdline 30 "$moddir/parse-lvm.sh"
-- 
1.7.4.1
