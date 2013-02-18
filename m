From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] Continue when mount rootfs failed by specifing 'continue_on_fail=mount_root'
Date: Mon, 18 Feb 2013 14:21:43 +0800
Message-ID: <ed5dd331cde646e6a3c52247f0cb0354a229d1e2.1361167889.git.bhe@redhat.com>
References: <cover.1361167889.git.bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1361167889.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <cover.1361167889.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
References: <cover.1361167889.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Dracut will drop into shell in case anything wrong with rootfs mounting,
but for kdump it does not depends on rootfs for non-rootfs dump and
kdump will handle the default fail action based on user configuration
in /etc/kdump.conf.

In this patch, add support to make dracut continue after mount rootfs
timeout by specifing parameter 'continue_on_fail=mount_root'.

dracut.cmdline.7.asc: change descrption related to 'continue_on_fail'

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.cmdline.7.asc                    |    4 ++--
 modules.d/98systemd/dracut-initqueue.sh |    5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 31d2d84..756e734 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -121,8 +121,8 @@ Misc
    specify the controlling terminal for the console.
    This is useful, if you have multiple "console=" arguments.
 
-**continue_on_fail=**_{initqueue}_::
-    continue after initqueue timeout by specify the timeout point 'initqueue'
+**continue_on_fail=**_{initqueue|mount_root}_::
+    continue after timeout if specify the relevant timeout point
 
 [[dracutkerneldebug]]
 Debug
diff --git a/modules.d/98systemd/dracut-initqueue.sh b/modules.d/98systemd/dracut-initqueue.sh
index f889d20..4fc72ad 100755
--- a/modules.d/98systemd/dracut-initqueue.sh
+++ b/modules.d/98systemd/dracut-initqueue.sh
@@ -99,7 +99,10 @@ while :; do
     done
 
     i=$(($i+1))
-    [ $i -gt 20 ] && emergency_shell "Can't mount root filesystem"
+    if [ $i -gt 20 ]; then
+        getarg 'continue_on_fail=mount_root' && break
+        emergency_shell "Can't mount root filesystem"
+    fi
 done
 
 {
-- 
1.7.1
