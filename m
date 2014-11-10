From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [Dracut PATCH] base: Set udevd log level via environment var to cover early startup.
Date: Mon, 10 Nov 2014 14:17:39 +0000
Message-ID: <1415629059-27564-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

udevd will these days default to 'info' logging and thus will
often print out the 'starting version nnn' message (which is
logged at level 'info'), thus spamming the console, even on
'quiet' boots.

We generally expect a udev log level of err (the old default
from pre-October 2013) so we should set that explicilty before
launching udevd in order to suppress the spurious 'info' message.

As we are using the environment variable approach anyway, we
may as well use this method rather than setting the log level
later via udevadm control commands when rd.udev.info/debug are
given on the kernel command line.

The enviroment variable has been around since udev 6b493a20e1
around 2005 so should be safe to use in all cases without version
checks.
---
 modules.d/99base/init.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index e249b27..3afe6d5 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -137,19 +137,19 @@ make_trace_mem "hook pre-udev" '1:shortmem' '2+:mem' '3+:slab'
 getarg 'rd.break=pre-udev' -d 'rdbreak=pre-udev' && emergency_shell -n pre-udev "Break before pre-udev"
 source_hook pre-udev
 
+UDEV_LOG=err
+getargbool 0 rd.udev.info -d -y rdudevinfo && UDEV_LOG=info
+getargbool 0 rd.udev.debug -d -y rdudevdebug && UDEV_LOG=debug
+
 # start up udev and trigger cold plugs
-$systemdutildir/systemd-udevd --daemon --resolve-names=never
+UDEV_LOG=$UDEV_LOG $systemdutildir/systemd-udevd --daemon --resolve-names=never
 
-UDEV_LOG_PRIO_ARG=--log-priority
 UDEV_QUEUE_EMPTY="udevadm settle --timeout=0"
 
 if [ $UDEVVERSION -lt 140 ]; then
-    UDEV_LOG_PRIO_ARG=--log_priority
     UDEV_QUEUE_EMPTY="udevadm settle --timeout=1"
 fi
 
-getargbool 0 rd.udev.info -d -y rdudevinfo && udevadm control "$UDEV_LOG_PRIO_ARG=info"
-getargbool 0 rd.udev.debug -d -y rdudevdebug && udevadm control "$UDEV_LOG_PRIO_ARG=debug"
 udevproperty "hookdir=$hookdir"
 
 make_trace_mem "hook pre-trigger" '1:shortmem' '2+:mem' '3+:slab'
-- 
2.1.3
