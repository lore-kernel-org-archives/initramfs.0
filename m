From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 02/11] NFS test: add support for checking mount options used
Date: Mon,  8 Jun 2009 00:40:15 -0400
Message-ID: <9f25b834b9df83c2751b41516278ba1920f02847.1244435634.git.dave@thedillows.org>
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
 test/TEST-20-NFS/dhcpd.conf |   20 +++++++++++++
 test/TEST-20-NFS/test.sh    |   65 +++++++++++++++++++++++++++++++++----------
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/test/TEST-20-NFS/dhcpd.conf b/test/TEST-20-NFS/dhcpd.conf
index a756195..7d76180 100644
--- a/test/TEST-20-NFS/dhcpd.conf
+++ b/test/TEST-20-NFS/dhcpd.conf
@@ -42,6 +42,16 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 	}
 
 	group {
+		# NFSv3 root=dhcp, use protocol, options from root-path
+		option root-path "nfs:192.168.50.3:/nfs/client:wsize=4096";
+
+		host nfs3-4 {
+			hardware ethernet 52:54:00:12:34:06;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
 		# NFSv4 root={/dev/,}nfs4, use server-id
 		option root-path "/client";
 
@@ -70,4 +80,14 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 			fixed-address 192.168.50.101;
 		}
 	}
+
+	group {
+		# NFSv4 root=dhcp, use profocol, options from root-path
+		option root-path "nfs4:192.168.50.3:/client:wsize=4096";
+
+		host nfs4-4 {
+			hardware ethernet 52:54:00:12:34:07;
+			fixed-address 192.168.50.101;
+		}
+	}
 }
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 77ec22a..eb46ad1 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -31,7 +31,8 @@ client_test() {
     local mac=$2
     local cmdline="$3"
     local server="$4"
-    local nfsinfo
+    local check_opt="$5"
+    local nfsinfo opts found expected
 
     echo "CLIENT TEST START: $test_name"
 
@@ -57,12 +58,40 @@ client_test() {
     nfsinfo=($(awk '{print $2, $3, $4; exit}' client.img)) 
 
     if [[ "${nfsinfo[0]%%:*}" != "$server" ]]; then
-	echo "CLIENT TEST INFO: $test_name got: ${nfsinfo[0]%%:*}"
-	echo "CLIENT TEST INFO: $test_name expected: $server"
+	echo "CLIENT TEST INFO: got server: ${nfsinfo[0]%%:*}"
+	echo "CLIENT TEST INFO: expected server: $server"
 	echo "CLIENT TEST END: $test_name [FAILED - WRONG SERVER]"
 	return 1
     fi
 
+    found=0
+    expected=1
+    if [[ ${check_opt:0:1} == '-' ]]; then
+	expected=0
+	check_opt=${check_opt:1}
+    fi
+	
+    opts=${nfsinfo[2]},
+    while [[ $opts ]]; do
+	if [[ ${opts%%,*} == $check_opt ]]; then
+	    found=1
+	    break
+	fi
+	opts=${opts#*,}
+    done
+
+    if [[ $found -ne $expected ]]; then
+	echo "CLIENT TEST INFO: got options: ${nfsinfo[2]%%:*}"
+	if [[ $expected -eq 0 ]]; then
+		echo "CLIENT TEST INFO: did not expect: $check_opt"
+		echo "CLIENT TEST END: $test_name [FAILED - UNEXPECTED OPTION]"
+	else
+		echo "CLIENT TEST INFO: missing: $check_opt"
+		echo "CLIENT TEST END: $test_name [FAILED - MISSING OPTION]"
+	fi
+	return 1
+    fi
+
     echo "CLIENT TEST END: $test_name [OK]"
     return 0
 }
@@ -74,44 +103,50 @@ test_run() {
     fi
 
     client_test "NFSv3 root=dhcp DHCP path only" 52:54:00:12:34:00 \
-	"root=dhcp" 192.168.50.1 || return 1
+	"root=dhcp" 192.168.50.1 -wsize=4096 || return 1
 
     client_test "NFSv3 root=nfs DHCP path only" 52:54:00:12:34:00 \
-	"root=nfs" 192.168.50.1 || return 1
+	"root=nfs" 192.168.50.1 -wsize=4096 || return 1
 
     client_test "NFSv3 root=/dev/nfs DHCP path only" 52:54:00:12:34:00 \
-	"root=/dev/nfs" 192.168.50.1 || return 1
+	"root=/dev/nfs" 192.168.50.1 -wsize=4096 || return 1
 
     client_test "NFSv3 root=dhcp DHCP IP:path" 52:54:00:12:34:01 \
-	"root=dhcp" 192.168.50.2 || return 1
+	"root=dhcp" 192.168.50.2 -wsize=4096 || return 1
 
     client_test "NFSv3 root=nfs DHCP IP:path" 52:54:00:12:34:01 \
-	"root=nfs" 192.168.50.2 || return 1
+	"root=nfs" 192.168.50.2 -wsize=4096 || return 1
 
     client_test "NFSv3 root=/dev/nfs DHCP IP:path" 52:54:00:12:34:01 \
-	"root=/dev/nfs" 192.168.50.2 || return 1
+	"root=/dev/nfs" 192.168.50.2 -wsize=4096 || return 1
 
     client_test "NFSv3 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:02 \
-	"root=dhcp" 192.168.50.3 || return 1
+	"root=dhcp" 192.168.50.3 -wsize=4096 || return 1
+
+    client_test "NFSv3 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:06 \
+	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
 
     # There is a mandatory 90 second recovery when starting the NFSv4
     # server, so put these later in the list to avoid a pause when doing
     # switch_root
 
     client_test "NFSv4 root=nfs4 DHCP path only" 52:54:00:12:34:03 \
-	"root=nfs4" 192.168.50.1 || return 1
+	"root=nfs4" 192.168.50.1 -wsize=4096 || return 1
 
     client_test "NFSv4 root=/dev/nfs4 DHCP path only" 52:54:00:12:34:03 \
-	"root=/dev/nfs4" 192.168.50.1 || return 1
+	"root=/dev/nfs4" 192.168.50.1 -wsize=4096 || return 1
 
     client_test "NFSv4 root=nfs4 DHCP IP:path" 52:54:00:12:34:04 \
-	"root=nfs4" 192.168.50.2 || return 1
+	"root=nfs4" 192.168.50.2 -wsize=4096 || return 1
 
     client_test "NFSv4 root=/dev/nfs4 DHCP IP:path" 52:54:00:12:34:04 \
-	"root=/dev/nfs4" 192.168.50.2 || return 1
+	"root=/dev/nfs4" 192.168.50.2 -wsize=4096 || return 1
 
     client_test "NFSv4 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:05 \
-	"root=dhcp" 192.168.50.3 || return 1
+	"root=dhcp" 192.168.50.3 -wsize=4096 || return 1
+
+    client_test "NFSv4 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:07 \
+	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
 }
 
 test_setup() {
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
