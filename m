From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 4/9] NFS test: switch the ISC dhcpd server
Date: Sat,  6 Jun 2009 05:23:25 -0400
Message-ID: <ba64a17ffd3d06be9686c3603d8f2301e2bb9aaa.1244279679.git.dave@thedillows.org>
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

This will let us expand the number of client configs we can test
---
 test/TEST-20-NFS/dhcpd.conf  |   23 +++++++++++++++++++++++
 test/TEST-20-NFS/exports     |    3 +++
 test/TEST-20-NFS/hosts       |    6 ++++++
 test/TEST-20-NFS/server-init |    3 ++-
 test/TEST-20-NFS/test.sh     |   26 +++++---------------------
 5 files changed, 39 insertions(+), 22 deletions(-)
 create mode 100644 test/TEST-20-NFS/dhcpd.conf
 create mode 100644 test/TEST-20-NFS/exports
 create mode 100644 test/TEST-20-NFS/hosts

diff --git a/test/TEST-20-NFS/dhcpd.conf b/test/TEST-20-NFS/dhcpd.conf
new file mode 100644
index 0000000..7ee1cac
--- /dev/null
+++ b/test/TEST-20-NFS/dhcpd.conf
@@ -0,0 +1,23 @@
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
+		# NFSv3 root=dhcp or root={/dev/,}nfs, use server-id
+		option root-path "/client";
+
+		host nfs3-1 {
+			hardware ethernet 52:54:00:12:34:00;
+			fixed-address 192.168.50.101;
+		}
+	}
+}
diff --git a/test/TEST-20-NFS/exports b/test/TEST-20-NFS/exports
new file mode 100644
index 0000000..0ec4f0c
--- /dev/null
+++ b/test/TEST-20-NFS/exports
@@ -0,0 +1,3 @@
+/       192.168.50.0/24(ro,fsid=0,insecure,no_subtree_check,no_root_squash)
+/client 192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash)
+
diff --git a/test/TEST-20-NFS/hosts b/test/TEST-20-NFS/hosts
new file mode 100644
index 0000000..5aca4ed
--- /dev/null
+++ b/test/TEST-20-NFS/hosts
@@ -0,0 +1,6 @@
+127.0.0.1	localhost
+192.168.50.1	server
+192.168.50.100	workstation1
+192.168.50.101	workstation2
+192.168.50.102	workstation3
+192.168.50.103	workstation4
diff --git a/test/TEST-20-NFS/server-init b/test/TEST-20-NFS/server-init
index f9c822f..397efa2 100755
--- a/test/TEST-20-NFS/server-init
+++ b/test/TEST-20-NFS/server-init
@@ -13,7 +13,8 @@ modprobe nfsd
 exportfs -r
 rpc.nfsd
 rpc.mountd
-/usr/sbin/dnsmasq
+>/var/lib/dhcpd/dhcpd.leases
+dhcpd
 #sh -i
 # Wait forever for the VM to die
 while sleep 60; do sleep 60; done
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index e641edf..e120f64 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -71,34 +71,18 @@ test_setup() {
 	. $basedir/dracut-functions
 	dracut_install sh ls shutdown poweroff stty cat ps ln ip \
 	    /lib/terminfo/l/linux dmesg mkdir cp ping exportfs \
-	    rpcbind modprobe rpc.nfsd rpc.mountd dnsmasq showmount tcpdump \
+	    rpcbind modprobe rpc.nfsd rpc.mountd dhcpd showmount tcpdump \
 	    /etc/netconfig /etc/services sleep
 	instmods nfsd sunrpc
 	inst ./server-init /sbin/init
+	inst ./hosts /etc/hosts
+	inst ./exports /etc/exports
+	inst ./dhcpd.conf /etc/dhcpd.conf
 	(
 	    cd "$initdir";
-	    mkdir -p dev sys proc etc var/run tmp var/lib/{dnsmasq,rpcbind,nfs}
+	    mkdir -p dev sys proc etc var/run tmp var/lib/{dhcpd,rpcbind,nfs}
 	    mkdir -p var/lib/nfs/v4recovery
 	    chmod 777 var/lib/rpcbind var/lib/nfs
-
-	    cat > etc/hosts <<EOF 
-127.0.0.1                localhost
-192.168.50.1          server
-192.168.50.100        workstation1
-192.168.50.101        workstation2
-192.168.50.102        workstation3
-192.168.50.103        workstation4
-EOF
-	    cat > etc/dnsmasq.conf <<EOF
-expand-hosts
-domain=test.net
-dhcp-range=192.168.50.100,192.168.50.150,168h
-dhcp-option=17,"192.168.50.1:/client"
-EOF
-            cat > etc/exports <<EOF
-/	192.168.50.0/24(ro,fsid=0,insecure,no_subtree_check,no_root_squash)
-/client	192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash)
-EOF
 	)
 	inst /etc/nsswitch.conf /etc/nsswitch.conf
 	inst /etc/passwd /etc/passwd
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
