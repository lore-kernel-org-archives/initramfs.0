From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH 06/11] NFS test: separate NFSv3 and NFSv4 tests into their own functions
Date: Mon,  8 Jun 2009 00:40:19 -0400
Message-ID: <6b6805b8afcf97d4ddf6fa2cb4d7e0fe0e4f6635.1244435634.git.dave@thedillows.org>
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

The full tests take over 6 minutes to run, and commenting out unneeded
ones is time consuming -- this change lets me comment out one line to
temporarily avoid an entire class of tests.
---
 test/TEST-20-NFS/test.sh |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 5888fdc..4a997c4 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -96,12 +96,7 @@ client_test() {
     return 0
 }
 
-test_run() {
-    if ! run_server; then
-	echo "Failed to start server" 1>&2
-	return 1
-    fi
-
+test_nfsv3() {
     # MAC numbering scheme:
     # NFSv3: last octect starts at 0x00 and works up
     # NFSv4: last octect starts at 0x80 and works up
@@ -154,7 +149,9 @@ test_run() {
 
     client_test "NFSv3 root=dhcp DHCP proto:IP:path,options" \
 	52:54:00:12:34:07 "root=dhcp" 192.168.50.3 wsize=4096 || return 1
+}
 
+test_nfsv4() {
     # There is a mandatory 90 second recovery when starting the NFSv4
     # server, so put these later in the list to avoid a pause when doing
     # switch_root
@@ -198,6 +195,16 @@ test_run() {
 	52:54:00:12:34:87 "root=dhcp" 192.168.50.3 wsize=4096 || return 1
 }
 
+test_run() {
+    if ! run_server; then
+	echo "Failed to start server" 1>&2
+	return 1
+    fi
+
+    test_nfsv3 || return 1
+    test_nfsv4
+}
+
 test_setup() {
     # Make server root
     dd if=/dev/zero of=server.ext2 bs=1M count=30
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
