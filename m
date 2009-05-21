From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] Create test image on an md array and improve cryptroot handling
Date: Wed, 20 May 2009 19:55:13 -0700 (PDT)
Message-ID: <cb79a1266ebbf0fc48a8bfecf10d9f915ea8ac5c.1242874219.git.victor.lowther@gmail.com>
References: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=05Sx8KrtuKqbEZaHR2b6DHBN1a+LfBZMsiaq384/87E=;
        b=PN1OgXFsdn07E9FP/Zvccr6d0pMnwj5PNgHmObYKuexbEI4xeg/xacc21Pg4HtEMUO
         ezcI9nnvUrQ2auG4cryY2TySW72cjEJMQTrUmMCmpcS8Dau7l9Mub4dU7d2TfmVVZHSI
         zIwhl9kPVbD+vKOSX1SY1ScIi2CquUG7aueyw=
In-Reply-To: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If we purport to test booting to an md raid, we may as well test it.

We do not need the plymouth module and the normal crypt module to include
duplicate functionality.
---
 Makefile                           |    1 +
 modules.d/00test/create-root.sh    |   13 +++++++------
 modules.d/50plymouth/install       |    4 +---
 modules.d/90crypt/63-luks.rules    |    2 +-
 modules.d/90crypt/cryptroot-ask.sh |    5 ++---
 modules.d/90crypt/install          |    2 +-
 modules.d/90mdraid/70-mdadm.rules  |   10 ++++++++--
 modules.d/90mdraid/install         |    7 +++++--
 test/make-test-root                |    2 +-
 9 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index bd57c96..d46dc8a 100644
--- a/Makefile
+++ b/Makefile
@@ -23,6 +23,7 @@ clean:
 	rm -f modules.d/99base/switch_root
 	rm -f test-*.img
 	rm -f test/initramfs.*
+	rm -f test/root.ext2
 
 archive: dracut-$(VERSION)-$(GITVERSION).tar.bz2
 
diff --git a/modules.d/00test/create-root.sh b/modules.d/00test/create-root.sh
index c756f4f..29c6f95 100755
--- a/modules.d/00test/create-root.sh
+++ b/modules.d/00test/create-root.sh
@@ -1,14 +1,15 @@
 #!/bin/sh
-sfdisk /dev/sda <<EOF
-
-;
-;
+sfdisk -C 640 -H 2 -S 32 -L /dev/sda <<EOF
+,213
+,213
+,213
 ;
 EOF
+mdadm --create /dev/md0 --run --auto=yes --level=5 --raid-devices=3 /dev/sda1 /dev/sda2 /dev/sda3
 echo -n test >keyfile
-cryptsetup -q luksFormat /dev/sda1 /keyfile
+cryptsetup -q luksFormat /dev/md0 /keyfile
 echo "The passphrase is test"
-cryptsetup luksOpen /dev/sda1 dracut_crypt_test </keyfile
+cryptsetup luksOpen /dev/md0 dracut_crypt_test </keyfile
 lvm pvcreate -ff  -y /dev/mapper/dracut_crypt_test
 lvm vgcreate dracut /dev/mapper/dracut_crypt_test
 lvm lvcreate -l 100%FREE -n root dracut
diff --git a/modules.d/50plymouth/install b/modules.d/50plymouth/install
index da477c9..c5b2695 100755
--- a/modules.d/50plymouth/install
+++ b/modules.d/50plymouth/install
@@ -3,7 +3,5 @@
 inst_hook pre-udev 10 "$moddir"/plymouth-start.sh
 inst_hook pre-pivot 90 "$moddir"/plymouth-newroot.sh
 inst_hook emergency 50 "$moddir"/plymouth-emergency.sh
-inst_rules "$moddir/63-luks.rules"
-inst "$moddir"/cryptroot-ask.sh /lib/udev/cryptroot-ask
-inst cryptsetup
+inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
 
diff --git a/modules.d/90crypt/63-luks.rules b/modules.d/90crypt/63-luks.rules
index 893577b..01a1b1d 100644
--- a/modules.d/90crypt/63-luks.rules
+++ b/modules.d/90crypt/63-luks.rules
@@ -8,6 +8,6 @@ SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
 
 KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
-ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
+ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
 
 LABEL="luks_end"
diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 48cc0f7..0c8a0c8 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -1,8 +1,7 @@
 #!/bin/sh
 
 [ -b /dev/mapper/$2 ] && exit 0
-{
-	flock -s 9
-	/sbin/cryptsetup luksOpen -T1 $1 $2 </dev/console >/dev/console 2>&1
+{ flock -s 9; 
+  /sbin/cryptsetup luksOpen -T1 $1 $2 </dev/console >/dev/console 2>&1
 } 9>/.console.lock
 
diff --git a/modules.d/90crypt/install b/modules.d/90crypt/install
index a1e7b01..fcaaa60 100755
--- a/modules.d/90crypt/install
+++ b/modules.d/90crypt/install
@@ -2,4 +2,4 @@
 inst cryptsetup
 instmods dm_crypt cbc aes sha256 xts
 inst_rules "$moddir/63-luks.rules"
-inst "$moddir"/cryptroot-ask.sh /lib/udev/cryptroot-ask
+inst "$moddir"/cryptroot-ask.sh /sbin/cryptroot-ask
diff --git a/modules.d/90mdraid/70-mdadm.rules b/modules.d/90mdraid/70-mdadm.rules
index bd11633..ae54c96 100644
--- a/modules.d/90mdraid/70-mdadm.rules
+++ b/modules.d/90mdraid/70-mdadm.rules
@@ -2,5 +2,11 @@
 # automatically cause mdadm to be run.
 # See udev(8) for syntax
 
-SUBSYSTEM=="block", ACTION=="add|change", ENV{ID_FS_TYPE}=="linux_raid*", \
-	RUN+="/sbin/mdadm -I --auto=yes $root/%k"
+SUBSYSTEM!="block", GOTO="raid_end"
+ACTION!="add|change", GOTO="raid_end"
+KERNEL=="md/*", GOTO="raid_end"
+
+KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
+ENV{ID_FS_TYPE}=="linux_raid_member", RUN+="/sbin/mdadm -IR $root/%k"
+
+LABEL="raid_end"
diff --git a/modules.d/90mdraid/install b/modules.d/90mdraid/install
index 41982f9..1885f7c 100755
--- a/modules.d/90mdraid/install
+++ b/modules.d/90mdraid/install
@@ -1,8 +1,11 @@
 #!/bin/bash
 dracut_install mdadm
+inst /etc/passwd
+inst /etc/group
+instmods =drivers/md
 [ -x  /sbin/mdmon ] && dracut_install mdmon
 inst_rules "$moddir/70-mdadm.rules"
-[ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf "$initdir" /etc/mdadm.conf
-[ -f /etc/mdadm.conf ] && inst /etc/mdadm.conf "$initdir"
+[ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf /etc/mdadm.conf
+[ -f /etc/mdadm.conf ] && inst /etc/mdadm.conf
 inst_hook pre-pivot 30 "$moddir/mdmon-pre-pivot.sh"
 
diff --git a/test/make-test-root b/test/make-test-root
index e49df50..cfc8758 100755
--- a/test/make-test-root
+++ b/test/make-test-root
@@ -25,7 +25,7 @@ unset initdir
 # results in cryptsetup not being able to unlock the LVM PV.
 # Probably a bug in cryptsetup, but...
 ./dracut -l -i "$targetfs" /source \
-    -m "dash kernel-modules test crypt lvm udev-rules base rootfs-block" \
+    -m "dash kernel-modules test crypt lvm mdraid udev-rules base rootfs-block" \
     -d "ata_piix ext2 sd_mod" \
     -f test/initramfs.makeroot
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
