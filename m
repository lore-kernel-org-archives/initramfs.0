From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] Specify a special handler when initqueue timeout
Date: Fri, 21 Dec 2012 16:55:41 +0800
Message-ID: <62e3118a99c8b13cd4a91f388e0dfddab1a67cdd.1356080083.git.bhe@redhat.com>
References: <76d7b2f339455dcea6a2827b004bfcd9c6fa2315.1356080083.git.bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <76d7b2f339455dcea6a2827b004bfcd9c6fa2315.1356080083.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <76d7b2f339455dcea6a2827b004bfcd9c6fa2315.1356080083.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
References: <76d7b2f339455dcea6a2827b004bfcd9c6fa2315.1356080083.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

In kdump, When the dump device was removed, dracut will drop to shell
during second kernel boot. That means kdump isn't even started. But
in this case, if the target isn't presented, we should dump to a rootfs
device as a default action.

Here call exception_handle_check and specify a handler continue_on_fail
which may be wanted by user, like kdump. If kdump add a cmdline like
rd.exceptionhandler=continue_on_fail, then nothoing done and go on. If
no cmdline rd.exceptionhandler=continue_on_fail added, just drop into
shell as before.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/98systemd/dracut-initqueue.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/modules.d/98systemd/dracut-initqueue.sh b/modules.d/98systemd/dracut-initqueue.sh
index e9da432..c10b32f 100755
--- a/modules.d/98systemd/dracut-initqueue.sh
+++ b/modules.d/98systemd/dracut-initqueue.sh
@@ -17,6 +17,7 @@ RDRETRY=${RDRETRY:-30}
 RDRETRY=$(($RDRETRY*2))
 export RDRETRY
 
+failure="no"
 main_loop=0
 export main_loop
 
@@ -61,9 +62,14 @@ while :; do
     fi
 
     main_loop=$(($main_loop+1))
-    [ $main_loop -gt $RDRETRY ] && emergency_shell "Could not boot."
+    [ $main_loop -gt $RDRETRY ] && failure="yes" && break 
 done
 
+if [ "$failure" = "yes" ]; then
+    failure="no"
+    exception_handler_check -h "continue_on_fail" "Could not boot"
+fi
+
 unset job
 unset queuetriggered
 unset main_loop
-- 
1.7.1
