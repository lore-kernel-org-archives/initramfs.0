From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 6/9] NFS test: rearrange the server tree so we can differentiate NFSv3 vs NFSv4
Date: Sat,  6 Jun 2009 05:23:27 -0400
Message-ID: <35b709957fc915f3e34753ef143989f9c9fbe9c9.1244279679.git.dave@thedillows.org>
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

---
 test/TEST-20-NFS/dhcpd.conf |    2 +-
 test/TEST-20-NFS/exports    |    5 ++---
 test/TEST-20-NFS/test.sh    |    4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/test/TEST-20-NFS/dhcpd.conf b/test/TEST-20-NFS/dhcpd.conf
index 7ee1cac..79b6a7b 100644
--- a/test/TEST-20-NFS/dhcpd.conf
+++ b/test/TEST-20-NFS/dhcpd.conf
@@ -13,7 +13,7 @@ subnet 192.168.50.0 netmask 255.255.255.0 {
 
 	group {
 		# NFSv3 root=dhcp or root={/dev/,}nfs, use server-id
-		option root-path "/client";
+		option root-path "/nfs/client";
 
 		host nfs3-1 {
 			hardware ethernet 52:54:00:12:34:00;
diff --git a/test/TEST-20-NFS/exports b/test/TEST-20-NFS/exports
index 0ec4f0c..2701877 100644
--- a/test/TEST-20-NFS/exports
+++ b/test/TEST-20-NFS/exports
@@ -1,3 +1,2 @@
-/       192.168.50.0/24(ro,fsid=0,insecure,no_subtree_check,no_root_squash)
-/client 192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash)
-
+/nfs		192.168.50.0/24(ro,fsid=0,insecure,no_subtree_check,no_root_squash)
+/nfs/client	192.168.50.0/24(ro,insecure,no_subtree_check,no_root_squash)
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 580c4df..5ec2341 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -99,8 +99,8 @@ test_setup() {
     )
 
     # Make client root inside server root
-    initdir=mnt/client
-    mkdir $initdir
+    initdir=mnt/nfs/client
+    mkdir -p $initdir
 
     (
 	. $basedir/dracut-functions
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
