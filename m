From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 3/9] NFS test: rearrange code to test multiple client configurations
Date: Sat,  6 Jun 2009 05:23:24 -0400
Message-ID: <cc75acdcab094a44bebf163bb6c197dfa939e309.1244279679.git.dave@thedillows.org>
References: <cover.1244279679.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1244279679.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

This also gets rid of BASENET, which was an unneeded idea in hindsight.
---
 test/TEST-20-NFS/server-init |    3 +-
 test/TEST-20-NFS/test.sh     |   78 +++++++++++++++++++++++++----------------
 2 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/test/TEST-20-NFS/server-init b/test/TEST-20-NFS/server-init
index d3527f0..f9c822f 100755
--- a/test/TEST-20-NFS/server-init
+++ b/test/TEST-20-NFS/server-init
@@ -3,11 +3,10 @@ export TERM=linux
 export PS1='nfstest-server:\w\$ '
 stty sane
 echo "made it to the rootfs!"
-. /etc/basenet
 echo server > /proc/sys/kernel/hostname
 ip addr add 127.0.0.1/8 dev lo
 ip link set lo up
-ip addr add $BASENET.1/24 dev eth0
+ip addr add 192.168.50.1/24 dev eth0
 ip link set eth0 up
 rpcbind
 modprobe nfsd
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index df6ec8f..e641edf 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -2,37 +2,60 @@
 TEST_DESCRIPTION="root filesystem on NFS"
 
 KVERSION=${KVERSION-$(uname -r)}
-BASENET=${BASENET-192.168.100}
 
-test_run() {
+run_server() {
     # Start server first
+    echo "NFS TEST SETUP: Starting DHCP/NFS server"
+
     $testdir/run-qemu -hda server.ext2 -m 512M -nographic \
 	-net nic,macaddr=52:54:00:12:34:56,model=e1000 \
 	-net socket,mcast=230.0.0.1:1234 \
 	-serial udp:127.0.0.1:9999 \
 	-kernel /boot/vmlinuz-$KVERSION \
 	-append "root=/dev/sda rw quiet console=ttyS0,115200n81" \
-	-initrd initramfs.server -pidfile server.pid -daemonize
-    sudo chmod 644 server.pid
-
-    # Starting the server messes up the terminal, fix that
-    stty sane
+	-initrd initramfs.server -pidfile server.pid -daemonize || return 1
+    sudo chmod 644 server.pid || return 1
 
     echo Sleeping 10 seconds to give the server a head start
     sleep 10
+}
+
+client_test() {
+    local test_name="$1"
+    local mac=$2
+    local cmdline="$3"
+
+    echo "CLIENT TEST START: $test_name"
+
+    # Need this so kvm-qemu will boot (needs non-/dev/zero local disk)
+    if ! dd if=/dev/zero of=client.img bs=1M count=1; then
+	echo "Unable to make client sda image" 1>&2
+	return 1
+    fi
 
     $testdir/run-qemu -hda client.img -m 512M -nographic \
-	-net nic,macaddr=52:54:00:12:35:56,model=e1000 \
+	-net nic,macaddr=$mac,model=e1000 \
 	-net socket,mcast=230.0.0.1:1234 \
 	-kernel /boot/vmlinuz-$KVERSION \
-	-append "root=dhcp rw quiet console=ttyS0,115200n81" \
+	-append "$cmdline rw quiet console=ttyS0,115200n81" \
 	-initrd initramfs.testing
 
-    if [[ -s server.pid ]]; then
-	sudo kill -TERM $(cat server.pid)
-	rm -f server.pid
+    if [[ $? -eq 0 ]] && grep -m 1 -q nfs-OK client.img; then
+	echo "CLIENT TEST END: $test_name [OK]"
+	return 0
+    else
+	echo "CLIENT TEST END: $test_name [FAILED]"
+	return 1
+    fi
+}
+
+test_run() {
+    if ! run_server; then
+	echo "Failed to start server" 1>&2
+	return 1
     fi
-    grep -m 1 -q nfs-OK client.img || return 1
+
+    client_test "NFSv3 root=dhcp" 52:54:00:12:34:00 "root=dhcp" || return 1
 }
 
 test_setup() {
@@ -60,25 +83,21 @@ test_setup() {
 
 	    cat > etc/hosts <<EOF 
 127.0.0.1                localhost
-$BASENET.1          server
-$BASENET.100        workstation1
-$BASENET.101        workstation2
-$BASENET.102        workstation3
-$BASENET.103        workstation4
+192.168.50.1          server
+192.168.50.100        workstation1
+192.168.50.101        workstation2
+192.168.50.102        workstation3
+192.168.50.103        workstation4
 EOF
 	    cat > etc/dnsmasq.conf <<EOF
 expand-hosts
 domain=test.net
-dhcp-range=$BASENET.100,$BASENET.150,168h
-dhcp-option=17,"$BASENET.1:/client"
-EOF
-	    cat > etc/basenet <<EOF
-BASENET=$BASENET
+dhcp-range=192.168.50.100,192.168.50.150,168h
+dhcp-option=17,"192.168.50.1:/client"
 EOF
-
             cat > etc/exports <<EOF
-/	$BASENET.0/24(ro,fsid=0,insecure,no_subtree_check,no_root_squash)
-/client	$BASENET.0/24(ro,insecure,no_subtree_check,no_root_squash)
+/	192.168.50.0/24(ro,fsid=0,insecure,no_subtree_check,no_root_squash)
+/client	192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash)
 EOF
 	)
 	inst /etc/nsswitch.conf /etc/nsswitch.conf
@@ -131,18 +150,15 @@ EOF
 
     # Make server's dracut image
     $basedir/dracut -l -i overlay / \
-	-m "dash udev-rules base rootfs-block" \
+	-m "dash udev-rules base rootfs-block debug" \
 	-d "ata_piix ext2 sd_mod e1000" \
 	-f initramfs.server $KVERSION || return 1
 
     # Make client's dracut image
     $basedir/dracut -l -i overlay / \
-	-m "dash udev-rules base network nfs" \
+	-m "dash udev-rules base network nfs debug" \
 	-d "e1000 nfs sunrpc" \
 	-f initramfs.testing $KVERSION || return 1
-
-    # Need this so kvm-qemu will boot (needs non-/dev/zero local disk)
-    dd if=/dev/zero of=client.img bs=1M count=1
 }
 
 test_cleanup() {
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
