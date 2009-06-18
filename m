From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/7] kill the server after the test_run
Date: Thu, 18 Jun 2009 15:26:17 +0200
Message-ID: <1245331581-2453-4-git-send-email-harald@redhat.com>
References: <1245331581-2453-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245331581-2453-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 test/TEST-20-NFS/test.sh |    4 ++++
 test/TEST-40-NBD/test.sh |    6 ++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 345ba4b..d3787ec 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -258,6 +258,10 @@ test_run() {
 
     test_nfsv3 || return 1
     test_nfsv4
+    if [[ -s server.pid ]]; then
+	sudo kill -TERM $(cat server.pid)
+	rm -f server.pid
+    fi
 }
 
 test_setup() {
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
index 8d98c08..f3a3d20 100755
--- a/test/TEST-40-NBD/test.sh
+++ b/test/TEST-40-NBD/test.sh
@@ -170,6 +170,12 @@ test_run() {
     client_test "NBD root=/dev/dracut/root netroot=dhcp (w/ fstype and opts)" \
 	52:54:00:12:34:05 \
 	"root=/dev/dracut/root netroot=dhcp" || return 1
+
+    if [[ -s server.pid ]]; then
+	sudo kill -TERM $(cat server.pid)
+	rm -f server.pid
+    fi
+
 }
 
 make_encrypted_root() {
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
