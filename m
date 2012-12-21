From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] Add a special handler when mount rootfs failed
Date: Fri, 21 Dec 2012 16:55:42 +0800
Message-ID: <d98a268350d0f13f6dd4d464a1a21517668eeb57.1356080083.git.bhe@redhat.com>
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

Dracut will drop into shell in case anything wrong with rootfs mounting,
but for kdump we does not depends on rootfs for non-rootfs dump and
kdump will handle the default fail action based on user configuration
in /etc/kdump.conf.

Here call exception_handle_check and specify a handler continue_on_fail.
If user add a cmdline like rd.exceptionhandler=continue_on_fail, then
go on. If no cmdline rd.exceptionhandler=continue_on_fail added, just
drop into shell as before.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/98systemd/dracut-initqueue.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/modules.d/98systemd/dracut-initqueue.sh b/modules.d/98systemd/dracut-initqueue.sh
index c10b32f..1d8d5a5 100755
--- a/modules.d/98systemd/dracut-initqueue.sh
+++ b/modules.d/98systemd/dracut-initqueue.sh
@@ -102,9 +102,14 @@ while :; do
     done
 
     i=$(($i+1))
-    [ $i -gt 20 ] && emergency_shell "Can't mount root filesystem"
+    [ $i -gt 20 ] && failure='yes' $$ break
 done
 
+if [ "$failure" = "yes" ]; then
+    exception_handle_check -h "continue_on_fail" "Can't mount root filesystem"
+    failure="no"
+fi
+
 {
     echo -n "Mounted root filesystem "
     while read dev mp rest; do [ "$mp" = "$NEWROOT" ] && echo $dev; done < /proc/mounts
-- 
1.7.1
