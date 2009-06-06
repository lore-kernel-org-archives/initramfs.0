From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 9/9] NFS test: additional option tests
Date: Sat,  6 Jun 2009 05:23:30 -0400
Message-ID: <ae227ca83607abcd7fd0159719857f2010ecad17.1244279679.git.dave@thedillows.org>
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

Test additional combinations of command line and DHCP option formats. This
is by no means the complete list, but gets us started with some common ones.
---
 test/TEST-20-NFS/dhcpd.conf  |   50 ++++++++++++++++++++++++++++++++++++++
 test/TEST-20-NFS/server-init |    3 ++
 test/TEST-20-NFS/test.sh     |   55 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/test/TEST-20-NFS/dhcpd.conf b/test/TEST-20-NFS/dhcpd.conf
index 79b6a7b..14fee3e 100644
--- a/test/TEST-20-NFS/dhcpd.conf
+++ b/test/TEST-20-NFS/dhcpd.conf
@@ -20,4 +20,54 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 			fixed-address 192.168.50.101;
 		}
 	}
+
+	group {
+		# NFSv3 root=dhcp or root={/dev/,}nfs, use given IP
+		option root-path "192.168.50.1:/nfs/client";
+
+		host nfs3-2 {
+			hardware ethernet 52:54:00:12:34:01;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv3 root=dhcp, use protocol from root-path
+		option root-path "nfs:192.168.50.1:/nfs/client";
+
+		host nfs3-3 {
+			hardware ethernet 52:54:00:12:34:02;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv4 root={/dev/,}nfs4, use server-id
+		option root-path "/client";
+
+		host nfs4-1 {
+			hardware ethernet 52:54:00:12:34:03;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv4 root={/dev/,}nfs4, use given IP
+		option root-path "192.168.50.1:/client";
+
+		host nfs4-2 {
+			hardware ethernet 52:54:00:12:34:04;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv4 root=dhcp, use profocol from root-path
+		option root-path "nfs4:192.168.50.1:/client";
+
+		host nfs4-3 {
+			hardware ethernet 52:54:00:12:34:05;
+			fixed-address 192.168.50.101;
+		}
+	}
 }
diff --git a/test/TEST-20-NFS/server-init b/test/TEST-20-NFS/server-init
index 397efa2..f6d3891 100755
--- a/test/TEST-20-NFS/server-init
+++ b/test/TEST-20-NFS/server-init
@@ -8,8 +8,11 @@ ip addr add 127.0.0.1/8 dev lo
 ip link set lo up
 ip addr add 192.168.50.1/24 dev eth0
 ip link set eth0 up
+modprobe sunrpc
+mount -t rpc_pipefs sunrpc /var/lib/nfs/rpc_pipefs
 rpcbind
 modprobe nfsd
+mount -t nfsd nfsd /proc/fs/nfsd
 exportfs -r
 rpc.nfsd
 rpc.mountd
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 5ec2341..7fcc47b 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -3,6 +3,9 @@ TEST_DESCRIPTION="root filesystem on NFS"
 
 KVERSION=${KVERSION-$(uname -r)}
 
+# Uncomment this to debug failures
+#DEBUGFAIL="rdinitdebug rdnetdebug"
+
 run_server() {
     # Start server first
     echo "NFS TEST SETUP: Starting DHCP/NFS server"
@@ -40,7 +43,7 @@ client_test() {
 	-net nic,macaddr=$mac,model=e1000 \
 	-net socket,mcast=230.0.0.1:1234 \
 	-kernel /boot/vmlinuz-$KVERSION \
-	-append "$cmdline rw quiet console=ttyS0,115200n81" \
+	-append "$cmdline $DEBUGFAIL ro quiet console=ttyS0,115200n81" \
 	-initrd initramfs.testing
 
     if [[ $? -eq 0 ]] && grep -m 1 -q nfs-OK client.img; then
@@ -58,12 +61,50 @@ test_run() {
 	return 1
     fi
 
-    client_test "NFSv3 root=dhcp" 52:54:00:12:34:00 "root=dhcp" || return 1
+    client_test "NFSv3 root=dhcp DHCP path only" 52:54:00:12:34:00 \
+	"root=dhcp" || return 1
+
+    client_test "NFSv3 root=nfs DHCP path only" 52:54:00:12:34:00 \
+	"root=nfs" || return 1
+
+    client_test "NFSv3 root=/dev/nfs DHCP path only" 52:54:00:12:34:00 \
+	"root=/dev/nfs" || return 1
+
+    client_test "NFSv3 root=dhcp DHCP IP:path" 52:54:00:12:34:01 \
+	"root=dhcp" || return 1
+
+    client_test "NFSv3 root=nfs DHCP IP:path" 52:54:00:12:34:01 \
+	"root=nfs" || return 1
+
+    client_test "NFSv3 root=/dev/nfs DHCP IP:path" 52:54:00:12:34:01 \
+	"root=/dev/nfs" || return 1
+
+    client_test "NFSv3 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:02 \
+	"root=dhcp" || return 1
+
+    # There is a mandatory 90 second recovery when starting the NFSv4
+    # server, so put these later in the list to avoid a pause when doing
+    # switch_root
+
+    client_test "NFSv4 root=nfs4 DHCP path only" 52:54:00:12:34:03 \
+	"root=nfs4" || return 1
+
+    client_test "NFSv4 root=/dev/nfs4 DHCP path only" 52:54:00:12:34:03 \
+	"root=/dev/nfs4" || return 1
+
+    client_test "NFSv4 root=nfs4 DHCP IP:path" 52:54:00:12:34:04 \
+	"root=nfs4" || return 1
+
+    client_test "NFSv4 root=/dev/nfs4 DHCP IP:path" 52:54:00:12:34:04 \
+	"root=/dev/nfs4" || return 1
+
+    client_test "NFSv4 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:05 \
+	"root=dhcp" || return 1
 }
 
 test_setup() {
     # Make server root
-    dd if=/dev/zero of=server.ext2 bs=1M count=20
+    dd if=/dev/zero of=server.ext2 bs=1M count=30
     mke2fs -F server.ext2
     mkdir mnt
     sudo mount -o loop server.ext2 mnt
@@ -75,7 +116,7 @@ test_setup() {
 	dracut_install sh ls shutdown poweroff stty cat ps ln ip \
 	    /lib/terminfo/l/linux dmesg mkdir cp ping exportfs \
 	    rpcbind modprobe rpc.nfsd rpc.mountd dhcpd showmount tcpdump \
-	    /etc/netconfig /etc/services sleep
+	    /etc/netconfig /etc/services sleep mount
 	instmods nfsd sunrpc
 	inst ./server-init /sbin/init
 	inst ./hosts /etc/hosts
@@ -83,14 +124,14 @@ test_setup() {
 	inst ./dhcpd.conf /etc/dhcpd.conf
 	(
 	    cd "$initdir";
-	    mkdir -p dev sys proc etc var/run tmp var/lib/{dhcpd,rpcbind,nfs}
-	    mkdir -p var/lib/nfs/v4recovery
+	    mkdir -p dev sys proc etc var/run tmp var/lib/{dhcpd,rpcbind}
+	    mkdir -p var/lib/nfs/{v4recovery,rpc_pipefs}
 	    chmod 777 var/lib/rpcbind var/lib/nfs
 	)
 	inst /etc/nsswitch.conf /etc/nsswitch.conf
 	inst /etc/passwd /etc/passwd
 	inst /etc/group /etc/group
-	for i in /lib*/libnss_files*;do
+	for i in /lib*/libnss_files**;do
 	    inst_library $i
 	done
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
