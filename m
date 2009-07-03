From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 10/10] add "rdshell" command line argument
Date: Fri,  3 Jul 2009 18:45:20 +0200
Message-ID: <1246639520-3094-11-git-send-email-harald@redhat.com>
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

Only drop to an interactive shell if "rdshell" is specified on the
command line. This prevents malicious users from gaining easy shell
access to the host system (grub might be secured with a password).
---
 dracut.8                   |    3 +++
 modules.d/99base/init      |   37 ++++++++++++++++++++++---------------
 test/TEST-10-RAID/test.sh  |    2 +-
 test/TEST-20-NFS/test.sh   |    2 +-
 test/TEST-30-ISCSI/test.sh |    2 +-
 test/TEST-40-NBD/test.sh   |    2 +-
 6 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/dracut.8 b/dracut.8
index 4bf29a7..4d6ac29 100644
--- a/dracut.8
+++ b/dracut.8
@@ -167,6 +167,9 @@ do not load kernel module <drivername>
 
 .SH Debug
 .TP
+.B rdshell
+drop to a shell, if the imitramfs fails
+.TP
 .B rdinitdebug
 set -x for the dracut shell
 .TP
diff --git a/modules.d/99base/init b/modules.d/99base/init
index f082765..cc42527 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -8,19 +8,25 @@
 emergency_shell()
 {
     exec >/dev/console 2>&1 </dev/console
+    echo ; echo
+    echo $@
     getarg rdinitdebug || dmesg
     source_all emergency
-    echo ; echo
-    echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
-    echo
-    sh -i
+    if getarg rdshell; then
+        echo ; echo
+        echo "Dropping to a shell. Good luck!"
+        echo
+        sh -i
+    else
+        while :; do sleep 1;done
+    fi
 }
 
 export PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export TERM=linux
 NEWROOT="/sysroot"
 
-trap "emergency_shell" 0
+trap "emergency_shell Unkown signal caught!" 0
 
 . /lib/dracut-lib.sh
 
@@ -56,7 +62,7 @@ mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts >/dev/null 2>&1
 UDEVVERSION=$(udevadm --version)
 
 # run scriptlets to parse the command line
-getarg 'rdbreak=cmdline' && emergency_shell
+getarg 'rdbreak=cmdline' && emergency_shell "Break before cmdline"
 source_all cmdline
 
 [ -z "$root" ] && die "No or empty root= argument"
@@ -73,7 +79,7 @@ source_all cmdline
 } > /tmp/root.info
 
 # pre-udev scripts run before udev starts, and are run only once.
-getarg 'rdbreak=pre-udev' && emergency_shell
+getarg 'rdbreak=pre-udev' && emergency_shell "Break before pre-udev"
 source_all pre-udev
 
 # start up udev and trigger cold plugs
@@ -121,8 +127,8 @@ while :; do
         # no more udev jobs
         sleep 0.5
         i=$(($i+1))
-        [ $i -gt 20 ] && getarg rdshell \
-            && { flock -s 9 ; emergency_shell; } 9>/.console_lock
+        [ $i -gt 20 ] \
+            && { flock -s 9 ; emergency_shell "No root device found"; } 9>/.console_lock
     fi
 done
 unset job
@@ -130,10 +136,11 @@ unset queuetriggered
 
 # pre-mount happens before we try to mount the root filesystem,
 # and happens once.
-getarg 'rdbreak=pre-mount' && emergency_shell
+getarg 'rdbreak=pre-mount' && emergency_shell "Break pre-mount"
 source_all pre-mount
-getarg 'rdbreak=mount' && emergency_shell
 
+
+getarg 'rdbreak=mount' && emergency_shell "Break mount"
 # mount scripts actually try to mount the root filesystem, and may
 # be sourced any number of times. As soon as one suceeds, no more are sourced.
 i=0
@@ -145,8 +152,8 @@ while :; do
     done
 
     i=$(($i+1))
-    [ $i -gt 20 ] && getarg rdshell \
-        && { flock -s 9 ; emergency_shell; } 9>/.console_lock
+    [ $i -gt 20 ] \
+        && { flock -s 9 ; emergency_shell "Can't mount root filesystem"; } 9>/.console_lock
 done
 
 # pre pivot scripts are sourced just before we switch over to the new root.
@@ -159,8 +166,8 @@ for i in "$(getarg init=)" /sbin/init /etc/init /init /bin/sh; do
     [ -f "$NEWROOT$i" -a -x "$NEWROOT$i" ] && { INIT="$i"; break; }
 done
 [ "$INIT" ] || {
-    echo "Cannot find init! Please check to make sure you passed"
-    echo "a valid root filesystem!  Dropping to a shell."
+    echo "Cannot find init!"
+    echo "Please check to make sure you passed a valid root filesystem!"
     emergency_shell
 }
 
diff --git a/test/TEST-10-RAID/test.sh b/test/TEST-10-RAID/test.sh
index 700c377..fbad51a 100755
--- a/test/TEST-10-RAID/test.sh
+++ b/test/TEST-10-RAID/test.sh
@@ -9,7 +9,7 @@ KVERSION=${KVERSION-$(uname -r)}
 test_run() {
     $testdir/run-qemu -hda root.ext2 -m 256M -nographic \
 	-net none -kernel /boot/vmlinuz-$KVERSION \
-	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81 $DEBUGFAIL" \
+	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81 rdshell $DEBUGFAIL" \
 	-initrd initramfs.testing
     grep -m 1 -q dracut-root-block-success root.ext2 || return 1
 }
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 4410751..1811eca 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -46,7 +46,7 @@ client_test() {
   	-net nic,macaddr=$mac,model=e1000 \
   	-net socket,mcast=230.0.0.1:1234 \
   	-kernel /boot/vmlinuz-$KVERSION \
-  	-append "$cmdline $DEBUGFAIL ro quiet console=ttyS0,115200n81" \
+  	-append "$cmdline $DEBUGFAIL rdshell ro quiet console=ttyS0,115200n81" \
   	-initrd initramfs.testing
 
     if [[ $? -ne 0 ]] || ! grep -m 1 -q nfs-OK client.img; then
diff --git a/test/TEST-30-ISCSI/test.sh b/test/TEST-30-ISCSI/test.sh
index d9da529..440cd16 100755
--- a/test/TEST-30-ISCSI/test.sh
+++ b/test/TEST-30-ISCSI/test.sh
@@ -37,7 +37,7 @@ run_client() {
   	-net nic,macaddr=52:54:00:12:34:00,model=e1000 \
   	-net socket,mcast=230.0.0.1:1235 \
   	-kernel /boot/vmlinuz-$KVERSION \
-	-append "root=dhcp rw quiet console=ttyS0,115200n81 $DEBUGFAIL" \
+	-append "root=dhcp rw quiet console=ttyS0,115200n81 rdshell $DEBUGFAIL" \
   	-initrd initramfs.testing
     grep -m 1 -q iscsi-OK client.img || return 1
 }
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
index 07de7fe..c3d8bfc 100755
--- a/test/TEST-40-NBD/test.sh
+++ b/test/TEST-40-NBD/test.sh
@@ -50,7 +50,7 @@ client_test() {
 	-net nic,macaddr=$mac,model=e1000 \
 	-net socket,mcast=230.0.0.1:1236 \
 	-kernel /boot/vmlinuz-$KVERSION \
-	-append "$cmdline $DEBUGFAIL ro quiet console=ttyS0,115200n81" \
+	-append "$cmdline $DEBUGFAIL rdshell ro quiet console=ttyS0,115200n81" \
 	-initrd initramfs.testing
 
     if [[ $? -ne 0 ]] || ! grep -m 1 -q nbd-OK flag.img; then
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
