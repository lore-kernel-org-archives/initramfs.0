From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [2/3] test suite: automate NFS testing
Date: Fri, 05 Jun 2009 00:34:38 -0400
Message-ID: <1244176478.29842.4.camel@obelisk.thedillows.org>
References: <1244176354.29842.1.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244176354.29842.1.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

First cut at automating the NFS test suite.

diff --git a/test/TEST-20-NFS/Makefile b/test/TEST-20-NFS/Makefile
new file mode 100644
index 0000000..2ef573d
--- /dev/null
+++ b/test/TEST-20-NFS/Makefile
@@ -0,0 +1,10 @@
+all:
+	make -C ../.. all
+	@basedir=../.. testdir=../ ./test.sh --all
+setup:
+	make -C ../.. all
+	@basedir=../.. testdir=../ ./test.sh --setup
+clean:
+	@basedir=../.. testdir=../ ./test.sh --clean
+run:
+	@basedir=../.. testdir=../ ./test.sh --run
diff --git a/test/TEST-20-NFS/client-init b/test/TEST-20-NFS/client-init
new file mode 100755
index 0000000..c0149b9
--- /dev/null
+++ b/test/TEST-20-NFS/client-init
@@ -0,0 +1,9 @@
+#!/bin/sh
+exec >/dev/console 2>&1
+export TERM=linux
+export PS1='initramfs-test:\w\$ '
+stty sane
+echo "made it to the rootfs! Powering down."
+#sh -i
+echo nfs-OK > /dev/sda
+poweroff -f
diff --git a/test/TEST-20-NFS/make-client-root b/test/TEST-20-NFS/make-client-root
deleted file mode 100755
index 23b6145..0000000
--- a/test/TEST-20-NFS/make-client-root
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/bash
-
-# small script to create a minimal testroot in /mnt/root
-
-#dd if=/dev/zero of=test/client.ext2 bs=1M count=20
-#mke2fs -F test/client.ext2
-#mkdir test/mnt
-#mount -o loop test/client.ext2 test/mnt
-
-initdir=/mnt/root
-kernel=$(uname -r)
-(
-    . ./dracut-functions
-    dracut_install sh df free ls shutdown poweroff stty cat ps ln ip route \
-	/lib/terminfo/l/linux mount dmesg ifconfig dhclient mkdir cp ping dhclient 
-    inst "modules.d/40network/dhclient-script" "/sbin/dhclient-script"
-    inst "modules.d/40network/ifup" "/sbin/ifup"
-    dracut_install grep agetty strace tcpdump
-    find_binary plymouth >/dev/null && dracut_install plymouth
-    inst test/test-init /sbin/init
-    (cd "$initdir";
-	mkdir -p dev sys proc etc var/run tmp var/lib/dnsmasq 
-        mkdir -p var/lib/nfs/rpc_pipefs
-    )
-    inst /etc/nsswitch.conf /etc/nsswitch.conf
-    inst /etc/passwd /etc/passwd
-    inst /etc/group /etc/group
-    for i in /lib*/libnss_files*;do
-	inst_library $i
-    done
-)
-#targetfs="$initdir"
-#unset initdir
-
-#umount test/mnt
-#rm -fr test/mnt
diff --git a/test/TEST-20-NFS/make-server-root b/test/TEST-20-NFS/make-server-root
deleted file mode 100755
index 22ab83a..0000000
--- a/test/TEST-20-NFS/make-server-root
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/bash
-
-dd if=/dev/zero of=test/server.ext2 bs=1M count=20
-mke2fs -F test/server.ext2
-mkdir test/mnt
-mount -o loop test/server.ext2 test/mnt
-
-initdir=test/mnt
-kernel=$(uname -r)
-(
-    . ./dracut-functions
-    dracut_install sh df free ls shutdown poweroff stty cat ps ln ip route \
-	/lib/terminfo/l/linux mount dmesg ifconfig dhclient mkdir cp ping dhclient 
-    inst "modules.d/40network/dhclient-script" "/sbin/dhclient-script"
-    inst "modules.d/40network/ifup" "/sbin/ifup"
-    dracut_install grep dnsmasq agetty strace tcpdump
-    inst test/server-init /sbin/init
-    (cd "$initdir";
-	mkdir -p dev sys proc etc var/run tmp var/lib/dnsmasq
-
-    cat > etc/hosts <<EOF 
-127.0.0.1                localhost
-192.168.1.1          server
-192.168.1.100        workstation1
-192.168.1.101        workstation2
-192.168.1.102        workstation3
-192.168.1.103        workstation4
-EOF
-    cat > etc/dnsmasq.conf <<EOF
-expand-hosts
-domain=test.net
-dhcp-range=192.168.1.100,192.168.1.150,168h
-dhcp-option=17,"192.168.1.1:/mnt/root"
-EOF
-    )
-    inst /etc/nsswitch.conf /etc/nsswitch.conf
-    inst /etc/passwd /etc/passwd
-    inst /etc/group /etc/group
-    for i in /lib*/libnss_files*;do
-	inst_library $i
-    done
-)
-targetfs="$initdir"
-unset initdir
-
-umount test/mnt
-rm -fr test/mnt
diff --git a/test/TEST-20-NFS/server-init b/test/TEST-20-NFS/server-init
index 69ee196..d3527f0 100755
--- a/test/TEST-20-NFS/server-init
+++ b/test/TEST-20-NFS/server-init
@@ -1,17 +1,22 @@
 #!/bin/sh 
 export TERM=linux
-export PS1='initramfs-test:\w\$ '
-[ -f /etc/fstab ] || ln -s /proc/mounts /etc/fstab
+export PS1='nfstest-server:\w\$ '
 stty sane
 echo "made it to the rootfs!"
-echo 3 >/proc/sys/vm/drop_caches
-free
-if [ -x /usr/sbin/dnsmasq ]; then
-    ifconfig eth0 192.168.1.1
-    route add -net 192.168.1.0/24 dev eth0
-    /usr/sbin/dnsmasq 
-fi
-/bin/sh -i
+. /etc/basenet
+echo server > /proc/sys/kernel/hostname
+ip addr add 127.0.0.1/8 dev lo
+ip link set lo up
+ip addr add $BASENET.1/24 dev eth0
+ip link set eth0 up
+rpcbind
+modprobe nfsd
+exportfs -r
+rpc.nfsd
+rpc.mountd
+/usr/sbin/dnsmasq
+#sh -i
+# Wait forever for the VM to die
+while sleep 60; do sleep 60; done
 mount -n -o remount,ro /
 poweroff -f
-
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
new file mode 100755
index 0000000..df6ec8f
--- /dev/null
+++ b/test/TEST-20-NFS/test.sh
@@ -0,0 +1,157 @@
+#!/bin/bash
+TEST_DESCRIPTION="root filesystem on NFS"
+
+KVERSION=${KVERSION-$(uname -r)}
+BASENET=${BASENET-192.168.100}
+
+test_run() {
+    # Start server first
+    $testdir/run-qemu -hda server.ext2 -m 512M -nographic \
+	-net nic,macaddr=52:54:00:12:34:56,model=e1000 \
+	-net socket,mcast=230.0.0.1:1234 \
+	-serial udp:127.0.0.1:9999 \
+	-kernel /boot/vmlinuz-$KVERSION \
+	-append "root=/dev/sda rw quiet console=ttyS0,115200n81" \
+	-initrd initramfs.server -pidfile server.pid -daemonize
+    sudo chmod 644 server.pid
+
+    # Starting the server messes up the terminal, fix that
+    stty sane
+
+    echo Sleeping 10 seconds to give the server a head start
+    sleep 10
+
+    $testdir/run-qemu -hda client.img -m 512M -nographic \
+	-net nic,macaddr=52:54:00:12:35:56,model=e1000 \
+	-net socket,mcast=230.0.0.1:1234 \
+	-kernel /boot/vmlinuz-$KVERSION \
+	-append "root=dhcp rw quiet console=ttyS0,115200n81" \
+	-initrd initramfs.testing
+
+    if [[ -s server.pid ]]; then
+	sudo kill -TERM $(cat server.pid)
+	rm -f server.pid
+    fi
+    grep -m 1 -q nfs-OK client.img || return 1
+}
+
+test_setup() {
+    # Make server root
+    dd if=/dev/zero of=server.ext2 bs=1M count=20
+    mke2fs -F server.ext2
+    mkdir mnt
+    sudo mount -o loop server.ext2 mnt
+
+    kernel=$KVERSION
+    (
+    	initdir=mnt
+	. $basedir/dracut-functions
+	dracut_install sh ls shutdown poweroff stty cat ps ln ip \
+	    /lib/terminfo/l/linux dmesg mkdir cp ping exportfs \
+	    rpcbind modprobe rpc.nfsd rpc.mountd dnsmasq showmount tcpdump \
+	    /etc/netconfig /etc/services sleep
+	instmods nfsd sunrpc
+	inst ./server-init /sbin/init
+	(
+	    cd "$initdir";
+	    mkdir -p dev sys proc etc var/run tmp var/lib/{dnsmasq,rpcbind,nfs}
+	    mkdir -p var/lib/nfs/v4recovery
+	    chmod 777 var/lib/rpcbind var/lib/nfs
+
+	    cat > etc/hosts <<EOF 
+127.0.0.1                localhost
+$BASENET.1          server
+$BASENET.100        workstation1
+$BASENET.101        workstation2
+$BASENET.102        workstation3
+$BASENET.103        workstation4
+EOF
+	    cat > etc/dnsmasq.conf <<EOF
+expand-hosts
+domain=test.net
+dhcp-range=$BASENET.100,$BASENET.150,168h
+dhcp-option=17,"$BASENET.1:/client"
+EOF
+	    cat > etc/basenet <<EOF
+BASENET=$BASENET
+EOF
+
+            cat > etc/exports <<EOF
+/	$BASENET.0/24(ro,fsid=0,insecure,no_subtree_check,no_root_squash)
+/client	$BASENET.0/24(ro,insecure,no_subtree_check,no_root_squash)
+EOF
+	)
+	inst /etc/nsswitch.conf /etc/nsswitch.conf
+	inst /etc/passwd /etc/passwd
+	inst /etc/group /etc/group
+	for i in /lib*/libnss_files*;do
+	    inst_library $i
+	done
+
+	/sbin/depmod -a -b "$initdir" $kernel
+	ldconfig -n -r "$initdir" /lib* /usr/lib*
+    )
+
+    # Make client root inside server root
+    initdir=mnt/client
+    mkdir $initdir
+
+    (
+	. $basedir/dracut-functions
+	dracut_install sh shutdown poweroff stty cat ps ln ip \
+        	/lib/terminfo/l/linux mount dmesg mkdir \
+		cp ping grep
+	inst ./client-init /sbin/init
+	(
+	    cd "$initdir"
+	    mkdir -p dev sys proc etc
+	    mkdir -p var/lib/nfs/rpc_pipefs
+	)
+	inst /etc/nsswitch.conf /etc/nsswitch.conf
+	inst /etc/passwd /etc/passwd
+	inst /etc/group /etc/group
+	for i in /lib*/libnss_files*;do
+	    inst_library $i
+	done
+
+	ldconfig -n -r "$initdir" /lib* /usr/lib*
+    )
+
+    sudo umount mnt
+    rm -fr mnt
+
+    # Make an overlay with needed tools for the test harness
+    (
+	initdir=overlay
+	mkdir overlay
+	. $basedir/dracut-functions
+	dracut_install poweroff shutdown
+	inst_simple ./hard-off.sh /emergency/01hard-off.sh
+    )
+
+    # Make server's dracut image
+    $basedir/dracut -l -i overlay / \
+	-m "dash udev-rules base rootfs-block" \
+	-d "ata_piix ext2 sd_mod e1000" \
+	-f initramfs.server $KVERSION || return 1
+
+    # Make client's dracut image
+    $basedir/dracut -l -i overlay / \
+	-m "dash udev-rules base network nfs" \
+	-d "e1000 nfs sunrpc" \
+	-f initramfs.testing $KVERSION || return 1
+
+    # Need this so kvm-qemu will boot (needs non-/dev/zero local disk)
+    dd if=/dev/zero of=client.img bs=1M count=1
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
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
