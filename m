From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/2] Add parameter continue_on_fail to make dracut continue after initqueue timeout
Date: Mon, 18 Feb 2013 14:21:42 +0800
Message-ID: <f882d74cd041626d5af732d048514a2832a72dc1.1361167889.git.bhe@redhat.com>
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

In kdump, When the dump device was removed, dracut will drop to shell
during second kernel boot. That means kdump isn't even started. But
in this case, if the target isn't presented, we should dump to a rootfs
device as a default action.

In this patch, add a new parameter continue_on_fail. After initqueue
timeout, detect whether this parameter is specified. If yes,continue.
If not, enter into emergency_shell.

For later extending, user need give timeout point. E.g, use this
parameter like below:
    continue_on_fail=initqueue

dracut.cmdline.7.asc: add the relevant description

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.cmdline.7.asc                    |    3 +++
 modules.d/98systemd/dracut-initqueue.sh |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index 62372a5..31d2d84 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -121,6 +121,9 @@ Misc
    specify the controlling terminal for the console.
    This is useful, if you have multiple "console=" arguments.
 
+**continue_on_fail=**_{initqueue}_::
+    continue after initqueue timeout by specify the timeout point 'initqueue'
+
 [[dracutkerneldebug]]
 Debug
 ~~~~~
diff --git a/modules.d/98systemd/dracut-initqueue.sh b/modules.d/98systemd/dracut-initqueue.sh
index 7de89e9..f889d20 100755
--- a/modules.d/98systemd/dracut-initqueue.sh
+++ b/modules.d/98systemd/dracut-initqueue.sh
@@ -61,7 +61,10 @@ while :; do
     fi
 
     main_loop=$(($main_loop+1))
-    [ $main_loop -gt $RDRETRY ] && emergency_shell "Could not boot."
+    if [ $main_loop -gt $RDRETRY ]; then
+        getarg 'continue_on_fail=initqueue' && break
+        emergency_shell "Could not boot."
+    fi
 done
 
 unset job
-- 
1.7.1
