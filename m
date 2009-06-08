From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 01/11] NFS test: verify that we used the right IP to get to the server
Date: Mon,  8 Jun 2009 00:40:14 -0400
Message-ID: <574f2965e4610858db4d725af669bad45bb8c0ab.1244435634.git.dave@thedillows.org>
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

---
 test/TEST-20-NFS/client-init |    6 ++++-
 test/TEST-20-NFS/dhcpd.conf  |    8 +++---
 test/TEST-20-NFS/hosts       |    2 +
 test/TEST-20-NFS/server-init |    2 +
 test/TEST-20-NFS/test.sh     |   46 ++++++++++++++++++++++++++---------------
 5 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/test/TEST-20-NFS/client-init b/test/TEST-20-NFS/client-init
index c0149b9..00fa3c9 100755
--- a/test/TEST-20-NFS/client-init
+++ b/test/TEST-20-NFS/client-init
@@ -4,6 +4,10 @@ export TERM=linux
 export PS1='initramfs-test:\w\$ '
 stty sane
 echo "made it to the rootfs! Powering down."
+while read dev fs fstype opts rest; do
+    [ "$fstype" != "nfs" -a "$fstype" != "nfs4" ] && continue
+    echo "nfs-OK $dev $fstype $opts" > /dev/sda
+    break
+done < /proc/mounts
 #sh -i
-echo nfs-OK > /dev/sda
 poweroff -f
diff --git a/test/TEST-20-NFS/dhcpd.conf b/test/TEST-20-NFS/dhcpd.conf
index 14fee3e..a756195 100644
--- a/test/TEST-20-NFS/dhcpd.conf
+++ b/test/TEST-20-NFS/dhcpd.conf
@@ -23,7 +23,7 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 
 	group {
 		# NFSv3 root=dhcp or root={/dev/,}nfs, use given IP
-		option root-path "192.168.50.1:/nfs/client";
+		option root-path "192.168.50.2:/nfs/client";
 
 		host nfs3-2 {
 			hardware ethernet 52:54:00:12:34:01;
@@ -33,7 +33,7 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 
 	group {
 		# NFSv3 root=dhcp, use protocol from root-path
-		option root-path "nfs:192.168.50.1:/nfs/client";
+		option root-path "nfs:192.168.50.3:/nfs/client";
 
 		host nfs3-3 {
 			hardware ethernet 52:54:00:12:34:02;
@@ -53,7 +53,7 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 
 	group {
 		# NFSv4 root={/dev/,}nfs4, use given IP
-		option root-path "192.168.50.1:/client";
+		option root-path "192.168.50.2:/client";
 
 		host nfs4-2 {
 			hardware ethernet 52:54:00:12:34:04;
@@ -63,7 +63,7 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 
 	group {
 		# NFSv4 root=dhcp, use profocol from root-path
-		option root-path "nfs4:192.168.50.1:/client";
+		option root-path "nfs4:192.168.50.3:/client";
 
 		host nfs4-3 {
 			hardware ethernet 52:54:00:12:34:05;
diff --git a/test/TEST-20-NFS/hosts b/test/TEST-20-NFS/hosts
index 5aca4ed..f8c18b6 100644
--- a/test/TEST-20-NFS/hosts
+++ b/test/TEST-20-NFS/hosts
@@ -1,5 +1,7 @@
 127.0.0.1	localhost
 192.168.50.1	server
+192.168.50.2	server-ip
+192.168.50.3	server-proto-ip
 192.168.50.100	workstation1
 192.168.50.101	workstation2
 192.168.50.102	workstation3
diff --git a/test/TEST-20-NFS/server-init b/test/TEST-20-NFS/server-init
index f6d3891..67af8fa 100755
--- a/test/TEST-20-NFS/server-init
+++ b/test/TEST-20-NFS/server-init
@@ -7,6 +7,8 @@ echo server > /proc/sys/kernel/hostname
 ip addr add 127.0.0.1/8 dev lo
 ip link set lo up
 ip addr add 192.168.50.1/24 dev eth0
+ip addr add 192.168.50.2/24 dev eth0
+ip addr add 192.168.50.3/24 dev eth0
 ip link set eth0 up
 modprobe sunrpc
 mount -t rpc_pipefs sunrpc /var/lib/nfs/rpc_pipefs
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 7fcc47b..77ec22a 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -30,6 +30,8 @@ client_test() {
     local test_name="$1"
     local mac=$2
     local cmdline="$3"
+    local server="$4"
+    local nfsinfo
 
     echo "CLIENT TEST START: $test_name"
 
@@ -46,13 +48,23 @@ client_test() {
 	-append "$cmdline $DEBUGFAIL ro quiet console=ttyS0,115200n81" \
 	-initrd initramfs.testing
 
-    if [[ $? -eq 0 ]] && grep -m 1 -q nfs-OK client.img; then
-	echo "CLIENT TEST END: $test_name [OK]"
-	return 0
-    else
-	echo "CLIENT TEST END: $test_name [FAILED]"
+    if [[ $? -ne 0 ]] || ! grep -m 1 -q nfs-OK client.img; then
+	echo "CLIENT TEST END: $test_name [FAILED - BAD EXIT]"
 	return 1
     fi
+
+    # nfsinfo=( server:/path nfs{,4} options )
+    nfsinfo=($(awk '{print $2, $3, $4; exit}' client.img)) 
+
+    if [[ "${nfsinfo[0]%%:*}" != "$server" ]]; then
+	echo "CLIENT TEST INFO: $test_name got: ${nfsinfo[0]%%:*}"
+	echo "CLIENT TEST INFO: $test_name expected: $server"
+	echo "CLIENT TEST END: $test_name [FAILED - WRONG SERVER]"
+	return 1
+    fi
+
+    echo "CLIENT TEST END: $test_name [OK]"
+    return 0
 }
 
 test_run() {
@@ -62,44 +74,44 @@ test_run() {
     fi
 
     client_test "NFSv3 root=dhcp DHCP path only" 52:54:00:12:34:00 \
-	"root=dhcp" || return 1
+	"root=dhcp" 192.168.50.1 || return 1
 
     client_test "NFSv3 root=nfs DHCP path only" 52:54:00:12:34:00 \
-	"root=nfs" || return 1
+	"root=nfs" 192.168.50.1 || return 1
 
     client_test "NFSv3 root=/dev/nfs DHCP path only" 52:54:00:12:34:00 \
-	"root=/dev/nfs" || return 1
+	"root=/dev/nfs" 192.168.50.1 || return 1
 
     client_test "NFSv3 root=dhcp DHCP IP:path" 52:54:00:12:34:01 \
-	"root=dhcp" || return 1
+	"root=dhcp" 192.168.50.2 || return 1
 
     client_test "NFSv3 root=nfs DHCP IP:path" 52:54:00:12:34:01 \
-	"root=nfs" || return 1
+	"root=nfs" 192.168.50.2 || return 1
 
     client_test "NFSv3 root=/dev/nfs DHCP IP:path" 52:54:00:12:34:01 \
-	"root=/dev/nfs" || return 1
+	"root=/dev/nfs" 192.168.50.2 || return 1
 
     client_test "NFSv3 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:02 \
-	"root=dhcp" || return 1
+	"root=dhcp" 192.168.50.3 || return 1
 
     # There is a mandatory 90 second recovery when starting the NFSv4
     # server, so put these later in the list to avoid a pause when doing
     # switch_root
 
     client_test "NFSv4 root=nfs4 DHCP path only" 52:54:00:12:34:03 \
-	"root=nfs4" || return 1
+	"root=nfs4" 192.168.50.1 || return 1
 
     client_test "NFSv4 root=/dev/nfs4 DHCP path only" 52:54:00:12:34:03 \
-	"root=/dev/nfs4" || return 1
+	"root=/dev/nfs4" 192.168.50.1 || return 1
 
     client_test "NFSv4 root=nfs4 DHCP IP:path" 52:54:00:12:34:04 \
-	"root=nfs4" || return 1
+	"root=nfs4" 192.168.50.2 || return 1
 
     client_test "NFSv4 root=/dev/nfs4 DHCP IP:path" 52:54:00:12:34:04 \
-	"root=/dev/nfs4" || return 1
+	"root=/dev/nfs4" 192.168.50.2 || return 1
 
     client_test "NFSv4 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:05 \
-	"root=dhcp" || return 1
+	"root=dhcp" 192.168.50.3 || return 1
 }
 
 test_setup() {
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
