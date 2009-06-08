From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 05/11] NFS test: add test cases for DHCP/nfsroot=[IP:]/path[,options]
Date: Mon,  8 Jun 2009 00:40:18 -0400
Message-ID: <0000e1816cffe8175e846ed8d7099c8eb1bc9919.1244435634.git.dave@thedillows.org>
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
 test/TEST-20-NFS/dhcpd.conf |   78 +++++++++++++++++++++++++++++++++++++++++++
 test/TEST-20-NFS/test.sh    |   45 +++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 0 deletions(-)

diff --git a/test/TEST-20-NFS/dhcpd.conf b/test/TEST-20-NFS/dhcpd.conf
index 3c6f17d..a4f7fc1 100644
--- a/test/TEST-20-NFS/dhcpd.conf
+++ b/test/TEST-20-NFS/dhcpd.conf
@@ -54,6 +54,45 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 		}
 	}
 
+	group {
+		# NFSv3 root=dhcp, nfsroot=/path and nfsroot=IP:/path testing
+
+		host nfs3-5 {
+			hardware ethernet 52:54:00:12:34:04;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv3 root=dhcp, use path, comma-separated options
+		option root-path "/nfs/client,wsize=4096";
+
+		host nfs3-6 {
+			hardware ethernet 52:54:00:12:34:05;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv3 root=dhcp, use IP, path, comma-separated options
+		option root-path "192.168.50.2:/nfs/client,wsize=4096";
+
+		host nfs3-7 {
+			hardware ethernet 52:54:00:12:34:06;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv3 root=dhcp, use proto, IP, path, comma-separated options
+		option root-path "nfs:192.168.50.3:/nfs/client,wsize=4096";
+
+		host nfs3-8 {
+			hardware ethernet 52:54:00:12:34:07;
+			fixed-address 192.168.50.101;
+		}
+	}
+
 	# MAC numbering scheme:
 	# NFSv4: last octect starts at 0x80 and works up
 
@@ -96,4 +135,43 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 			fixed-address 192.168.50.101;
 		}
 	}
+
+	group {
+		# NFSv3 root=nfs4, nfsroot=/path and nfsroot=IP:/path testing
+		host nfs4-5 {
+			hardware ethernet 52:54:00:12:34:84;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv4 root={/dev/,}nfs4, use server-id, comma-separated opts
+		option root-path "/client,wsize=4096";
+
+		host nfs4-6 {
+			hardware ethernet 52:54:00:12:34:85;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv4 root={/dev/,}nfs4, use given IP, comma-separated opts
+		option root-path "192.168.50.2:/client,wsize=4096";
+
+		host nfs4-7 {
+			hardware ethernet 52:54:00:12:34:86;
+			fixed-address 192.168.50.101;
+		}
+	}
+
+	group {
+		# NFSv4 root=dhcp, use comma-separated opts
+		option root-path "nfs4:192.168.50.3:/client,wsize=4096";
+
+		host nfs4-8 {
+			hardware ethernet 52:54:00:12:34:87;
+			fixed-address 192.168.50.101;
+		}
+	}
+
 }
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 8adfdbb..5888fdc 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -130,6 +130,31 @@ test_run() {
     client_test "NFSv3 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:03 \
 	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
 
+    client_test "NFSv3 nfsroot=/nfs/client" 52:54:00:12:34:04 \
+	"nfsroot=/nfs/client" 192.168.50.1 -wsize=4096 || return 1
+
+    client_test "NFSv3 nfsroot=192.168.50.2:/nfs/client" 52:54:00:12:34:04 \
+	"nfsroot=192.168.50.2:/nfs/client" 192.168.50.2 -wsize=4096 || return 1
+
+    client_test "NFSv3 root=dhcp nfsroot=/nfs/client" 52:54:00:12:34:04 \
+	"root=dhcp nfsroot=/nfs/client" 192.168.50.1 -wsize=4096 || return 1
+
+    client_test "NFSv3 root=nfs nfsroot=/nfs/client" 52:54:00:12:34:04 \
+	"root=nfs nfsroot=/nfs/client" 192.168.50.1 -wsize=4096 || return 1
+
+    client_test "NFSv3 root=nfs nfsroot=/nfs/client,wsize=4096" \
+	52:54:00:12:34:04 "root=nfs nfsroot=/nfs/client,wsize=4096" \
+	192.168.50.1 wsize=4096 || return 1
+
+    client_test "NFSv3 root=nfs DHCP path,options" \
+	52:54:00:12:34:05 "root=dhcp" 192.168.50.1 wsize=4096 || return 1
+
+    client_test "NFSv3 root=dhcp DHCP IP:path,options" \
+	52:54:00:12:34:06 "root=dhcp" 192.168.50.2 wsize=4096 || return 1
+
+    client_test "NFSv3 root=dhcp DHCP proto:IP:path,options" \
+	52:54:00:12:34:07 "root=dhcp" 192.168.50.3 wsize=4096 || return 1
+
     # There is a mandatory 90 second recovery when starting the NFSv4
     # server, so put these later in the list to avoid a pause when doing
     # switch_root
@@ -151,6 +176,26 @@ test_run() {
 
     client_test "NFSv4 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:83 \
 	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
+
+    client_test "NFSv4 root=nfs4 nfsroot=/client" 52:54:00:12:34:84 \
+	"root=nfs4 nfsroot=/client" 192.168.50.1 -wsize=4096 || return 1
+
+    client_test "NFSv4 root=nfs4 nfsroot=192.168.50.2:/client" \
+	52:54:00:12:34:84 "root=nfs4 nfsroot=192.168.50.2:/client" \
+	192.168.50.2 -wsize=4096 || return 1
+
+    client_test "NFSv4 root=nfs4 nfsroot=path,opts" \
+	52:54:00:12:34:84 "root=nfs4 nfsroot=/client,wsize=4096" \
+	192.168.50.1 wsize=4096 || return 1
+
+    client_test "NFSv4 root=nfs4 DHCP path,options" \
+	52:54:00:12:34:85 "root=nfs4" 192.168.50.1 wsize=4096 || return 1
+
+    client_test "NFSv4 root=nfs4 DHCP IP:path,options" \
+	52:54:00:12:34:86 "root=nfs4" 192.168.50.2 wsize=4096 || return 1
+
+    client_test "NFSv4 root=dhcp DHCP proto:IP:path,options" \
+	52:54:00:12:34:87 "root=dhcp" 192.168.50.3 wsize=4096 || return 1
 }
 
 test_setup() {
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
