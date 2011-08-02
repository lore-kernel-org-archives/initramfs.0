From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH] init: fix for setting udev logging priority
Date: Tue,  2 Aug 2011 14:46:56 +0200
Message-ID: <1312289216-5958-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Previously udevproperty() function was called, which would lead to
setting not intended properties instead of actually adjusting logging
priority, e.g.:

udevadm control --property=--log-priority=info

Now, udevadm is called directly from the init script.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/99base/init |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/modules.d/99base/init b/modules.d/99base/init
index ae834be..34a8aef 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -189,16 +189,14 @@ source_hook pre-udev
 # start up udev and trigger cold plugs
 udevd --daemon --resolve-names=never
 
-UDEV_LOG_PRIO_ARG=--log-priority
-UDEV_QUEUE_EMPTY="udevadm settle --timeout=0"
-
 if [ $UDEVVERSION -lt 140 ]; then
-    UDEV_LOG_PRIO_ARG=--log_priority
     UDEV_QUEUE_EMPTY="udevadm settle --timeout=1"
+else
+    UDEV_QUEUE_EMPTY="udevadm settle --timeout=0"
 fi
 
-getargbool 0 rd.udev.info -y rdudevinfo && udevproperty "$UDEV_LOG_PRIO_ARG=info"
-getargbool 0 rd.udev.debug -y rdudevdebug && udevproperty "$UDEV_LOG_PRIO_ARG=debug"
+getargbool 0 rd.udev.info -y rdudevinfo && udevadm control --log-priority=info
+getargbool 0 rd.udev.debug -y rdudevdebug && udevadm control --log-priority=debug
 udevproperty "hookdir=$hookdir"
 
 getarg 'rd.break=pre-trigger' 'rdbreak=pre-trigger' && emergency_shell -n pre-trigger "Break before pre-trigger"
-- 
1.7.5.2
