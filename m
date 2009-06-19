From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 05/13] prepare udev rules for udev >= 143
Date: Fri, 19 Jun 2009 13:05:43 +0200
Message-ID: <1245409551-30493-6-git-send-email-harald@redhat.com>
References: <1245409551-30493-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245409551-30493-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/90crypt/63-luks.rules            |   12 ------------
 modules.d/90crypt/70-luks.rules            |   12 ++++++++++++
 modules.d/90crypt/install                  |    2 +-
 modules.d/90lvm/64-lvm-vol_id.rules        |   20 ++++++++++++++++++++
 modules.d/90lvm/64-lvm.rules               |    9 ++++++++-
 modules.d/90lvm/install                    |    6 +++++-
 modules.d/90mdraid/65-md-incremental.rules |    8 ++++++++
 modules.d/90mdraid/install                 |    9 ++++++++-
 modules.d/95nbd/61-nbd-vol_id.rules        |    7 +++++++
 modules.d/95nbd/61-nbd.rules               |    4 ++--
 modules.d/95nbd/install                    |    8 +++++++-
 modules.d/95udev-rules/install             |    6 +++++-
 12 files changed, 83 insertions(+), 20 deletions(-)
 delete mode 100644 modules.d/90crypt/63-luks.rules
 create mode 100644 modules.d/90crypt/70-luks.rules
 create mode 100644 modules.d/90lvm/64-lvm-vol_id.rules
 create mode 100644 modules.d/90mdraid/65-md-incremental.rules
 create mode 100644 modules.d/95nbd/61-nbd-vol_id.rules

diff --git a/modules.d/90crypt/63-luks.rules b/modules.d/90crypt/63-luks.rules
deleted file mode 100644
index cfa619b..0000000
--- a/modules.d/90crypt/63-luks.rules
+++ /dev/null
@@ -1,12 +0,0 @@
-# hacky rules to try to try unlocking dm-crypt devs
-#
-# Copyright 2008, Red Hat, Inc.
-# Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
-
-
-SUBSYSTEM!="block", GOTO="luks_end"
-ACTION!="add|change", GOTO="luks_end"
-
-ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
-
-LABEL="luks_end"
diff --git a/modules.d/90crypt/70-luks.rules b/modules.d/90crypt/70-luks.rules
new file mode 100644
index 0000000..cfa619b
--- /dev/null
+++ b/modules.d/90crypt/70-luks.rules
@@ -0,0 +1,12 @@
+# hacky rules to try to try unlocking dm-crypt devs
+#
+# Copyright 2008, Red Hat, Inc.
+# Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+
+
+SUBSYSTEM!="block", GOTO="luks_end"
+ACTION!="add|change", GOTO="luks_end"
+
+ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
+
+LABEL="luks_end"
diff --git a/modules.d/90crypt/install b/modules.d/90crypt/install
index fcaaa60..a3a856d 100755
--- a/modules.d/90crypt/install
+++ b/modules.d/90crypt/install
@@ -1,5 +1,5 @@
 #!/bin/bash
 inst cryptsetup
 instmods dm_crypt cbc aes sha256 xts
-inst_rules "$moddir/63-luks.rules"
+inst_rules "$moddir/70-luks.rules"
 inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
diff --git a/modules.d/90lvm/64-lvm-vol_id.rules b/modules.d/90lvm/64-lvm-vol_id.rules
new file mode 100644
index 0000000..d4b5269
--- /dev/null
+++ b/modules.d/90lvm/64-lvm-vol_id.rules
@@ -0,0 +1,20 @@
+# hacky rules to try to activate lvm when we get new block devs...
+#
+# Copyright 2008, Red Hat, Inc.
+# Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+
+
+SUBSYSTEM!="block", GOTO="lvm_end"
+ACTION!="add|change", GOTO="lvm_end"
+KERNEL!="dm-*", GOTO="lvm_end"
+
+IMPORT{program}="vol_id --export $tempnode"
+
+ENV{ID_FS_TYPE}=="LVM2_member", RUN+="/bin/sh -c '/sbin/lvm vgscan; /sbin/lvm vgchange -ay'"
+
+OPTIONS="link_priority=-100"
+ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{ID_FS_UUID_ENC}=="?*", SYMLINK+="disk/by-uuid/$env{ID_FS_UUID_ENC}"
+ENV{ID_FS_USAGE}=="filesystem|other", ENV{ID_FS_LABEL_ENC}=="?*", SYMLINK+="disk/by-label/$env{ID_FS_LABEL_ENC}"
+
+
+LABEL="lvm_end"
diff --git a/modules.d/90lvm/64-lvm.rules b/modules.d/90lvm/64-lvm.rules
index 8a2fcc4..3eddd07 100644
--- a/modules.d/90lvm/64-lvm.rules
+++ b/modules.d/90lvm/64-lvm.rules
@@ -6,8 +6,15 @@
 
 SUBSYSTEM!="block", GOTO="lvm_end"
 ACTION!="add|change", GOTO="lvm_end"
+KERNEL!="dm-*", GOTO="lvm_end"
+
+IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
 
-KERNEL=="dm-[0-9]*", IMPORT{program}="vol_id --export $tempnode"
 ENV{ID_FS_TYPE}=="LVM2_member", RUN+="/bin/sh -c '/sbin/lvm vgscan; /sbin/lvm vgchange -ay'"
 
+OPTIONS="link_priority=-100"
+ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{ID_FS_UUID_ENC}=="?*", SYMLINK+="disk/by-uuid/$env{ID_FS_UUID_ENC}"
+ENV{ID_FS_USAGE}=="filesystem|other", ENV{ID_FS_LABEL_ENC}=="?*", SYMLINK+="disk/by-label/$env{ID_FS_LABEL_ENC}"
+
+
 LABEL="lvm_end"
diff --git a/modules.d/90lvm/install b/modules.d/90lvm/install
index d32748b..48f6ec7 100755
--- a/modules.d/90lvm/install
+++ b/modules.d/90lvm/install
@@ -1,3 +1,7 @@
 #!/bin/bash
 inst lvm
-inst_rules "$moddir/64-lvm.rules" 64-device-mapper.rules
\ No newline at end of file
+if [ -x /lib/udev/vol_id ]; then
+    inst_rules "$moddir/64-lvm-vol_id.rules" 64-device-mapper.rules
+else
+    inst_rules "$moddir/64-lvm.rules" 64-device-mapper.rules
+fi
diff --git a/modules.d/90mdraid/65-md-incremental.rules b/modules.d/90mdraid/65-md-incremental.rules
new file mode 100644
index 0000000..3dec8df
--- /dev/null
+++ b/modules.d/90mdraid/65-md-incremental.rules
@@ -0,0 +1,8 @@
+# This file causes block devices with Linux RAID (mdadm) signatures to
+# automatically cause mdadm to be run.
+# See udev(8) for syntax
+
+SUBSYSTEM=="block", ACTION=="add", ENV{ID_FS_TYPE}=="linux_raid_member", \
+	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
+	RUN+="/bin/bash -c '[ ! -f /dev/.in_sysinit ] && /sbin/mdadm -I $env{DEVNAME}'"
+
diff --git a/modules.d/90mdraid/install b/modules.d/90mdraid/install
index a6fad0d..9b69941 100755
--- a/modules.d/90mdraid/install
+++ b/modules.d/90mdraid/install
@@ -3,7 +3,14 @@ dracut_install mdadm
 inst /etc/passwd
 inst /etc/group
 instmods =drivers/md
-inst_rules "$moddir/61-mdadm.rules"
+
+if [ -x /lib/udev/vol_id ]; then
+    inst_rules "$moddir/61-mdadm.rules"
+else
+    inst_rules "$moddir/65-md-incremental.rules"
+    inst_rules 64-md-raid.rules
+fi
+
 [ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf /etc/mdadm.conf
 [ -f /etc/mdadm.conf ] && inst /etc/mdadm.conf
 if [ -x  /sbin/mdmon ] ; then
diff --git a/modules.d/95nbd/61-nbd-vol_id.rules b/modules.d/95nbd/61-nbd-vol_id.rules
new file mode 100644
index 0000000..67c2fb2
--- /dev/null
+++ b/modules.d/95nbd/61-nbd-vol_id.rules
@@ -0,0 +1,7 @@
+SUBSYSTEM!="block", GOTO="nbd_end"
+ACTION!="change", GOTO="nbd_end"
+
+KERNEL=="nbd[0-9]*", IMPORT{program}="vol_id --export $tempnode"
+KERNEL=="nbd[0-9]*", IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
+
+LABEL="nbd_end"
diff --git a/modules.d/95nbd/61-nbd.rules b/modules.d/95nbd/61-nbd.rules
index 5892cf3..f8c9509 100644
--- a/modules.d/95nbd/61-nbd.rules
+++ b/modules.d/95nbd/61-nbd.rules
@@ -1,6 +1,6 @@
 SUBSYSTEM!="block", GOTO="nbd_end"
-ACTION!="add|change", GOTO="nbd_end"
+ACTION!="change", GOTO="nbd_end"
 
-KERNEL=="nbd*", IMPORT{program}="vol_id --export $tempnode"
+KERNEL=="nbd[0-9]*", IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
 
 LABEL="nbd_end"
diff --git a/modules.d/95nbd/install b/modules.d/95nbd/install
index dace08f..76091a1 100755
--- a/modules.d/95nbd/install
+++ b/modules.d/95nbd/install
@@ -2,6 +2,12 @@
 
 inst nbd-client
 inst_hook cmdline 90 "$moddir/parse-nbdroot.sh"
-inst_rules "$moddir/61-nbd.rules"
+
+if [ -x /lib/udev/vol_id ]; then
+    inst_rules "$moddir/61-nbd-vol_id.rules"
+else
+    inst_rules "$moddir/61-nbd.rules"
+fi
+
 inst "$moddir/nbdroot" "/sbin/nbdroot"
 instmods nbd
diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
index c5d73a6..d55c61a 100755
--- a/modules.d/95udev-rules/install
+++ b/modules.d/95udev-rules/install
@@ -8,7 +8,11 @@ inst_rules 50-udev-default.rules 60-persistent-storage.rules \
     61-persistent-storage-edd.rules 80-drivers.rules 95-udev-late.rules 
 #Some debian udev rules are named differently
 inst_rules 50-udev.rules 95-late.rules
- 
+
+if [ ! -x /lib/udev/vol_id ]; then
+    dracut_install blkid
+fi
+
 if ldd $(find_binary udevd) |grep -q /lib64/libc; then
     dracut_install /lib64/libnss_files*
 else
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
