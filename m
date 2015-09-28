From: Zhiguo Deng <bjzgdeng-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] Conceal ftp user passwd in rdsosreport
Date: Mon, 28 Sep 2015 09:20:30 +0200
Message-ID: <1443424830-6198-1-git-send-email-bjzgdeng@linux.vnet.ibm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Zhiguo Deng <bjzgdeng-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

When using authenticated FTP, the password contained in the kernel command line.
This causes it to end up in the generated /run/initramfs/rdsosreport.txt

Signed-off-by: Zhiguo Deng <bjzgdeng-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 modules.d/99base/rdsosreport.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/99base/rdsosreport.sh b/modules.d/99base/rdsosreport.sh
index 3e2ac87..4b8afb7 100755
--- a/modules.d/99base/rdsosreport.sh
+++ b/modules.d/99base/rdsosreport.sh
@@ -10,7 +10,7 @@ set -x
 
 cat /lib/dracut/dracut-*
 
-cat /proc/cmdline
+cat /proc/cmdline | sed -e 's/\(ftp:\/\/.*\):.*@/\1:*******@/'
 
 [ -f /etc/cmdline ] && cat /etc/cmdline
 
@@ -47,9 +47,9 @@ cat /proc/mdstat
 command -v ip >/dev/null 2>/dev/null && ip addr
 
 if command -v journalctl >/dev/null 2>/dev/null; then
-    journalctl -ab --no-pager -o short-monotonic
+    journalctl -ab --no-pager -o short-monotonic | sed -e 's/\(ftp:\/\/.*\):.*@/\1:*******@/'
 else
-    dmesg
+    dmesg | sed -e 's/\(ftp:\/\/.*\):.*@/\1:*******@/'
     [ -f /run/initramfs/init.log ] && cat /run/initramfs/init.log
 fi
 
-- 
1.9.1
