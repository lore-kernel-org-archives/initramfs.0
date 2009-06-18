From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/7] add iSCSI testsuite
Date: Thu, 18 Jun 2009 15:26:19 +0200
Message-ID: <1245331581-2453-6-git-send-email-harald@redhat.com>
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

---
 test/TEST-30-ISCSI/Makefile       |   10 +++
 test/TEST-30-ISCSI/Makefile.tbd   |   10 ---
 test/TEST-30-ISCSI/client-init    |   13 +++
 test/TEST-30-ISCSI/create-root.sh |   38 +++++-----
 test/TEST-30-ISCSI/dhcpd.conf     |   25 ++++++
 test/TEST-30-ISCSI/server-init    |   17 ++++
 test/TEST-30-ISCSI/targets        |   21 +++++
 test/TEST-30-ISCSI/test.sh        |  162 +++++++++++++++++++++++++++++++------
 8 files changed, 242 insertions(+), 54 deletions(-)
 create mode 100644 test/TEST-30-ISCSI/Makefile
 delete mode 100644 test/TEST-30-ISCSI/Makefile.tbd
 create mode 100755 test/TEST-30-ISCSI/client-init
 create mode 100644 test/TEST-30-ISCSI/dhcpd.conf
 create mode 100755 test/TEST-30-ISCSI/server-init
 create mode 100644 test/TEST-30-ISCSI/targets

diff --git a/test/TEST-30-ISCSI/Makefile b/test/TEST-30-ISCSI/Makefile
new file mode 100644
index 0000000..bc0ddb6
--- /dev/null
+++ b/test/TEST-30-ISCSI/Makefile
@@ -0,0 +1,10 @@
+all:
+	@make -s --no-print-directory -C ../.. all
+	@basedir=../.. testdir=../ ./test.sh --all
+setup:
+	@make --no-print-directory -C ../.. all
+	@basedir=../.. testdir=../ ./test.sh --setup
+clean:
+	@basedir=../.. testdir=../ ./test.sh --clean
+run:
+	@basedir=../.. testdir=../ ./test.sh --run
diff --git a/test/TEST-30-ISCSI/Makefile.tbd b/test/TEST-30-ISCSI/Makefile.tbd
deleted file mode 100644
index 2ef573d..0000000
--- a/test/TEST-30-ISCSI/Makefile.tbd
+++ /dev/null
@@ -1,10 +0,0 @@
-all:
-	make -C ../.. all
-	@basedir=../.. testdir=../ ./test.sh --all
-setup:
-	make -C ../.. all
-	@basedir=../.. testdir=../ ./test.sh --setup
-clean:
-	@basedir=../.. testdir=../ ./test.sh --clean
-run:
-	@basedir=../.. testdir=../ ./test.sh --run
diff --git a/test/TEST-30-ISCSI/client-init b/test/TEST-30-ISCSI/client-init
new file mode 100755
index 0000000..b1cfa09
--- /dev/null
+++ b/test/TEST-30-ISCSI/client-init
@@ -0,0 +1,13 @@
+#!/bin/sh
+exec >/dev/console 2>&1
+export TERM=linux
+export PS1='initramfs-test:\w\$ '
+stty sane
+echo "made it to the rootfs! Powering down."
+while read dev fs fstype opts rest; do
+    [ "$fstype" != "ext2" ] && continue
+    echo "iscsi-OK $dev $fstype $opts" > /dev/sda
+    break
+done < /proc/mounts
+#sh -i
+poweroff -f
diff --git a/test/TEST-30-ISCSI/create-root.sh b/test/TEST-30-ISCSI/create-root.sh
index 2dc9a59..32c1828 100755
--- a/test/TEST-30-ISCSI/create-root.sh
+++ b/test/TEST-30-ISCSI/create-root.sh
@@ -6,29 +6,29 @@ done
 udevadm control --reload-rules
 # save a partition at the beginning for future flagging purposes
 sfdisk -C 640 -H 2 -S 32 -L /dev/sda <<EOF
-,1
-,213
-,213
-,213
+,,
 EOF
-mdadm --create /dev/md0 --run --auto=yes --level=5 --raid-devices=3 /dev/sda2 /dev/sda3 /dev/sda4
+#mdadm --create /dev/md0 --run --auto=yes --level=5 --raid-devices=3 /dev/sda2 /dev/sda3 /dev/sda4
 # wait for the array to finish initailizing, otherwise this sometimes fails
 # randomly.
-mdadm -W /dev/md0
-echo -n test >keyfile
-cryptsetup -q luksFormat /dev/md0 /keyfile
-echo "The passphrase is test"
-cryptsetup luksOpen /dev/md0 dracut_crypt_test </keyfile && \
-lvm pvcreate -ff  -y /dev/mapper/dracut_crypt_test && \
-lvm vgcreate dracut /dev/mapper/dracut_crypt_test && \
-lvm lvcreate -l 100%FREE -n root dracut && \
-lvm vgchange -ay && \
-mke2fs /dev/dracut/root && \
+#mdadm -W /dev/md0
+#echo -n test >keyfile
+#cryptsetup -q luksFormat /dev/sda1 /keyfile
+#echo "The passphrase is test"
+#cryptsetup luksOpen /dev/sda1 dracut_crypt_test </keyfile && \
+#lvm pvcreate -ff  -y /dev/mapper/dracut_crypt_test && \
+#lvm vgcreate dracut /dev/mapper/dracut_crypt_test && \
+#lvm pvcreate -ff  -y /dev/sda1 && \
+#lvm vgcreate dracut /dev/sda1 && \
+#lvm lvcreate -l 100%FREE -n root dracut && \
+#lvm vgchange -ay && \
+mke2fs -L ROOT /dev/sda1 && \
 mkdir -p /sysroot && \
-mount /dev/dracut/root /sysroot && \
+mount /dev/sda1 /sysroot && \
 cp -a -t /sysroot /source/* && \
 umount /sysroot && \
-lvm lvchange -a n /dev/dracut/root && \
-cryptsetup luksClose /dev/mapper/dracut_crypt_test && \
-echo "dracut-root-block-created" >/dev/sda1
+echo "dracut-root-block-created" >/dev/sdb
 poweroff -f
+
+#lvm lvchange -a n /dev/dracut/root && \
+#cryptsetup luksClose /dev/mapper/dracut_crypt_test && \
diff --git a/test/TEST-30-ISCSI/dhcpd.conf b/test/TEST-30-ISCSI/dhcpd.conf
new file mode 100644
index 0000000..515922a
--- /dev/null
+++ b/test/TEST-30-ISCSI/dhcpd.conf
@@ -0,0 +1,25 @@
+ddns-update-style none;
+
+use-host-decl-names true;
+
+subnet 192.168.50.0 netmask 255.255.255.0 {
+	option subnet-mask      255.255.255.0;
+	option routers          192.168.50.1;
+	next-server             192.168.50.1;
+	server-identifier       192.168.50.1;
+	option domain-name-servers 192.168.50.1;
+	option domain-search "example.com";
+	option domain-name "other.com";
+
+	# MAC numbering scheme:
+	# NFSv3: last octect starts at 0x00 and works up
+
+	group {
+		option root-path "iscsiroot=192.168.50.1::::test";
+
+		host iscsi-1 {
+			hardware ethernet 52:54:00:12:34:00;
+			fixed-address 192.168.50.101;
+		}
+	}
+}
diff --git a/test/TEST-30-ISCSI/server-init b/test/TEST-30-ISCSI/server-init
new file mode 100755
index 0000000..69b38ec
--- /dev/null
+++ b/test/TEST-30-ISCSI/server-init
@@ -0,0 +1,17 @@
+#!/bin/sh 
+export TERM=linux
+export PS1='nfstest-server:\w\$ '
+stty sane
+echo "made it to the rootfs!"
+echo server > /proc/sys/kernel/hostname
+ip addr add 127.0.0.1/8 dev lo
+ip link set lo up
+ip addr add 192.168.50.1/24 dev eth0
+ip link set eth0 up
+>/var/lib/dhcpd/dhcpd.leases
+chmod 777 /var/lib/dhcpd/dhcpd.leases
+dhcpd -cf /etc/dhcpd.conf -lf /var/lib/dhcpd/dhcpd.leases
+# Wait forever for the VM to die
+/usr/sbin/iscsi-target -D -t iqn.2009-06.dracut
+mount -n -o remount,ro /
+poweroff -f
diff --git a/test/TEST-30-ISCSI/targets b/test/TEST-30-ISCSI/targets
new file mode 100644
index 0000000..e3c7114
--- /dev/null
+++ b/test/TEST-30-ISCSI/targets
@@ -0,0 +1,21 @@
+# $NetBSD: targets,v 1.2 2006/03/04 21:53:16 agc Exp $
+#
+# Structure of this file:
+#
+# + an extent is a straight (offset, length) pair of a file or device
+#   it's the lowest common storage denominator
+#   at least one is needed
+# + a device is made up of one or more extents or other devices
+#   devices can be added in a hierachical manner, to enhance resilience
+# + in this example, no device definitions are necessary, as the target
+#   will just use a simple extent for persistent storage
+# + a target is made up of 1 or more devices
+# The code does not support RAID1 recovery at present
+
+# Simple file showing 1 extent, mapped straight into 1 target
+
+# extents	file			start	length
+extent0		/dev/sdb	0	20971520
+
+# target	flags	storage		netmask
+target0		rw	extent0		192.168.50.0/24
diff --git a/test/TEST-30-ISCSI/test.sh b/test/TEST-30-ISCSI/test.sh
index e4fe2fd..3fd6bd3 100755
--- a/test/TEST-30-ISCSI/test.sh
+++ b/test/TEST-30-ISCSI/test.sh
@@ -1,29 +1,79 @@
 #!/bin/bash
-TEST_DESCRIPTION="root filesystem on an encrypted LVM PV over ISCSI"
+TEST_DESCRIPTION="root filesystem over iSCSI"
+
+KVERSION=${KVERSION-$(uname -r)}
+
+#DEBUGFAIL="rdinitdebug rdnetdebug udevinfo"
+
+run_server() {
+    # Start server first
+    echo "iSCSI TEST SETUP: Starting DHCP/iSCSI server"
+
+    $testdir/run-qemu -hda server.ext2 -hdb root.ext2 -m 128M -nographic \
+	-net nic,macaddr=52:54:00:12:34:56,model=e1000 \
+	-net socket,mcast=230.0.0.1:1234 \
+	-serial udp:127.0.0.1:9999 \
+	-kernel /boot/vmlinuz-$KVERSION \
+	-append "root=/dev/sda rw quiet console=ttyS0,115200n81" \
+	-initrd initramfs.server -pidfile server.pid -daemonize || return 1
+    sudo chmod 644 server.pid || return 1
+
+    # Cleanup the terminal if we have one
+    tty -s && stty sane
+
+    echo Sleeping 10 seconds to give the server a head start
+    sleep 10
+}
+
+run_client() {
+
+    # Need this so kvm-qemu will boot (needs non-/dev/zero local disk)
+    if ! dd if=/dev/zero of=client.img bs=1M count=1; then
+	echo "Unable to make client sda image" 1>&2
+	return 1
+    fi
+
+    $testdir/run-qemu -hda client.img -m 128M -nographic \
+  	-net nic,macaddr=52:54:00:12:34:00,model=e1000 \
+  	-net socket,mcast=230.0.0.1:1234 \
+  	-kernel /boot/vmlinuz-$KVERSION \
+	-append "root=LABEL=ROOT netroot=iscsi:192.168.50.1::::iqn.2009-06.dracut:target0 rw quiet console=ttyS0,115200n81 $DEBUGFAIL" \
+  	-initrd initramfs.testing
+    grep -m 1 -q iscsi-OK client.img || return 1
+}
 
 test_run() {
-    $testdir/run-qemu -m 512M -nographic  -net nic,vlan=0,macaddr=52:54:00:12:34:FE -net tap,vlan=0,ifname=vnet2 \
-	-kernel /boot/vmlinuz-$(uname -r) \
-	-append "root=/dev/dracut/root rw quiet console=ttyS0,115200n81 iscsiroot=192.168.2.2::::iqn.2004-04.com.qnap:TS-439:iSCSI.test.8CCAFA ip=dhcp" \
-	-initrd initramfs.testing
-    #grep -m 1 -q dracut-root-block-success root.ext2 || return 1
+    if ! run_server; then
+	echo "Failed to start server" 1>&2
+	return 1
+    fi
+    run_client
+    if [[ -s server.pid ]]; then
+	sudo kill -TERM $(cat server.pid)
+	rm -f server.pid
+    fi
 }
 
 test_setup() {
+    if [ ! -x /usr/sbin/iscsi-target ]; then
+	echo "Need iscsi-target from netbsd-iscsi"
+	return 1
+    fi
+
+    # Create the blank file to use as a root filesystem
+    dd if=/dev/zero of=root.ext2 bs=1M count=20
 
-    kernel=$(uname -r)
+    kernel=$KVERSION
     # Create what will eventually be our root filesystem onto an overlay
     (
 	initdir=overlay/source
 	. $basedir/dracut-functions
-	dracut_install sh df free ls shutdown poweroff stty cat ps ln ip route \
-	    /lib/terminfo/l/linux mount dmesg ifconfig dhclient mkdir cp ping dhclient 
-	inst "$basedir/modules.d/40network/dhclient-script" "/sbin/dhclient-script"
-	inst "$basedir/modules.d/40network/ifup" "/sbin/ifup"
-	dracut_install grep
-	inst $testdir/test-init /sbin/init
-	find_binary plymouth >/dev/null && dracut_install plymouth
+	dracut_install sh shutdown poweroff stty cat ps ln ip \
+        	/lib/terminfo/l/linux mount dmesg mkdir \
+		cp ping grep
+	inst ./client-init /sbin/init
 	(cd "$initdir"; mkdir -p dev sys proc etc var/run tmp )
+	ldconfig -n -r "$initdir" /lib* /usr/lib*
     )
  
     # second, install the files needed to make the root filesystem
@@ -37,32 +87,94 @@ test_setup() {
     # create an initramfs that will create the target root filesystem.
     # We do it this way so that we do not risk trashing the host mdraid
     # devices, volume groups, encrypted partitions, etc.
-    $basedir/dracut -l --verbose -i overlay / \
-	-m "dash crypt lvm mdraid udev-rules base rootfs-block iscsi network" \
+    $basedir/dracut -l -i overlay / \
+	-m "dash crypt lvm mdraid udev-rules base rootfs-block" \
 	-d "ata_piix ext2 sd_mod" \
-	-f initramfs.makeroot || return 1
+	-f initramfs.makeroot $KVERSION || return 1
     rm -rf overlay
+
+
+    # Need this so kvm-qemu will boot (needs non-/dev/zero local disk)
+    if ! dd if=/dev/zero of=client.img bs=1M count=1; then
+	echo "Unable to make client sdb image" 1>&2
+	return 1
+    fi
     # Invoke KVM and/or QEMU to actually create the target filesystem.
-    $testdir/run-qemu  -m 512M -nographic -net nic,vlan=0,macaddr=52:54:00:12:34:FE -net tap,vlan=0,ifname=vnet2  \
+    $testdir/run-qemu -hda root.ext2 -hdb client.img -m 128M -nographic -net none \
 	-kernel "/boot/vmlinuz-$kernel" \
-	-append "root=/dev/dracut/root iscsiroot=192.168.2.2::::iqn.2004-04.com.qnap:TS-439:iSCSI.test.8CCAFA ip=dhcp rw rootfstype=ext2 console=ttyS0,115200n81 quiet" \
+	-append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81" \
 	-initrd initramfs.makeroot  || return 1
-
+    grep -m 1 -q dracut-root-block-created client.img || return 1
+    rm client.img
     (
 	initdir=overlay
 	. $basedir/dracut-functions
 	dracut_install poweroff shutdown
-	inst ./cryptroot-ask /sbin/cryptroot-ask
+#	inst_simple ./hard-off.sh /emergency/01hard-off.sh
+#	inst ./cryptroot-ask /sbin/cryptroot-ask
     )
+#	-m "debug dash crypt lvm mdraid udev-rules base rootfs-block iscsi" \
     sudo $basedir/dracut -l -i overlay / \
-	-m "dash crypt lvm mdraid udev-rules base rootfs-block iscsi" \
+	-m "debug dash udev-rules base rootfs-block iscsi" \
 	-d "ata_piix ext2 sd_mod" \
-	-f initramfs.testing || return 1
+	-f initramfs.testing $KVERSION || return 1
+
+    # Make server root
+    dd if=/dev/zero of=server.ext2 bs=1M count=60
+    mke2fs -F server.ext2
+    mkdir mnt
+    sudo mount -o loop server.ext2 mnt
+
+    kernel=$KVERSION
+    (
+    	initdir=mnt
+	. $basedir/dracut-functions
+	(
+	    cd "$initdir";
+	    mkdir -p dev sys proc etc var/run tmp var/lib/dhcpd /etc/iscsi
+	)
+	inst /etc/passwd /etc/passwd
+	dracut_install sh ls shutdown poweroff stty cat ps ln ip \
+	    /lib/terminfo/l/linux dmesg mkdir cp ping \
+	    modprobe tcpdump \
+	    /etc/services sleep mount chmod
+	dracut_install /usr/sbin/iscsi-target
+	instmods iscsi_tcp crc32c ipv6
+        inst ./targets /etc/iscsi/targets
+#	inst ./root.ext2 /
+	[ -f /etc/netconfig ] && dracut_install /etc/netconfig 
+	which dhcpd >/dev/null 2>&1 && dracut_install dhcpd
+	[ -x /usr/sbin/dhcpd3 ] && inst /usr/sbin/dhcpd3 /usr/sbin/dhcpd
+	inst ./server-init /sbin/init
+	inst ./hosts /etc/hosts
+	inst ./dhcpd.conf /etc/dhcpd.conf
+	dracut_install /etc/nsswitch.conf /etc/rpc /etc/protocols
+	inst /etc/group /etc/group
+
+	/sbin/depmod -a -b "$initdir" $kernel
+	ldconfig -n -r "$initdir" /lib* /usr/lib*
+    )
+
+    sudo umount mnt
+    rm -fr mnt
+
+
+    # Make server's dracut image
+    $basedir/dracut -l -i overlay / \
+	-m "dash udev-rules base rootfs-block debug" \
+	-d "ata_piix ext2 sd_mod e1000" \
+	-f initramfs.server $KVERSION || return 1
+
 }
 
 test_cleanup() {
-    rm -fr overlay mnt
-    rm -f root.ext2 initramfs.makeroot initramfs.testing
+    if [[ -s server.pid ]]; then
+	sudo kill -TERM $(cat server.pid)
+	rm -f server.pid
+    fi
+    rm -rf mnt overlay
+    rm -f client.ext2 server.ext2 client.img initramfs.server initramfs.testing
+    rm -f initramfs.makeroot root.ext2
 }
 
 . $testdir/test-functions
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
