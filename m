From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 03/11] NFS test: renumber MAC addresses to ease adding new test cases
Date: Mon,  8 Jun 2009 00:40:16 -0400
Message-ID: <da2643fafba0f3f7e6a44c65ff298704ac5a62a3.1244435634.git.dave@thedillows.org>
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
 test/TEST-20-NFS/dhcpd.conf |   16 +++++++++++-----
 test/TEST-20-NFS/test.sh    |   18 +++++++++++-------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/test/TEST-20-NFS/dhcpd.conf b/test/TEST-20-NFS/dhcpd.conf
index 7d76180..3c6f17d 100644
--- a/test/TEST-20-NFS/dhcpd.conf
+++ b/test/TEST-20-NFS/dhcpd.conf
@@ -11,6 +11,9 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 	option domain-search "example.com";
 	option domain-name "other.com";
 
+	# MAC numbering scheme:
+	# NFSv3: last octect starts at 0x00 and works up
+
 	group {
 		# NFSv3 root=dhcp or root={/dev/,}nfs, use server-id
 		option root-path "/nfs/client";
@@ -46,17 +49,20 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 		option root-path "nfs:192.168.50.3:/nfs/client:wsize=4096";
 
 		host nfs3-4 {
-			hardware ethernet 52:54:00:12:34:06;
+			hardware ethernet 52:54:00:12:34:03;
 			fixed-address 192.168.50.101;
 		}
 	}
 
+	# MAC numbering scheme:
+	# NFSv4: last octect starts at 0x80 and works up
+
 	group {
 		# NFSv4 root={/dev/,}nfs4, use server-id
 		option root-path "/client";
 
 		host nfs4-1 {
-			hardware ethernet 52:54:00:12:34:03;
+			hardware ethernet 52:54:00:12:34:80;
 			fixed-address 192.168.50.101;
 		}
 	}
@@ -66,7 +72,7 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 		option root-path "192.168.50.2:/client";
 
 		host nfs4-2 {
-			hardware ethernet 52:54:00:12:34:04;
+			hardware ethernet 52:54:00:12:34:81;
 			fixed-address 192.168.50.101;
 		}
 	}
@@ -76,7 +82,7 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 		option root-path "nfs4:192.168.50.3:/client";
 
 		host nfs4-3 {
-			hardware ethernet 52:54:00:12:34:05;
+			hardware ethernet 52:54:00:12:34:82;
 			fixed-address 192.168.50.101;
 		}
 	}
@@ -86,7 +92,7 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 		option root-path "nfs4:192.168.50.3:/client:wsize=4096";
 
 		host nfs4-4 {
-			hardware ethernet 52:54:00:12:34:07;
+			hardware ethernet 52:54:00:12:34:83;
 			fixed-address 192.168.50.101;
 		}
 	}
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index eb46ad1..8adfdbb 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -102,6 +102,10 @@ test_run() {
 	return 1
     fi
 
+    # MAC numbering scheme:
+    # NFSv3: last octect starts at 0x00 and works up
+    # NFSv4: last octect starts at 0x80 and works up
+    
     client_test "NFSv3 root=dhcp DHCP path only" 52:54:00:12:34:00 \
 	"root=dhcp" 192.168.50.1 -wsize=4096 || return 1
 
@@ -123,29 +127,29 @@ test_run() {
     client_test "NFSv3 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:02 \
 	"root=dhcp" 192.168.50.3 -wsize=4096 || return 1
 
-    client_test "NFSv3 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:06 \
+    client_test "NFSv3 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:03 \
 	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
 
     # There is a mandatory 90 second recovery when starting the NFSv4
     # server, so put these later in the list to avoid a pause when doing
     # switch_root
 
-    client_test "NFSv4 root=nfs4 DHCP path only" 52:54:00:12:34:03 \
+    client_test "NFSv4 root=nfs4 DHCP path only" 52:54:00:12:34:80 \
 	"root=nfs4" 192.168.50.1 -wsize=4096 || return 1
 
-    client_test "NFSv4 root=/dev/nfs4 DHCP path only" 52:54:00:12:34:03 \
+    client_test "NFSv4 root=/dev/nfs4 DHCP path only" 52:54:00:12:34:80 \
 	"root=/dev/nfs4" 192.168.50.1 -wsize=4096 || return 1
 
-    client_test "NFSv4 root=nfs4 DHCP IP:path" 52:54:00:12:34:04 \
+    client_test "NFSv4 root=nfs4 DHCP IP:path" 52:54:00:12:34:81 \
 	"root=nfs4" 192.168.50.2 -wsize=4096 || return 1
 
-    client_test "NFSv4 root=/dev/nfs4 DHCP IP:path" 52:54:00:12:34:04 \
+    client_test "NFSv4 root=/dev/nfs4 DHCP IP:path" 52:54:00:12:34:81 \
 	"root=/dev/nfs4" 192.168.50.2 -wsize=4096 || return 1
 
-    client_test "NFSv4 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:05 \
+    client_test "NFSv4 root=dhcp DHCP proto:IP:path" 52:54:00:12:34:82 \
 	"root=dhcp" 192.168.50.3 -wsize=4096 || return 1
 
-    client_test "NFSv4 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:07 \
+    client_test "NFSv4 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:83 \
 	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
 }
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
