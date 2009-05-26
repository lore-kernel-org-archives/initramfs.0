From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] Final fixups to make the full testsuite work.
Date: Mon, 25 May 2009 19:57:04 -0700 (PDT)
Message-ID: <151d32e89583815962af8d721b17d0b320f80a2f.1243306326.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=iRblRYyukddu8YDKop3rXFoDNEYBcpKma9J5yH9Mg/s=;
        b=SjVegKInv2UBmrlb0lssVynK7EA8Ba1eHK57QMAGqeSazHc1Ee4BG8aUPUW+BKXoIa
         BXOu1z1+QyFcpHDEQHiGIIjxBXcnqqcDqa5dVwbBhbBoZszHrmvqVB1XOBXm85WDWOfD
         nwRRmC7tQRGxim+eRm9XwnD6uA/FqvSrQxzUM=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

test-10 now completes sucessfully.  What has changed:

Added some logging functionality.  All info, warning, and error messages
are logged to a logfile, which is cleared on every dracut run.

We no longer try to incrementally assemble mdraid arrays.  It did not
work using Ubuntu 9.04 x86_64.  It is probably a bug in mdadm, but for
now just fall back to auto assembly. A better fix would be appreciated, as
long as it does not break the test suite and does not remove mdraid testing
from the test suite.

create-root.sh mounts the root filesystem straight away.

It takes forever (or, at least 30 seconds) to actually unlock the LUKS device. 
This did not happen when the unlock was not done in a udev rule.  
It is either cryptseup behaving badly when called from udev, or demons.

We should really not add all the network modules to the initramfs, at least for
testing.  Doing so really bloats things.

Anyways, I am throwing this out there for discussion and ideas on better
ways of fixing these warts.

---
 dracut-functions                     |   10 ++++++++++
 modules.d/90mdraid/70-mdadm.rules    |   12 ------------
 modules.d/90mdraid/install           |    2 +-
 modules.d/90mdraid/mdadm-assemble.sh |    5 +++++
 test/TEST-10-RAID/create-root.sh     |    1 +
 test/TEST-10-RAID/test.sh            |    2 +-
 6 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index ac22fcd..1cea9c7 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -28,16 +28,26 @@ IF_dynamic=""
 # Generic substring function.  If $2 is in $1, return 0.
 strstr() { [[ ! ${1#*$2*} = $1 ]]; }
 
+if ! [[ $dracutlogfile ]]; then
+    [[ $dsrc = /usr/lib/dracut ]] && \
+	dracutlogfile=/var/log/dracut/log || \
+	dracutlogfile=/tmp/dracut.log
+    >"$dracutlogfile"
+fi
+
 dwarning() {
     echo "W: $@" >&2
+    echo "W: $@" >>"$dracutlogfile"
 }
 
 dinfo() {
     [[ $beverbose ]] && echo "I: $@" >&2
+    echo "I: $@" >>"$dracutlogfile"
 }
 
 derror() {
     echo "E: $@" >&2
+    echo "E: $@" >>"$dracutlogfile"
 }
 
 # $1 = file to copy to ramdisk
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
index 1885f7c..70a0bc7 100755
--- a/modules.d/90mdraid/install
+++ b/modules.d/90mdraid/install
@@ -4,8 +4,8 @@ inst /etc/passwd
 inst /etc/group
 instmods =drivers/md
 [ -x  /sbin/mdmon ] && dracut_install mdmon
-inst_rules "$moddir/70-mdadm.rules"
 [ -f /etc/mdadm/mdadm.conf ] && inst /etc/mdadm/mdadm.conf /etc/mdadm.conf
 [ -f /etc/mdadm.conf ] && inst /etc/mdadm.conf
 inst_hook pre-pivot 30 "$moddir/mdmon-pre-pivot.sh"
+inst_hook mount 05 "$moddir/mdadm-assemble.sh"
 
diff --git a/modules.d/90mdraid/mdadm-assemble.sh b/modules.d/90mdraid/mdadm-assemble.sh
new file mode 100755
index 0000000..1b05a3b
--- /dev/null
+++ b/modules.d/90mdraid/mdadm-assemble.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+mdadm -AqsR
+udevadm trigger
+udevadm settle --timeout=5
\ No newline at end of file
diff --git a/test/TEST-10-RAID/create-root.sh b/test/TEST-10-RAID/create-root.sh
index 29f349c..368f90a 100755
--- a/test/TEST-10-RAID/create-root.sh
+++ b/test/TEST-10-RAID/create-root.sh
@@ -16,3 +16,4 @@ lvm lvcreate -l 100%FREE -n root dracut
 udevadm settle --timeout=4
 [ -b /dev/dracut/root ] || emergency_shell
 mke2fs /dev/dracut/root
+mount /dev/dracut/root /sysroot
diff --git a/test/TEST-10-RAID/test.sh b/test/TEST-10-RAID/test.sh
index f7abe54..c003420 100755
--- a/test/TEST-10-RAID/test.sh
+++ b/test/TEST-10-RAID/test.sh
@@ -33,7 +33,7 @@ test_setup() {
 	. $basedir/dracut-functions
 	dracut_install sfdisk mke2fs poweroff cp umount 
 	inst_simple ./halt.sh /pre-pivot/02halt.sh
-	inst_simple ./copy-root.sh /mount/01copy-root.sh
+	inst_simple ./copy-root.sh /mount/95copy-root.sh
 	inst_simple ./create-root.sh /pre-mount/01create-root.sh
     )
  
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
