From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Do not stop / start udev exec-queue around "mdadm -As --run"
Date: Thu, 17 Sep 2009 22:52:53 +0200
Message-ID: <1253220773-3393-1-git-send-email-hdegoede@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

When assembling containers + embedded arrays from mdadm.conf,
mdadm needs the /dev/md# node for the container to assemble the
arrays within the container. Stopping the udev exec queue, results in
this node not getting created and mdadm failing to online the
arrays within the container.

Not having stop / start udev exec-queue around "mdadm -As --run" should
be safe as the exact same command is run from rc.sysinit without
any queue locking.
---
 modules.d/90mdraid/mdadm_auto.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/modules.d/90mdraid/mdadm_auto.sh b/modules.d/90mdraid/mdadm_auto.sh
index 9e96b00..a971a5a 100755
--- a/modules.d/90mdraid/mdadm_auto.sh
+++ b/modules.d/90mdraid/mdadm_auto.sh
@@ -2,6 +2,4 @@
 . /lib/dracut-lib.sh
 
 info "Autoassembling MD Raid"    
-udevadm control --stop-exec-queue
 /sbin/mdadm -As --auto=yes --run 2>&1 | vinfo
-udevadm control --start-exec-queue
-- 
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
