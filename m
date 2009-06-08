From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 07/11] NFS root: add support for default root path and %s substitution
Date: Mon,  8 Jun 2009 00:40:20 -0400
Message-ID: <abe9ccc89a96bc61bc2e9d3169341821393da6da.1244435634.git.dave@thedillows.org>
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

This implements a default path of /tftpboot/%s if no path is provided,
and adds host name substitution for %s, with a fall back to the IP address,
as provided by the kernel's nfsroot handling.

The test suite is updated to test this functionality.
---
 modules.d/95nfs/nfs-netroot.sh |    1 +
 modules.d/95nfs/nfsroot        |   14 ++++++++++++++
 test/TEST-20-NFS/exports       |    3 +++
 test/TEST-20-NFS/server-init   |    3 +++
 test/TEST-20-NFS/test.sh       |   18 ++++++++++++++++++
 5 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/modules.d/95nfs/nfs-netroot.sh b/modules.d/95nfs/nfs-netroot.sh
index 8d552e9..365d394 100755
--- a/modules.d/95nfs/nfs-netroot.sh
+++ b/modules.d/95nfs/nfs-netroot.sh
@@ -34,6 +34,7 @@ if [ "$root" = "dhcp" -o "$root" = "nfs" -o "$root" = "nfs4" ]; then
 	if check_occurances "$new_root_path" ':' 0; then
 	    root="$nfsver::$new_root_path:"
 	fi ;;
+    '') root="$nfsver:::" ;;
     esac
 fi
 
diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index da002c5..cd3bc7c 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -21,6 +21,20 @@ nfsserver=${root%%:*}; root=${root#*:}
 nfspath=${root%%:*}
 flags=${root#*:}
 
+[ -z "$nfspath" ] && nfspath=/tftpboot/%s
+
+# Kernel replaces first %s with host name, and falls back to the ip address
+# if it isn't set. Only the first %s is substituted.
+#
+if [ "${nfspath#*%s}" != "$nfspath" ]; then
+    ip=$(ip -o -f inet addr show $netif)
+    ip=${ip%%/*}
+    ip=${ip##* }
+    read node < /proc/sys/kernel/hostname
+    [ "$node" = "(none)" ] && node=$ip
+    nfspath=${nfspath%%%s*}$node${nfspath#*%s}
+fi
+
 # look through the flags and see if any are overridden by the command line
 # Append a , so we know we terminate
 flags=${flags},
diff --git a/test/TEST-20-NFS/exports b/test/TEST-20-NFS/exports
index 2701877..95619e7 100644
--- a/test/TEST-20-NFS/exports
+++ b/test/TEST-20-NFS/exports
@@ -1,2 +1,5 @@
 /nfs		192.168.50.0/24(ro,fsid=0,insecure,no_subtree_check,no_root_squash)
 /nfs/client	192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash)
+/nfs/nfs3-5	192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash,nohide)
+/nfs/ip/192.168.50.101	192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash,nohide)
+/nfs/tftpboot/nfs4-5	192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash,nohide)
diff --git a/test/TEST-20-NFS/server-init b/test/TEST-20-NFS/server-init
index 67af8fa..ed7e43e 100755
--- a/test/TEST-20-NFS/server-init
+++ b/test/TEST-20-NFS/server-init
@@ -10,6 +10,9 @@ ip addr add 192.168.50.1/24 dev eth0
 ip addr add 192.168.50.2/24 dev eth0
 ip addr add 192.168.50.3/24 dev eth0
 ip link set eth0 up
+mount --bind /nfs/client /nfs/nfs3-5
+mount --bind /nfs/client /nfs/ip/192.168.50.101
+mount --bind /nfs/client /nfs/tftpboot/nfs4-5
 modprobe sunrpc
 mount -t rpc_pipefs sunrpc /var/lib/nfs/rpc_pipefs
 rpcbind
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 4a997c4..6583366 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -137,6 +137,15 @@ test_nfsv3() {
     client_test "NFSv3 root=nfs nfsroot=/nfs/client" 52:54:00:12:34:04 \
 	"root=nfs nfsroot=/nfs/client" 192.168.50.1 -wsize=4096 || return 1
 
+    client_test "NFSv3 root=nfs nfsroot=/nfs/%s" 52:54:00:12:34:04 \
+	"root=nfs nfsroot=/nfs/%s" 192.168.50.1 -wsize=4096 || return 1
+
+    client_test "NFSv3 root=nfs nfsroot=/nfs/ip/%s no host name (use IP)" \
+	52:54:00:12:34:7f \
+	"root=nfs nfsroot=/nfs/ip/%s \
+		ip=192.168.50.101:192.168.50.1::255.255.255.0::eth0:static" \
+	192.168.50.1 -wsize=4096 || return 1
+
     client_test "NFSv3 root=nfs nfsroot=/nfs/client,wsize=4096" \
 	52:54:00:12:34:04 "root=nfs nfsroot=/nfs/client,wsize=4096" \
 	192.168.50.1 wsize=4096 || return 1
@@ -185,6 +194,11 @@ test_nfsv4() {
 	52:54:00:12:34:84 "root=nfs4 nfsroot=/client,wsize=4096" \
 	192.168.50.1 wsize=4096 || return 1
 
+    # This one only works with NFSv4 in the test suite -- NFSv3 needs
+    # a /nfs prefix due to our server configuration
+    client_test "NFSv4 root=nfs4" 52:54:00:12:34:84 \
+	"root=nfs4" 192.168.50.1 -wsize=4096 || return 1
+
     client_test "NFSv4 root=nfs4 DHCP path,options" \
 	52:54:00:12:34:85 "root=nfs4" 192.168.50.1 wsize=4096 || return 1
 
@@ -267,6 +281,10 @@ test_setup() {
 	ldconfig -n -r "$initdir" /lib* /usr/lib*
     )
 
+    mkdir -p mnt/nfs/nfs3-5
+    mkdir -p mnt/nfs/ip/192.168.50.101
+    mkdir -p mnt/nfs/tftpboot/nfs4-5
+
     sudo umount mnt
     rm -fr mnt
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
