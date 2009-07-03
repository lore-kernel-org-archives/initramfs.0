From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 09/10] initqueue now loops until /dev/root exists or root is mounted
Date: Fri,  3 Jul 2009 18:45:19 +0200
Message-ID: <1246639520-3094-10-git-send-email-harald@redhat.com>
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

init now has the following points to inject scripts:

/cmdline/*.sh
   scripts for command line parsing

/pre-udev/*.sh
   scripts to run before udev is started

/pre-trigger/*.sh
   scripts to run before the main udev trigger is pulled

/initqueue/*.sh
   runs in parallel to the udev trigger
   Udev events can add scripts here with /sbin/initqueue.
   If /sbin/initqueue is called with the "--onetime" option, the script
   will be removed after it was run.
   If /initqueue/work is created and udev >= 143 then this loop can
   process the jobs in parallel to the udevtrigger.
   If the udev queue is empty and no root device is found or no root
   filesystem was mounted, the user will be dropped to a shell after
   a timeout.
   Scripts can remove themselves from the initqueue by "rm $job".

/pre-mount/*.sh
   scripts to run before the root filesystem is mounted
   NFS is an exception, because it has no device node to be created
   and mounts in the udev events

/mount/*.sh
   scripts to mount the root filesystem
   NFS is an exception, because it has no device node to be created
   and mounts in the udev events
   If the udev queue is empty and no root device is found or no root
   filesystem was mounted, the user will be dropped to a shell after
   a timeout.

/pre-pivot/*.sh
   scripts to run before the real init is executed and the initramfs
   disappears
   All processes started before should be killed here.

The behaviour of the dmraid module demonstrates how to use the new
mechanism. If it detects a device which is part of a raidmember from a
udev rule, it installs a job to scan for dmraid devices, if the udev
queue is empty. After a scan, it removes itsself from the queue.
---
 modules.d/50plymouth/63-luks.rules         |    2 +-
 modules.d/90crypt/70-luks.rules            |    2 +-
 modules.d/90dmraid/61-dmraid.rules         |   12 ++++
 modules.d/90dmraid/dmraid.sh               |    3 -
 modules.d/90dmraid/dmraid_scan             |    8 +++
 modules.d/90dmraid/install                 |    3 +-
 modules.d/95rootfs-block/block-genrules.sh |    4 ++
 modules.d/95rootfs-block/install           |    1 +
 modules.d/99base/init                      |   82 +++++++++++++++-------------
 modules.d/99base/initqueue                 |   11 +++-
 test/TEST-10-RAID/test.sh                  |    2 +-
 test/TEST-30-ISCSI/test.sh                 |    2 +-
 test/TEST-40-NBD/test.sh                   |    2 +-
 13 files changed, 85 insertions(+), 49 deletions(-)
 create mode 100644 modules.d/90dmraid/61-dmraid.rules
 delete mode 100644 modules.d/90dmraid/dmraid.sh
 create mode 100755 modules.d/90dmraid/dmraid_scan

diff --git a/modules.d/50plymouth/63-luks.rules b/modules.d/50plymouth/63-luks.rules
index c3c6627..f55bf39 100644
--- a/modules.d/50plymouth/63-luks.rules
+++ b/modules.d/50plymouth/63-luks.rules
@@ -7,6 +7,6 @@
 SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
 
-ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/initqueue /sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
+ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/initqueue --onetime /sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
 
 LABEL="luks_end"
diff --git a/modules.d/90crypt/70-luks.rules b/modules.d/90crypt/70-luks.rules
index c3c6627..f55bf39 100644
--- a/modules.d/90crypt/70-luks.rules
+++ b/modules.d/90crypt/70-luks.rules
@@ -7,6 +7,6 @@
 SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
 
-ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/initqueue /sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
+ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/sbin/initqueue --onetime /sbin/cryptroot-ask $env{DEVNAME} luks-$env{ID_FS_UUID}"
 
 LABEL="luks_end"
diff --git a/modules.d/90dmraid/61-dmraid.rules b/modules.d/90dmraid/61-dmraid.rules
new file mode 100644
index 0000000..a8034db
--- /dev/null
+++ b/modules.d/90dmraid/61-dmraid.rules
@@ -0,0 +1,12 @@
+# This file causes block devices with Linux RAID (mdadm) signatures to
+# automatically cause mdadm to be run.
+# See udev(8) for syntax
+
+SUBSYSTEM!="block", GOTO="dm_end"
+ACTION!="add|change", GOTO="dm_end"
+
+ENV{ID_FS_TYPE}=="linux_raid_member", GOTO="dm_end"
+
+ENV{ID_FS_TYPE}=="*_raid_member", RUN+="/sbin/initqueue /sbin/dmraid_scan"
+
+LABEL="dm_end"
diff --git a/modules.d/90dmraid/dmraid.sh b/modules.d/90dmraid/dmraid.sh
deleted file mode 100644
index 4e2d5bf..0000000
--- a/modules.d/90dmraid/dmraid.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-dmraid -ay -Z
-udevadm settle --timeout=30 >/dev/null 2>&1 
-
diff --git a/modules.d/90dmraid/dmraid_scan b/modules.d/90dmraid/dmraid_scan
new file mode 100755
index 0000000..433e5d3
--- /dev/null
+++ b/modules.d/90dmraid/dmraid_scan
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+if udevadm settle --timeout=0 >/dev/null 2>&1; then
+    # run dmraid if udev has settled
+    dmraid -ay -Z
+    [ -e "$job" ] && rm -f "$job"
+fi
+
diff --git a/modules.d/90dmraid/install b/modules.d/90dmraid/install
index 636f1d2..9314c00 100755
--- a/modules.d/90dmraid/install
+++ b/modules.d/90dmraid/install
@@ -1,4 +1,5 @@
 #!/bin/bash
 dracut_install dmraid 
-inst_hook pre-mount 10 "$moddir/dmraid.sh"
+inst "$moddir/dmraid_scan" /sbin/dmraid_scan
 inst_rules 64-md-raid.rules
+inst_rules "$moddir/61-dmraid.rules"
diff --git a/modules.d/95rootfs-block/block-genrules.sh b/modules.d/95rootfs-block/block-genrules.sh
index 5d1a669..10471ea 100644
--- a/modules.d/95rootfs-block/block-genrules.sh
+++ b/modules.d/95rootfs-block/block-genrules.sh
@@ -5,4 +5,8 @@ if [ "${root%%:*}" = "block" ]; then
     printf 'SYMLINK=="%s", SYMLINK+="root"\n' \
 	${root#block:/dev/} 
     ) >> /etc/udev/rules.d/99-mount.rules
+    (
+    printf '[ -e "%s" ] && { ln -s "%s" /dev/root; rm "$job"; }\n' \
+	"${root#block:}" "${root#block:}"
+    ) >> /initqueue/blocksymlink.sh
 fi
diff --git a/modules.d/95rootfs-block/install b/modules.d/95rootfs-block/install
index 618d357..d6c161a 100755
--- a/modules.d/95rootfs-block/install
+++ b/modules.d/95rootfs-block/install
@@ -1,4 +1,5 @@
 #!/bin/sh
+dracut_install ln
 inst_hook cmdline 95 "$moddir/parse-block.sh"
 inst_hook pre-udev 30 "$moddir/block-genrules.sh"
 inst_hook mount 99 "$moddir/mount-root.sh"
diff --git a/modules.d/99base/init b/modules.d/99base/init
index bb20220..f082765 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -16,36 +16,6 @@ emergency_shell()
     sh -i
 }
 
-do_initqueue()
-{
-    while :; do
-        # bail out, if we have mounted the root filesystem
-	[ -d "$NEWROOT/proc" ] && break;
-
-        # check if root can be mounted
-        [ -e /dev/root ] && break;
-
-	if [ $UDEVVERSION -ge 143 ]; then
-	    udevadm settle --exit-if-exists=/initqueue/work --exit-if-exists=/dev/root
-	else
-	    udevadm settle --timeout=30
-	fi
-	[ -f /initqueue/work ] || break
-	rm /initqueue/work
-	
-	for job in /initqueue/*.job; do
-	    . $job
-	    rm -f $job
-
-            # bail out, if we have mounted the root filesystem
-	    [ -d "$NEWROOT/proc" ] && break;
-
-            # check if root can be mounted
-	    [ -e /dev/root ] && break;
-	done
-    done
-}
-
 export PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export TERM=linux
 NEWROOT="/sysroot"
@@ -116,7 +86,47 @@ source_all pre-trigger
 # then the rest
 udevadm trigger $udevtriggeropts  >/dev/null 2>&1
 
-do_initqueue
+i=0
+while :; do
+    # bail out, if we have mounted the root filesystem
+    [ -d "$NEWROOT/proc" ] && break;
+
+    # check if root can be mounted
+    [ -e /dev/root ] && break;
+
+    if [ $UDEVVERSION -ge 143 ]; then
+        udevadm settle --exit-if-exists=/initqueue/work --exit-if-exists=/dev/root 
+    else
+        udevadm settle --timeout=30
+    fi
+    unset queuetriggered
+    if [ -f /initqueue/work ]; then
+        rm /initqueue/work
+	queuetriggered="1"
+    fi
+    	
+    for job in /initqueue/*.sh; do
+	[ -e "$job" ] || break
+        job=$job . $job
+
+        # bail out, if we have mounted the root filesystem
+        [ -d "$NEWROOT/proc" ] && break;
+        # check if root can be mounted
+        [ -e /dev/root ] && break;
+    done
+
+    [ -n "$queuetriggered" ] && continue
+
+    if udevadm settle --timeout=0 >/dev/null 2>&1; then
+        # no more udev jobs
+        sleep 0.5
+        i=$(($i+1))
+        [ $i -gt 20 ] && getarg rdshell \
+            && { flock -s 9 ; emergency_shell; } 9>/.console_lock
+    fi
+done
+unset job
+unset queuetriggered
 
 # pre-mount happens before we try to mount the root filesystem,
 # and happens once.
@@ -124,23 +134,19 @@ getarg 'rdbreak=pre-mount' && emergency_shell
 source_all pre-mount
 getarg 'rdbreak=mount' && emergency_shell
 
-do_initqueue
-
 # mount scripts actually try to mount the root filesystem, and may
 # be sourced any number of times. As soon as one suceeds, no more are sourced.
 i=0
 while :; do
     [ -d "$NEWROOT/proc" ] && break;
-
     for f in /mount/*.sh; do
        [ -f "$f" ] && . "$f"
-       do_initqueue
-       [ "$ROOTFS_MOUNTED" ] && break;
+       [ -d "$NEWROOT/proc" ] && break;
     done
 
-    sleep 0.5
     i=$(($i+1))
-    { flock -s 9 ; [ $i -gt 20 ] && emergency_shell; } 9>/.console_lock
+    [ $i -gt 20 ] && getarg rdshell \
+        && { flock -s 9 ; emergency_shell; } 9>/.console_lock
 done
 
 # pre pivot scripts are sourced just before we switch over to the new root.
diff --git a/modules.d/99base/initqueue b/modules.d/99base/initqueue
index 0a760b7..a5c6ef6 100755
--- a/modules.d/99base/initqueue
+++ b/modules.d/99base/initqueue
@@ -1,5 +1,12 @@
 #!/bin/sh
 
-echo "$@" > /tmp/$$.job
-mv /tmp/$$.job /initqueue/
+if [ "$1" = "--onetime" ]; then
+    onetime="yes"
+    shift
+fi
+echo "$@" > /tmp/$$.sh
+if [ -n "$onetime" ]; then
+   echo '[ -e "$job" ] && rm "$job"' >> /tmp/$$.sh
+fi
+mv /tmp/$$.sh /initqueue/
 >> /initqueue/work
diff --git a/test/TEST-10-RAID/test.sh b/test/TEST-10-RAID/test.sh
index 23f9aff..700c377 100755
--- a/test/TEST-10-RAID/test.sh
+++ b/test/TEST-10-RAID/test.sh
@@ -38,7 +38,7 @@ test_setup() {
 	initdir=overlay
 	. $basedir/dracut-functions
 	dracut_install sfdisk mke2fs poweroff cp umount 
-	inst_simple ./create-root.sh /pre-mount/01create-root.sh
+	inst_simple ./create-root.sh /initqueue/01create-root.sh
     )
  
     # create an initramfs that will create the target root filesystem.
diff --git a/test/TEST-30-ISCSI/test.sh b/test/TEST-30-ISCSI/test.sh
index 6469950..d9da529 100755
--- a/test/TEST-30-ISCSI/test.sh
+++ b/test/TEST-30-ISCSI/test.sh
@@ -81,7 +81,7 @@ test_setup() {
 	initdir=overlay
 	. $basedir/dracut-functions
 	dracut_install sfdisk mke2fs poweroff cp umount 
-	inst_simple ./create-root.sh /pre-mount/01create-root.sh
+	inst_simple ./create-root.sh /initqueue/01create-root.sh
     )
  
     # create an initramfs that will create the target root filesystem.
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
index 2f54511..07de7fe 100755
--- a/test/TEST-40-NBD/test.sh
+++ b/test/TEST-40-NBD/test.sh
@@ -184,7 +184,7 @@ make_encrypted_root() {
 	initdir=overlay
 	. $basedir/dracut-functions
 	dracut_install mke2fs poweroff cp umount
-	inst_simple ./create-root.sh /pre-mount/01create-root.sh
+	inst_simple ./create-root.sh /initqueue/01create-root.sh
     )
 
     # create an initramfs that will create the target root filesystem.
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
