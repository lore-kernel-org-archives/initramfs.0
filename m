From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 3/3] NBD root: add support for LVM/LUKS
Date: Thu, 11 Jun 2009 11:09:45 -0400
Message-ID: <1244732985-14927-4-git-send-email-dave@thedillows.org>
References: <1244732985-14927-1-git-send-email-dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244732985-14927-1-git-send-email-dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

With this change, we can now use LUKS and LVM over NBD. There are
some decisions to be made regarding where we should get the fstype
and fsoptions from (DHCP root vs rootfstype= etc), but the basic
functionality is there.
---
 modules.d/95nbd/nbdroot         |   18 +++++-----
 test/TEST-40-NBD/client-init    |    3 +-
 test/TEST-40-NBD/create-root.sh |   23 ++++++++++++++
 test/TEST-40-NBD/cryptroot-ask  |    6 ++++
 test/TEST-40-NBD/dhcpd.conf     |   10 ++++++
 test/TEST-40-NBD/server-init    |    1 +
 test/TEST-40-NBD/test.sh        |   64 +++++++++++++++++++++++++++++++++++++-
 7 files changed, 113 insertions(+), 12 deletions(-)
 create mode 100755 test/TEST-40-NBD/create-root.sh
 create mode 100755 test/TEST-40-NBD/cryptroot-ask

diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
index 3475239..b7f4cc4 100755
--- a/modules.d/95nbd/nbdroot
+++ b/modules.d/95nbd/nbdroot
@@ -81,16 +81,16 @@ while [ ! -b /dev/nbd0 ]; do
     i=$(( $i + 1))
 done
 
-# XXX netroot expects to have the handler mount things, but we should
-# XXX allow LVM, LUKS, etc over nbd
+# If we didn't get a root= on the command line, then we need to
+# add the udev rules for mounting the nbd0 device
+if [ ! -e /etc/udev/rules.d/99-mount.rules ]; then
+    printf 'KERNEL=="%s", RUN+="/bin/mount -t %s -o %s %s %s"\n' \
+	nbd0 "$nbdfstype" "$fsopts" /dev/nbd0 "$NEWROOT" \
+		> /etc/udev/rules.d/99-mount.rules
+fi
 
 nbd-client $preopts "$nbdserver" "$nbdport" /dev/nbd0 $opts || exit 1
 
-if ! mount -t $nbdfstype -o$fsopts /dev/nbd0 $NEWROOT; then
-    # Mount failed, clean up after ourselves so if we try a different
-    # interface it can succeed
-    nbd-client -d /dev/nbd0
-    exit 1
-fi
-
+# NBD doesn't emit uevents when it gets connected, so kick it
+echo change > /sys/block/nbd0/uevent
 exit 0
diff --git a/test/TEST-40-NBD/client-init b/test/TEST-40-NBD/client-init
index 88b3d65..b0af521 100755
--- a/test/TEST-40-NBD/client-init
+++ b/test/TEST-40-NBD/client-init
@@ -1,7 +1,8 @@
 #!/bin/sh
 exec >/dev/console 2>&1
 while read dev fs fstype opts rest; do
-    [ "$dev" != "/dev/nbd0" ] && continue
+    [ "$dev" == "rootfs" ] && continue
+    [ "$fs" != "/" ] && continue
     echo "nbd-OK $fstype $opts" >/dev/sda
     break
 done < /proc/mounts
diff --git a/test/TEST-40-NBD/create-root.sh b/test/TEST-40-NBD/create-root.sh
new file mode 100755
index 0000000..b5e45e2
--- /dev/null
+++ b/test/TEST-40-NBD/create-root.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# don't let udev and this script step on eachother's toes
+for x in 63-luks.rules 64-lvm.rules 70-mdadm.rules 99-mount-rules; do
+    > "/etc/udev/rules.d/$x"
+done
+udevadm control --reload-rules
+echo -n test >keyfile
+cryptsetup -q luksFormat /dev/sdb /keyfile
+echo "The passphrase is test"
+cryptsetup luksOpen /dev/sdb dracut_crypt_test </keyfile && \
+lvm pvcreate -ff  -y /dev/mapper/dracut_crypt_test && \
+lvm vgcreate dracut /dev/mapper/dracut_crypt_test && \
+lvm lvcreate -l 100%FREE -n root dracut && \
+lvm vgchange -ay && \
+mke2fs -j /dev/dracut/root && \
+mkdir -p /sysroot && \
+mount /dev/dracut/root /sysroot && \
+cp -a -t /sysroot /source/* && \
+umount /sysroot && \
+lvm lvchange -a n /dev/dracut/root && \
+cryptsetup luksClose /dev/mapper/dracut_crypt_test && \
+echo "dracut-root-block-created" >/dev/sda
+poweroff -f
diff --git a/test/TEST-40-NBD/cryptroot-ask b/test/TEST-40-NBD/cryptroot-ask
new file mode 100755
index 0000000..db27c5b
--- /dev/null
+++ b/test/TEST-40-NBD/cryptroot-ask
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+[ -b /dev/mapper/$2 ] && exit 0
+echo -n test >/keyfile
+/sbin/cryptsetup luksOpen $1 $2 </keyfile
+
diff --git a/test/TEST-40-NBD/dhcpd.conf b/test/TEST-40-NBD/dhcpd.conf
index f9eeead..942bc6a 100644
--- a/test/TEST-40-NBD/dhcpd.conf
+++ b/test/TEST-40-NBD/dhcpd.conf
@@ -53,4 +53,14 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 			fixed-address 192.168.50.101;
 		}
 	}
+
+	group {
+		host nbd-6 {
+			# Use the encrypted image
+			option root-path "nbd:192.168.50.1:2001:ext2:errors=panic";
+
+			hardware ethernet 52:54:00:12:34:05;
+			fixed-address 192.168.50.101;
+		}
+	}
 }
diff --git a/test/TEST-40-NBD/server-init b/test/TEST-40-NBD/server-init
index aa6a17b..6c2db08 100755
--- a/test/TEST-40-NBD/server-init
+++ b/test/TEST-40-NBD/server-init
@@ -9,6 +9,7 @@ ip link set lo up
 ip addr add 192.168.50.1/24 dev eth0
 ip link set eth0 up
 nbd-server 2000 /dev/sdb -C /dev/null
+nbd-server 2001 /dev/sdc -C /dev/null
 >/var/lib/dhcpd/dhcpd.leases
 dhcpd -cf /etc/dhcpd.conf
 sh -i
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
index 39ec746..a70092d 100755
--- a/test/TEST-40-NBD/test.sh
+++ b/test/TEST-40-NBD/test.sh
@@ -10,7 +10,8 @@ run_server() {
     # Start server first
     echo "NBD TEST SETUP: Starting DHCP/NBD server"
 
-    $testdir/run-qemu -hda server.ext2 -hdb nbd.ext2 -m 512M -nographic \
+    $testdir/run-qemu -hda server.ext2 -hdb nbd.ext2 -hdc encrypted.ext2 \
+	-m 512M -nographic \
 	-net nic,macaddr=52:54:00:12:34:56,model=e1000 \
 	-net socket,mcast=230.0.0.1:1234 \
 	-serial udp:127.0.0.1:9999 \
@@ -154,6 +155,62 @@ test_run() {
 
     client_test "NBD netroot=dhcp DHCP root-path nbd:srv:port:fstype:fsopts" \
 	52:54:00:12:34:04 "netroot=dhcp" ext2 errors=panic || return 1
+
+    # Encrypted root handling via LVM/LUKS over NBD
+
+    client_test "NBD root=/dev/dracut/root netroot=nbd:IP:port" \
+	52:54:00:12:34:00 \
+	"root=/dev/dracut/root netroot=nbd:192.168.50.1:2001" || return 1
+
+    # XXX This should be ext2,errors=panic but that doesn't currently
+    # XXX work when you have a real root= line in addition to netroot=
+    # XXX How we should work here needs clarification
+    client_test "NBD root=/dev/dracut/root netroot=dhcp (w/ fstype and opts)" \
+	52:54:00:12:34:05 \
+	"root=/dev/dracut/root netroot=dhcp" || return 1
+}
+
+make_encrypted_root() {
+    # Create the blank file to use as a root filesystem
+    dd if=/dev/zero of=encrypted.ext2 bs=1M count=20
+    dd if=/dev/zero of=flag.img bs=1M count=1
+
+    kernel=$KVERSION
+    # Create what will eventually be our root filesystem onto an overlay
+    (
+	initdir=overlay/source
+	. $basedir/dracut-functions
+	dracut_install sh df free ls shutdown poweroff stty cat ps ln ip \
+	    /lib/terminfo/l/linux mount dmesg mkdir cp ping
+	inst ./client-init /sbin/init
+	find_binary plymouth >/dev/null && dracut_install plymouth
+	(cd "$initdir"; mkdir -p dev sys proc etc var/run tmp )
+    )
+
+    # second, install the files needed to make the root filesystem
+    (
+	initdir=overlay
+	. $basedir/dracut-functions
+	dracut_install mke2fs poweroff cp umount
+	inst_simple ./create-root.sh /pre-mount/01create-root.sh
+    )
+
+    # create an initramfs that will create the target root filesystem.
+    # We do it this way so that we do not risk trashing the host mdraid
+    # devices, volume groups, encrypted partitions, etc.
+    $basedir/dracut -l -i overlay / \
+	-m "dash crypt lvm mdraid udev-rules base rootfs-block" \
+	-d "ata_piix ext2 sd_mod" \
+	-f initramfs.makeroot $KVERSION || return 1
+    rm -rf overlay
+
+    # Invoke KVM and/or QEMU to actually create the target filesystem.
+    $testdir/run-qemu -hda flag.img -hdb encrypted.ext2 -m 512M \
+	-nographic -net none \
+	-kernel "/boot/vmlinuz-$kernel" \
+	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81" \
+	-initrd initramfs.makeroot  || return 1
+    grep -m 1 -q dracut-root-block-created flag.img || return 1
 }
 
 make_client_root() {
@@ -222,6 +279,7 @@ make_server_root() {
 }
 
 test_setup() {
+    make_encrypted_root || return 1
     make_client_root || return 1
     make_server_root || return 1
 
@@ -231,6 +289,7 @@ test_setup() {
 	. $basedir/dracut-functions
 	dracut_install poweroff shutdown
 	inst_simple ./hard-off.sh /emergency/01hard-off.sh
+	inst ./cryptroot-ask /sbin/cryptroot-ask
     )
 
     sudo $basedir/dracut -l -i overlay / \
@@ -250,7 +309,8 @@ test_cleanup() {
 	rm -f server.pid
     fi
     rm -fr overlay mnt
-    rm -f flag.img server.ext2 nbd.ext2 initramfs.server initramfs.testing
+    rm -f flag.img server.ext2 nbd.ext2 encrypted.ext2
+    rm -f initramfs.server initramfs.testing initramfs.makeroot
 }
 
 . $testdir/test-functions
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
