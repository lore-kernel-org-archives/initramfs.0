From: Leho Kraav <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] 99base: whitespace fix
Date: Mon, 22 Aug 2011 11:54:47 +0300
Message-ID: <1314003287-25481-1-git-send-email-leho@kraav.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Leho Kraav <leho-BFEd76tUscAAvxtiuMwx3w@public.gmane.org>

---
 modules.d/99base/initqueue |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/99base/initqueue b/modules.d/99base/initqueue
index 21b1c61..2c06a0b 100755
--- a/modules.d/99base/initqueue
+++ b/modules.d/99base/initqueue
@@ -19,8 +19,8 @@ while [ $# -gt 0 ]; do
             qname="/settled";;
         --finished)
             qname="/finished";;
-	--timeout)
-	    qname="/timeout";;
+        --timeout)
+            qname="/timeout";;
         --unique)
             unique="yes";;
         --name)
-- 
1.7.6
