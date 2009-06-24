From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 5/5] Add multinic test suite
Date: Wed, 24 Jun 2009 20:08:32 +0200
Message-ID: <1245866912-3643-6-git-send-email-philippe.seewer@bfh.ch>
References: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245866912-3643-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

This is a start at a test suite for the multinic part of dracut
---
 test/TEST-50-MULTINIC/Makefile    |   10 ++
 test/TEST-50-MULTINIC/client-init |    9 ++
 test/TEST-50-MULTINIC/dhcpd.conf  |   36 ++++++
 test/TEST-50-MULTINIC/exports     |    1 +
 test/TEST-50-MULTINIC/hard-off.sh |    2 +
 test/TEST-50-MULTINIC/hosts       |    5 +
 test/TEST-50-MULTINIC/server-init |   30 +++++
 test/TEST-50-MULTINIC/test.log    |   48 ++++++++
 test/TEST-50-MULTINIC/test.sh     |  225 +++++++++++++++++++++++++++++++++++++
 9 files changed, 366 insertions(+), 0 deletions(-)
 create mode 100644 test/TEST-50-MULTINIC/Makefile
 create mode 100755 test/TEST-50-MULTINIC/client-init
 create mode 100644 test/TEST-50-MULTINIC/dhcpd.conf
 create mode 100644 test/TEST-50-MULTINIC/exports
 create mode 100755 test/TEST-50-MULTINIC/hard-off.sh
 create mode 100644 test/TEST-50-MULTINIC/hosts
 create mode 100755 test/TEST-50-MULTINIC/server-init
 create mode 100644 test/TEST-50-MULTINIC/test.log
 create mode 100755 test/TEST-50-MULTINIC/test.sh

diff --git a/test/TEST-50-MULTINIC/Makefile b/test/TEST-50-MULTINIC/Makefile
new file mode 100644
index 0000000..bc0ddb6
--- /dev/null
+++ b/test/TEST-50-MULTINIC/Makefile
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
diff --git a/test/TEST-50-MULTINIC/client-init b/test/TEST-50-MULTINIC/client-init
new file mode 100755
index 0000000..66290c6
--- /dev/null
+++ b/test/TEST-50-MULTINIC/client-init
@@ -0,0 +1,9 @@
+#!/bin/sh
+exec >/dev/console 2>&1
+export TERM=linux
+export PS1='initramfs-test:\w\$ '
+stty sane
+echo "made it to the rootfs! Powering down."
+echo OK $(ls /dev/.initramfs/*.ifcfg) > /dev/sda
+#sh -i
+poweroff -f
diff --git a/test/TEST-50-MULTINIC/dhcpd.conf b/test/TEST-50-MULTINIC/dhcpd.conf
new file mode 100644
index 0000000..be8dee7
--- /dev/null
+++ b/test/TEST-50-MULTINIC/dhcpd.conf
@@ -0,0 +1,36 @@
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
+		host client-if1 {
+			hardware ethernet 52:54:00:12:34:00;
+			fixed-address 192.168.50.100;
+		}
+	}
+
+	group {
+		host client-if2 {
+			hardware ethernet 52:54:00:12:34:01;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		option root-path "nfs:192.168.50.1:/nfs/client";
+
+		host client-if3 {
+			hardware ethernet 52:54:00:12:34:02;
+			fixed-address 192.168.50.102;
+		}
+	}
+}
diff --git a/test/TEST-50-MULTINIC/exports b/test/TEST-50-MULTINIC/exports
new file mode 100644
index 0000000..82b62f0
--- /dev/null
+++ b/test/TEST-50-MULTINIC/exports
@@ -0,0 +1 @@
+/nfs/client	192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash)
diff --git a/test/TEST-50-MULTINIC/hard-off.sh b/test/TEST-50-MULTINIC/hard-off.sh
new file mode 100755
index 0000000..85fd849
--- /dev/null
+++ b/test/TEST-50-MULTINIC/hard-off.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+getarg rdinitdebug || poweroff -f
diff --git a/test/TEST-50-MULTINIC/hosts b/test/TEST-50-MULTINIC/hosts
new file mode 100644
index 0000000..d02a4e9
--- /dev/null
+++ b/test/TEST-50-MULTINIC/hosts
@@ -0,0 +1,5 @@
+127.0.0.1	localhost
+192.168.50.1	server
+192.168.50.100	client-if1
+192.168.50.101	client-if2
+192.168.50.102	client-if3
diff --git a/test/TEST-50-MULTINIC/server-init b/test/TEST-50-MULTINIC/server-init
new file mode 100755
index 0000000..78eab41
--- /dev/null
+++ b/test/TEST-50-MULTINIC/server-init
@@ -0,0 +1,30 @@
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
+modprobe sunrpc
+mount -t rpc_pipefs sunrpc /var/lib/nfs/rpc_pipefs
+[ -x /sbin/portmap ] && portmap
+[ -x /sbin/rpcbind ] && rpcbind
+modprobe nfsd
+mount -t nfsd nfsd /proc/fs/nfsd
+exportfs -r
+rpc.nfsd
+rpc.mountd
+rpc.idmapd
+exportfs -r
+>/var/lib/dhcpd/dhcpd.leases
+chmod 777 /var/lib/dhcpd/dhcpd.leases
+dhcpd -cf /etc/dhcpd.conf -lf /var/lib/dhcpd/dhcpd.leases
+#sh -i
+# Wait forever for the VM to die
+echo "Serving NFS mounts"
+while sleep 60; do sleep 60; done
+mount -n -o remount,ro /
+poweroff -f
diff --git a/test/TEST-50-MULTINIC/test.log b/test/TEST-50-MULTINIC/test.log
new file mode 100644
index 0000000..f3c0c59
--- /dev/null
+++ b/test/TEST-50-MULTINIC/test.log
@@ -0,0 +1,48 @@
+60+0 records in
+60+0 records out
+62914560 bytes (63 MB) copied, 0.158729 s, 396 MB/s
+mke2fs 1.41.4 (27-Jan-2009)
+Filesystem label=
+OS type: Linux
+Block size=1024 (log=0)
+Fragment size=1024 (log=0)
+15360 inodes, 61440 blocks
+3072 blocks (5.00%) reserved for the super user
+First data block=1
+Maximum filesystem blocks=62914560
+8 block groups
+8192 blocks per group, 8192 fragments per group
+1920 inodes per group
+Superblock backups stored on blocks: 
+	8193, 24577, 40961, 57345
+
+Writing inode tables: 0/81/82/83/84/85/86/87/8done                            
+Writing superblocks and filesystem accounting information: done
+
+This filesystem will be automatically checked every 27 mounts or
+180 days, whichever comes first.  Use tune2fs -c or -i to override.
+ln: creating symbolic link `mnt/bin/sh': File exists
+ln: creating symbolic link `mnt/usr/lib64/libnfsidmap_nsswitch.so.0': No such file or directory
+ln: creating symbolic link `mnt/nfs/client/bin/sh': File exists
+
+11804 blocks
+W: Possible missing firmware /lib/firmware/kaweth/trigger_code_fix.bin for module kaweth.ko
+W: Possible missing firmware /lib/firmware/kaweth/trigger_code.bin for module kaweth.ko
+W: Possible missing firmware /lib/firmware/kaweth/new_code_fix.bin for module kaweth.ko
+W: Possible missing firmware /lib/firmware/kaweth/new_code.bin for module kaweth.ko
+W: Possible missing firmware /lib/firmware/sun/cassini.bin for module cassini.ko
+ln: creating symbolic link `/tmp/initramfs.KxYIth/usr/lib64/libnfsidmap_nsswitch.so.0': No such file or directory
+
+42645 blocks
+MULTINIC TEST SETUP: Starting DHCP/NFS server
+setsockopt(IP_ADD_MEMBERSHIP): No such device
+Could not initialize device 'socket'
+Failed to start server
+cat: server.pid: Permission denied
+Usage:
+  kill pid ...              Send SIGTERM to every process listed.
+  kill signal pid ...       Send a signal to every process listed.
+  kill -s signal pid ...    Send a signal to every process listed.
+  kill -l                   List all signal names.
+  kill -L                   List all signal names in a nice table.
+  kill -l signal            Convert between signal numbers and names.
diff --git a/test/TEST-50-MULTINIC/test.sh b/test/TEST-50-MULTINIC/test.sh
new file mode 100755
index 0000000..3d43b13
--- /dev/null
+++ b/test/TEST-50-MULTINIC/test.sh
@@ -0,0 +1,225 @@
+#!/bin/bash
+TEST_DESCRIPTION="root filesystem on NFS with multiple nics"
+
+KVERSION=${KVERSION-$(uname -r)}
+
+# Uncomment this to debug failures
+#DEBUGFAIL="rdinitdebug rdnetdebug"
+
+run_server() {
+    # Start server first
+    echo "MULTINIC TEST SETUP: Starting DHCP/NFS server"
+
+    $testdir/run-qemu -hda server.ext2 -m 512M -nographic \
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
+    local mac1="$2"
+    local mac2="$3"
+    local mac3="$4"
+    local cmdline="$5"
+    local check="$6"
+
+    echo "CLIENT TEST START: $test_name"
+
+    # Need this so kvm-qemu will boot (needs non-/dev/zero local disk)
+    if ! dd if=/dev/zero of=client.img bs=1M count=1; then
+	echo "Unable to make client sda image" 1>&2
+	return 1
+    fi
+
+    $testdir/run-qemu -hda client.img -m 512M -nographic \
+  	-net nic,macaddr=52:54:00:12:34:$mac1,model=e1000 \
+  	-net nic,macaddr=52:54:00:12:34:$mac2,model=e1000 \
+  	-net nic,macaddr=52:54:00:12:34:$mac3,model=e1000 \
+  	-net socket,mcast=230.0.0.1:1234 \
+  	-kernel /boot/vmlinuz-$KVERSION \
+  	-append "$cmdline $DEBUGFAIL ro quiet console=ttyS0,115200n81" \
+  	-initrd initramfs.testing
+
+    if [[ $? -ne 0 ]] || ! grep -m 1 -q OK client.img; then
+	echo "CLIENT TEST END: $test_name [FAILED - BAD EXIT]"
+	return 1
+    fi
+
+
+    for i in $check ; do
+	echo $i
+	if ! grep -m 1 -q net.$i.ifcfg client.img; then
+	    echo "CLIENT TEST END: $test_name [FAILED - BAD IF]"
+	    return 1
+	fi
+    done
+
+    echo "CLIENT TEST END: $test_name [OK]"
+    return 0
+}
+
+
+test_run() {
+    if ! run_server; then
+	echo "Failed to start server" 1>&2
+	return 1
+    fi
+
+    # Mac Numbering Scheme
+    # ...:00-02 receive IP adresses all others don't
+    # ...:02 receives a dhcp root-path
+
+    # PXE Style BOOTIF=
+    client_test "MULTINIC root=nfs,BOOTIF=" \
+	00 01 02 \
+	"root=nfs:192.168.50.1:/nfs/client BOOTIF=52-54-00-12-34-00" \
+	"eth0" || return 1
+
+    # PXE Style BOOTIF= with dhcp root-path
+    client_test "MULTINIC root=dhcp BOOTIF=" \
+	00 01 02 \
+	"root=dhcp BOOTIF=52-54-00-12-34-02" \
+	"eth2" || return 1
+
+    # Multinic case, where only one nic works
+    client_test "MULTINIC root=nfs ip=dhcp" \
+	FF 00 FE \
+	"root=nfs:192.168.50.1:/nfs/client ip=dhcp" \
+	"eth1" || return 1
+
+    # Require two interfaces
+    client_test "MULTINIC root=nfs ip=eth1:dhcp ip=eth2:dhcp bootdev=eth1" \
+	00 01 02 \
+	"root=nfs:192.168.50.1:/nfs/client ip=eth1:dhcp ip=eth2:dhcp bootdev=eth1" \
+	"eth1 eth2" || return 1
+
+    # Require three interfaces with dhcp root-path
+    client_test "MULTINIC root=dhcp ip=eth0:dhcp ip=eth1:dhcp ip=eth2:dhcp bootdev=eth2" \
+	00 01 02 \
+	"root=dhcp ip=eth0:dhcp ip=eth1:dhcp ip=eth2:dhcp bootdev=eth2" \
+	"eth0 eth1 eth2" || return 1
+}
+
+test_setup() {
+     # Make server root
+     dd if=/dev/zero of=server.ext2 bs=1M count=60
+     mke2fs -F server.ext2
+     mkdir mnt
+     sudo mount -o loop server.ext2 mnt
+
+     kernel=$KVERSION
+     (
+     	initdir=mnt
+ 	. $basedir/dracut-functions
+ 	dracut_install sh ls shutdown poweroff stty cat ps ln ip \
+ 	    /lib/terminfo/l/linux dmesg mkdir cp ping exportfs \
+ 	    modprobe rpc.nfsd rpc.mountd showmount tcpdump \
+ 	    /etc/services sleep mount chmod
+ 	which portmap >/dev/null 2>&1 && dracut_install portmap
+ 	which rpcbind >/dev/null 2>&1 && dracut_install rpcbind
+ 	[ -f /etc/netconfig ] && dracut_install /etc/netconfig 
+ 	which dhcpd >/dev/null 2>&1 && dracut_install dhcpd
+ 	[ -x /usr/sbin/dhcpd3 ] && inst /usr/sbin/dhcpd3 /usr/sbin/dhcpd
+ 	instmods nfsd sunrpc ipv6
+ 	inst ./server-init /sbin/init
+ 	inst ./hosts /etc/hosts
+ 	inst ./exports /etc/exports
+ 	inst ./dhcpd.conf /etc/dhcpd.conf
+ 	dracut_install /etc/nsswitch.conf /etc/rpc /etc/protocols
+ 	dracut_install rpc.idmapd /etc/idmapd.conf
+ 	if ldd $(which rpc.idmapd) |grep -q lib64; then
+ 	    LIBDIR="/lib64"
+ 	else
+ 	    LIBDIR="/lib"
+ 	fi
+
+ 	dracut_install $(ls {/usr,}$LIBDIR/libnfsidmap*.so* 2>/dev/null )
+ 	dracut_install $(ls {/usr,}$LIBDIR/libnss*.so 2>/dev/null)
+ 	(
+ 	    cd "$initdir";
+ 	    mkdir -p dev sys proc etc var/run tmp var/lib/{dhcpd,rpcbind}
+ 	    mkdir -p var/lib/nfs/{v4recovery,rpc_pipefs}
+ 	    chmod 777 var/lib/rpcbind var/lib/nfs
+ 	)
+ 	inst /etc/nsswitch.conf /etc/nsswitch.conf
+ 	inst /etc/passwd /etc/passwd
+ 	inst /etc/group /etc/group
+ 	for i in /lib*/libnss_files**;do
+ 	    inst_library $i
+ 	done
+
+ 	/sbin/depmod -a -b "$initdir" $kernel
+ 	ldconfig -n -r "$initdir" /lib* /usr/lib*
+     )
+
+    # Make client root inside server root
+    initdir=mnt/nfs/client
+    mkdir -p $initdir
+
+    (
+ 	. $basedir/dracut-functions
+ 	dracut_install sh shutdown poweroff stty cat ps ln ip \
+         	/lib/terminfo/l/linux mount dmesg mkdir \
+ 		cp ping grep ls
+ 	inst ./client-init /sbin/init
+ 	(
+ 	    cd "$initdir"
+ 	    mkdir -p dev sys proc etc
+ 	    mkdir -p var/lib/nfs/rpc_pipefs
+	)
+ 	inst /etc/nsswitch.conf /etc/nsswitch.conf
+ 	inst /etc/passwd /etc/passwd
+ 	inst /etc/group /etc/group
+ 	for i in /lib*/libnss_files*;do
+ 	    inst_library $i
+ 	done
+
+ 	ldconfig -n -r "$initdir" /lib* /usr/lib*
+     )
+
+     sudo umount mnt
+     rm -fr mnt
+
+    # Make an overlay with needed tools for the test harness
+    (
+ 	initdir=overlay
+ 	mkdir overlay
+ 	. $basedir/dracut-functions
+ 	dracut_install poweroff shutdown
+ 	inst_simple ./hard-off.sh /emergency/01hard-off.sh
+    )
+
+    # Make server's dracut image
+    $basedir/dracut -l -i overlay / \
+ 	-m "dash udev-rules base rootfs-block debug" \
+ 	-d "ata_piix ext2 sd_mod e1000" \
+ 	-f initramfs.server $KVERSION || return 1
+
+    # Make client's dracut image
+    $basedir/dracut -l -i overlay / \
+	-m "dash udev-rules base network nfs debug" \
+	-d "e1000 nfs sunrpc" \
+	-f initramfs.testing $KVERSION || return 1
+}
+
+test_cleanup() {
+    if [[ -s server.pid ]]; then
+	sudo kill -TERM $(cat server.pid)
+	rm -f server.pid
+    fi
+    rm -rf mnt overlay
+    rm -f server.ext2 client.img initramfs.server initramfs.testing
+}
+
+. $testdir/test-functions
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
