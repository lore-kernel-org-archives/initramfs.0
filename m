From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 09/11] NFS test: add test for nfs[4]:srv:/path syntax
Date: Mon,  8 Jun 2009 00:40:22 -0400
Message-ID: <bed87ed998e7c5d8470ffa31b97b4461ec494822.1244435634.git.dave@thedillows.org>
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
 test/TEST-20-NFS/test.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 6583366..e66d288 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -125,6 +125,9 @@ test_nfsv3() {
     client_test "NFSv3 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:03 \
 	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
 
+    client_test "NFSv3 root=nfs:..." 52:54:00:12:34:04 \
+	"root=nfs:192.168.50.1:/nfs/client" 192.168.50.1 -wsize=4096 || return 1
+
     client_test "NFSv3 nfsroot=/nfs/client" 52:54:00:12:34:04 \
 	"nfsroot=/nfs/client" 192.168.50.1 -wsize=4096 || return 1
 
@@ -183,6 +186,10 @@ test_nfsv4() {
     client_test "NFSv4 root=dhcp DHCP proto:IP:path:options" 52:54:00:12:34:83 \
 	"root=dhcp" 192.168.50.3 wsize=4096 || return 1
 
+    client_test "NFSv4 root=nfs4:..." 52:54:00:12:34:84 \
+	"root=nfs4:192.168.50.1:/client" 192.168.50.1 \
+	-wsize=4096 || return 1
+
     client_test "NFSv4 root=nfs4 nfsroot=/client" 52:54:00:12:34:84 \
 	"root=nfs4 nfsroot=/client" 192.168.50.1 -wsize=4096 || return 1
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
