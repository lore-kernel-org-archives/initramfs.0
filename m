From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/7] remove redundant vol_id run from out udev rules
Date: Thu, 18 Jun 2009 15:26:21 +0200
Message-ID: <1245331581-2453-8-git-send-email-harald@redhat.com>
References: <1245331581-2453-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245331581-2453-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

moved mdadm rules before luks rules
add nbd vol_id rules
---
 modules.d/50plymouth-pre0.7/63-luks.rules |    2 --
 modules.d/50plymouth/63-luks.rules        |    1 -
 modules.d/90crypt/63-luks.rules           |    1 -
 modules.d/90lvm/64-lvm.rules              |    2 +-
 modules.d/90mdraid/61-mdadm.rules         |   12 ++++++++++++
 modules.d/90mdraid/70-mdadm.rules         |   12 ------------
 modules.d/90mdraid/install                |    2 +-
 modules.d/95nbd/61-nbd.rules              |    6 ++++++
 modules.d/95nbd/install                   |    1 +
 9 files changed, 21 insertions(+), 18 deletions(-)
 create mode 100644 modules.d/90mdraid/61-mdadm.rules
 delete mode 100644 modules.d/90mdraid/70-mdadm.rules
 create mode 100644 modules.d/95nbd/61-nbd.rules

diff --git a/modules.d/50plymouth-pre0.7/63-luks.rules b/modules.d/50plymouth-pre0.7/63-luks.rules
index 893577b..711e865 100644
--- a/modules.d/50plymouth-pre0.7/63-luks.rules
+++ b/modules.d/50plymouth-pre0.7/63-luks.rules
@@ -6,8 +6,6 @@
 
 SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
-
-KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
 ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
 
 LABEL="luks_end"
diff --git a/modules.d/50plymouth/63-luks.rules b/modules.d/50plymouth/63-luks.rules
index 01a1b1d..cfa619b 100644
--- a/modules.d/50plymouth/63-luks.rules
+++ b/modules.d/50plymouth/63-luks.rules
@@ -7,7 +7,6 @@
 SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
 
-KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
 ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
 
 LABEL="luks_end"
diff --git a/modules.d/90crypt/63-luks.rules b/modules.d/90crypt/63-luks.rules
index 01a1b1d..cfa619b 100644
--- a/modules.d/90crypt/63-luks.rules
+++ b/modules.d/90crypt/63-luks.rules
@@ -7,7 +7,6 @@
 SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
 
-KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
 ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
 
 LABEL="luks_end"
diff --git a/modules.d/90lvm/64-lvm.rules b/modules.d/90lvm/64-lvm.rules
index f742287..8a2fcc4 100644
--- a/modules.d/90lvm/64-lvm.rules
+++ b/modules.d/90lvm/64-lvm.rules
@@ -7,7 +7,7 @@
 SUBSYSTEM!="block", GOTO="lvm_end"
 ACTION!="add|change", GOTO="lvm_end"
 
-KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
+KERNEL=="dm-[0-9]*", IMPORT{program}="vol_id --export $tempnode"
 ENV{ID_FS_TYPE}=="LVM2_member", RUN+="/bin/sh -c '/sbin/lvm vgscan; /sbin/lvm vgchange -ay'"
 
 LABEL="lvm_end"
diff --git a/modules.d/90mdraid/61-mdadm.rules b/modules.d/90mdraid/61-mdadm.rules
new file mode 100644
index 0000000..1a5d98c
--- /dev/null
+++ b/modules.d/90mdraid/61-mdadm.rules
@@ -0,0 +1,12 @@
+# This file causes block devices with Linux RAID (mdadm) signatures to
+# automatically cause mdadm to be run.
+# See udev(8) for syntax
+
+SUBSYSTEM!="block", GOTO="raid_end"
+ACTION!="add|change", GOTO="raid_end"
+KERNEL=="md/*", GOTO="raid_end"
+
+KERNEL=="md*", IMPORT{program}="vol_id --export $tempnode"
+ENV{ID_FS_TYPE}=="linux_raid_member", RUN+="/sbin/mdadm -IR $root/%k"
+
+LABEL="raid_end"
diff --git a/modules.d/90mdraid/70-mdadm.rules b/modules.d/90mdraid/70-mdadm.rules
deleted file mode 100644
index ae54c96..0000000
--- a/modules.d/90mdraid/70-mdadm.rules
+++ /dev/null
@@ -1,12 +0,0 @@
-# This file causes block devices with Linux RAID (mdadm) signatures to
-# automatically cause mdadm to be run.
-# See udev(8) for syntax
-
-SUBSYSTEM!="block", GOTO="raid_end"
-ACTION!="add|change", GOTO="raid_end"
-KERNEL=="md/*", GOTO="raid_end"
-
-KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
-ENV{ID_FS_TYPE}=="linux_raid_member", RUN+="/sbin/mdadm -IR $root/%k"
-
-LABEL="raid_end"
diff --git a/modules.d/90mdraid/install b/modules.d/90mdraid/install
index 6b729d9..a6fad0d 100755
--- a/modules.d/90mdraid/install
+++ b/modules.d/90mdraid/install
@@ -3,7 +3,7 @@ dracut_install mdadm
 inst /etc/passwd
 inst /etc/group
 instmods =drivers/md
-inst_rules "$moddir/70-mdadm.rules"
+inst_rules "$moddir/61-mdadm.rules"
 [ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf /etc/mdadm.conf
 [ -f /etc/mdadm.conf ] && inst /etc/mdadm.conf
 if [ -x  /sbin/mdmon ] ; then
diff --git a/modules.d/95nbd/61-nbd.rules b/modules.d/95nbd/61-nbd.rules
new file mode 100644
index 0000000..5892cf3
--- /dev/null
+++ b/modules.d/95nbd/61-nbd.rules
@@ -0,0 +1,6 @@
+SUBSYSTEM!="block", GOTO="nbd_end"
+ACTION!="add|change", GOTO="nbd_end"
+
+KERNEL=="nbd*", IMPORT{program}="vol_id --export $tempnode"
+
+LABEL="nbd_end"
diff --git a/modules.d/95nbd/install b/modules.d/95nbd/install
index eca74e4..dace08f 100755
--- a/modules.d/95nbd/install
+++ b/modules.d/95nbd/install
@@ -2,5 +2,6 @@
 
 inst nbd-client
 inst_hook cmdline 90 "$moddir/parse-nbdroot.sh"
+inst_rules "$moddir/61-nbd.rules"
 inst "$moddir/nbdroot" "/sbin/nbdroot"
 instmods nbd
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
