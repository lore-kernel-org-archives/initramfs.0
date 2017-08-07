From: Ankit Kumar <ankit-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH][dracut] Sync initramfs after creation
Date: Mon,  7 Aug 2017 12:13:53 +0530
Message-ID: <1502088233-10139-1-git-send-email-ankit@linux.vnet.ibm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hbathini-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, ankit-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org

If we trigger crash just after creating initramfs, sometimes it is
observed that initramfs is not written to disk causing the subsequent
boot to fail. A sync should resolve this.

Signed-off-by: Ankit Kumar <ankit-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 dracut.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dracut.sh b/dracut.sh
index 70dc79d..81e1562 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1806,4 +1806,10 @@ fi
 
 command -v restorecon &>/dev/null && restorecon -- "$outfile"
 
+sync $outfile 2> /dev/null
+if [ $? -ne 0 ] ; then
+    dinfo "dracut: sync operartion on newly created initramfs $outfile failed"
+    exit 1
+fi
+
 exit 0
-- 
2.7.4
