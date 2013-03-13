From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch v2 2/3] Improve documentation of rd.memdebug
Date: Wed, 13 Mar 2013 15:59:25 +0800
Message-ID: <20130313080318.906782984@redhat.com>
References: <20130313075923.845431353@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=mem-improve-1.5.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Explain more about rd.memdebug verbose level in dracut.cmdline.7.asc.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.cmdline.7.asc |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- dracut.orig/dracut.cmdline.7.asc
+++ dracut/dracut.cmdline.7.asc
@@ -144,8 +144,12 @@ It should be attached to any report abou
     If "quiet" is set, it also logs to the console.
 
 **rd.memdebug=[0-3]**::
-    print memory usage debug info, set the verbose level from 1 to 3
-    print nothing when set rd.memdebug=0
+    Print memory usage info at various points, set the verbose level from 0 to 3
+    Higher level means more debugging output:
+    0 - no output
+    1 - partial /proc/meminfo
+    2 - /proc/meminfo
+    3 - /proc/meminfo + /proc/slabinfo
 
 **rd.break**::
     drop to a shell at the end
