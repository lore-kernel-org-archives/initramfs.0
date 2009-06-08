From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 11/11] NBD: add test suite
Date: Mon,  8 Jun 2009 00:40:24 -0400
Message-ID: <9ecbe2e4d42ff84f68efda8438ac7ec8ec72a263.1244435634.git.dave@thedillows.org>
References: <cover.1244435634.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1244435634.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

This is an initial test suite for the NBD root. It does the basics, and
needs to be extended to check more parts of the configuration.
---
 test/TEST-40-NBD/Makefile    |   10 +++
 test/TEST-40-NBD/client-init |   10 +++
 test/TEST-40-NBD/dhcpd.conf  |   29 +++++++
 test/TEST-40-NBD/hard-off.sh |    2 +
 test/TEST-40-NBD/hosts       |    8 ++
 test/TEST-40-NBD/server-init |   18 ++++
 test/TEST-40-NBD/test.sh     |  179 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 256 insertions(+), 0 deletions(-)
 create mode 100644 test/TEST-40-NBD/Makefile
 create mode 100755 test/TEST-40-NBD/client-init
 create mode 100644 test/TEST-40-NBD/dhcpd.conf
 create mode 100755 test/TEST-40-NBD/hard-off.sh
 create mode 100644 test/TEST-40-NBD/hosts
 create mode 100755 test/TEST-40-NBD/server-init
 create mode 100755 test/TEST-40-NBD/test.sh

diff --git a/test/TEST-40-NBD/Makefile b/test/TEST-40-NBD/Makefile
new file mode 100644
index 0000000..bc0ddb6
--- /dev/null
+++ b/test/TEST-40-NBD/Makefile
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
diff --git a/test/TEST-40-NBD/client-init b/test/TEST-40-NBD/client-init
new file mode 100755
index 0000000..dde5c16
--- /dev/null
+++ b/test/TEST-40-NBD/client-init
@@ -0,0 +1,10 @@
+#!/bin/sh
+exec >/dev/console 2>&1
+echo "nbd-OK" >/dev/sda
+export TERM=linux
+export PS1='nbdclient-test:\w\$ '
+stty sane
+echo "made it to the rootfs! Powering down."
+#sh -i
+mount -n -o remount,ro / &> /dev/null
+poweroff -f
diff --git a/test/TEST-40-NBD/dhcpd.conf b/test/TEST-40-NBD/dhcpd.conf
new file mode 100644
index 0000000..e7d5a08
--- /dev/null
+++ b/test/TEST-40-NBD/dhcpd.conf
@@ -0,0 +1,29 @@
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
+	group {
+		host nbd-1 {
+			hardware ethernet 52:54:00:12:34:00;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		host nbd-2 {
+			option root-path "nbd:192.168.50.1:2000";
+
+			hardware ethernet 52:54:00:12:34:01;
+			fixed-address 192.168.50.101;
+		}
+	}
+}
diff --git a/test/TEST-40-NBD/hard-off.sh b/test/TEST-40-NBD/hard-off.sh
new file mode 100755
index 0000000..85fd849
--- /dev/null
+++ b/test/TEST-40-NBD/hard-off.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+getarg rdinitdebug || poweroff -f
diff --git a/test/TEST-40-NBD/hosts b/test/TEST-40-NBD/hosts
new file mode 100644
index 0000000..f8c18b6
--- /dev/null
+++ b/test/TEST-40-NBD/hosts
@@ -0,0 +1,8 @@
+127.0.0.1	localhost
+192.168.50.1	server
+192.168.50.2	server-ip
+192.168.50.3	server-proto-ip
+192.168.50.100	workstation1
+192.168.50.101	workstation2
+192.168.50.102	workstation3
+192.168.50.103	workstation4
diff --git a/test/TEST-40-NBD/server-init b/test/TEST-40-NBD/server-init
new file mode 100755
index 0000000..1bdc4cc
--- /dev/null
+++ b/test/TEST-40-NBD/server-init
@@ -0,0 +1,18 @@
+#!/bin/sh 
+export TERM=linux
+export PS1='nbdtest-server:\w\$ '
+stty sane
+echo "made it to the rootfs!"
+echo server > /proc/sys/kernel/hostname
+ip addr add 127.0.0.1/8 dev lo
+ip link set lo up
+ip addr add 192.168.50.1/24 dev eth0
+ip link set eth0 up
+nbd-server 2000 /dev/sdb -C /dev/null
+>/var/lib/dhcpd/dhcpd.leases
+dhcpd
+sh -i
+# Wait forever for the VM to die
+while sleep 60; do sleep 60; done
+mount -n -o remount,ro /
+poweroff -f
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
new file mode 100755
index 0000000..aabe916
--- /dev/null
+++ b/test/TEST-40-NBD/test.sh
@@ -0,0 +1,179 @@
+#!/bin/bash
+TEST_DESCRIPTION="root filesystem on NBD"
+
+KVERSION=${KVERSION-$(uname -r)}
+
+# Uncomment this to debug failures
+#DEBUGFAIL="rdinitdebug rdnetdebug rdbreak"
+
+run_server() {
+    # Start server first
+    echo "NBD TEST SETUP: Starting DHCP/NFS server"
+
+    $testdir/run-qemu -hda server.ext2 -hdb nbd.ext2 -m 512M -nographic \
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
+client_test() {
+    local test_name="$1"
+    local mac=$2
+    local cmdline="$3"
+
+    echo "CLIENT TEST START: $test_name"
+
+    # Clear out the flags for each test
+    if ! dd if=/dev/zero of=flag.img bs=1M count=1; then
+	echo "Unable to make client sda image" 1>&2
+	return 1
+    fi
+
+    $testdir/run-qemu -hda flag.img -m 512M -nographic \
+	-net nic,macaddr=$mac,model=e1000 \
+	-net socket,mcast=230.0.0.1:1234 \
+	-kernel /boot/vmlinuz-$KVERSION \
+	-append "$cmdline $DEBUGFAIL ro quiet console=ttyS0,115200n81" \
+	-initrd initramfs.testing
+
+    if [[ $? -ne 0 ]] || ! grep -m 1 -q nbd-OK flag.img; then
+	echo "CLIENT TEST END: $test_name [FAILED - BAD EXIT]"
+	return 1
+    fi
+
+    echo "CLIENT TEST END: $test_name [OK]"
+}
+
+test_run() {
+    if ! run_server; then
+	echo "Failed to start server" 1>&2
+	return 1
+    fi
+
+    client_test "NBD root=nbd:..." 52:54:00:12:34:00 \
+	"root=nbd:192.168.50.1:2000" || return 1
+
+    client_test "NBD root=nbd nbdroot=srv:port" 52:54:00:12:34:00 \
+	"root=nbd nbdroot=192.168.50.1:2000" || return 1
+
+    client_test "NBD root=dhcp nbdroot=srv:port" 52:54:00:12:34:00 \
+	"root=dhcp nbdroot=192.168.50.1:2000" || return 1
+
+    client_test "NBD root=nbd nbdroot=srv,port" 52:54:00:12:34:00 \
+	"root=nbd nbdroot=192.168.50.1,2000" || return 1
+
+    client_test "NBD root=dhcp nbdroot=srv,port" 52:54:00:12:34:00 \
+	"root=dhcp nbdroot=192.168.50.1,2000" || return 1
+
+    client_test "NBD root=dhcp DHCP root-path nbd:srv:port" 52:54:00:12:34:01 \
+	"root=dhcp" || return 1
+}
+
+make_client_root() {
+    dd if=/dev/zero of=nbd.ext2 bs=1M count=30
+    mke2fs -F nbd.ext2
+    mkdir mnt
+    sudo mount -o loop nbd.ext2 mnt
+
+    kernel=$KVERSION
+    (
+	initdir=mnt
+	. $basedir/dracut-functions
+	dracut_install sh ls shutdown poweroff stty cat ps ln ip \
+	    /lib/terminfo/l/linux dmesg mkdir cp ping 
+	inst ./client-init /sbin/init
+	(
+	    cd "$initdir";
+	    mkdir -p dev sys proc etc var/run tmp
+	)
+	inst /etc/nsswitch.conf /etc/nsswitch.conf
+	inst /etc/passwd /etc/passwd
+	inst /etc/group /etc/group
+	for i in /lib*/libnss_files**;do
+	    inst_library $i
+	done
+
+	ldconfig -n -r "$initdir" /lib* /usr/lib*
+    )
+
+    sudo umount mnt
+    rm -fr mnt
+}
+
+make_server_root() {
+    dd if=/dev/zero of=server.ext2 bs=1M count=30
+    mke2fs -F server.ext2
+    mkdir mnt
+    sudo mount -o loop server.ext2 mnt
+
+    kernel=$KVERSION
+    (
+	initdir=mnt
+	. $basedir/dracut-functions
+	dracut_install sh ls shutdown poweroff stty cat ps ln ip \
+	    /lib/terminfo/l/linux dmesg mkdir cp ping grep dhcpd \
+	    sleep nbd-server
+	inst ./server-init /sbin/init
+	inst ./hosts /etc/hosts
+	inst ./dhcpd.conf /etc/dhcpd.conf
+	(
+	    cd "$initdir";
+	    mkdir -p dev sys proc etc var/run var/lib/dhcpd tmp
+	)
+	inst /etc/nsswitch.conf /etc/nsswitch.conf
+	inst /etc/passwd /etc/passwd
+	inst /etc/group /etc/group
+	for i in /lib*/libnss_files**;do
+	    inst_library $i
+	done
+
+	ldconfig -n -r "$initdir" /lib* /usr/lib*
+    )
+
+    sudo umount mnt
+    rm -fr mnt
+}
+
+test_setup() {
+    make_client_root || return 1
+    make_server_root || return 1
+
+    # Make the test image
+    (
+	initdir=overlay
+	. $basedir/dracut-functions
+	dracut_install poweroff shutdown
+	inst_simple ./hard-off.sh /emergency/01hard-off.sh
+    )
+
+    sudo $basedir/dracut -l -i overlay / \
+	-m "dash crypt lvm mdraid udev-rules rootfs-block base debug" \
+	-d "ata_piix ext2 sd_mod e1000" \
+	-f initramfs.server $KVERSION || return 1
+
+    sudo $basedir/dracut -l -i overlay / \
+	-m "dash crypt lvm mdraid udev-rules base rootfs-block nbd debug" \
+	-d "ata_piix ext2 sd_mod e1000" \
+	-f initramfs.testing $KVERSION || return 1
+}
+
+test_cleanup() {
+    if [[ -s server.pid ]]; then
+	sudo kill -TERM $(cat server.pid)
+	rm -f server.pid
+    fi
+    rm -fr overlay mnt
+    rm -f flag.img server.ext2 nbd.ext2 initramfs.server initramfs.testing
+}
+
+. $testdir/test-functions
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
