From: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/3] dracut.cmdline.7.asc: update document for rd.memdebug=4
Date: Mon,  7 Nov 2016 13:34:36 +0800
Message-ID: <1478496876-17580-3-git-send-email-xlpang@redhat.com>
References: <1478496876-17580-1-git-send-email-xlpang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478496876-17580-1-git-send-email-xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratush Panand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

"rd.memdebug=4" is for kernel module memory consumption debugging.

Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.cmdline.7.asc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 0009ff2..d2437ba 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -187,8 +187,8 @@ It should be attached to any report about dracut problems.
     _/run/initramfs/init.log_.
     If "quiet" is set, it also logs to the console.
 
-**rd.memdebug=[0-3]**::
-    Print memory usage info at various points, set the verbose level from 0 to 3.
+**rd.memdebug=[0-4]**::
+    Print memory usage info at various points, set the verbose level from 0 to 4.
 +    
     Higher level means more debugging output:
 +
@@ -197,6 +197,7 @@ It should be attached to any report about dracut problems.
     1 - partial /proc/meminfo
     2 - /proc/meminfo
     3 - /proc/meminfo + /proc/slabinfo
+    4 - /proc/meminfo + /proc/slabinfo + rough memory consumption of kernel modules 
 ----
 
 **rd.break**::
-- 
1.8.3.1
