From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V4 dracut 3/3] watchdog: ensure that module is loaded as early as possible
Date: Tue,  8 Mar 2016 14:14:37 +0530
Message-ID: <e63d322e2cc3081a616f14f5586998811145931d.1457425628.git.panand@redhat.com>
References: <cover.1457425628.git.panand@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1457425628.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <cover.1457425628.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
References: <cover.1457425628.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

It is expected that a watchdog module will disable an active watchdog when
its probe is called ie, when it is loaded. So an early load of the module
will help to disable it earlier.
This can be helpful in some corner cases where kdump and watchdog daemon
both are active.

Testing:
    -- When watchdog kernel modules were added
	# dracut --no-hostonly initramfs-test.img -a watchdog
	# lsinitrd initramfs-test.img -f etc/cmdline.d/04-watchdog.conf
 	rd.driver.pre=iTCO_wdt,lpc_ich,

Signed-off-by: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/04watchdog/module-setup.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/modules.d/04watchdog/module-setup.sh b/modules.d/04watchdog/module-setup.sh
index 0ffaa9658502..d99e5b33de44 100755
--- a/modules.d/04watchdog/module-setup.sh
+++ b/modules.d/04watchdog/module-setup.sh
@@ -34,6 +34,7 @@ install() {
 
 installkernel() {
     [[ -d /sys/class/watchdog/ ]] || return
+    wdtcmdline=""
     for dir in /sys/class/watchdog/*; do
 	    [[ -d "$dir" ]] || continue
 	    [[ -f "$dir/state" ]] || continue
@@ -47,6 +48,7 @@ installkernel() {
 	    # represented by modalias
 	    wdtdrv=$(modprobe -R $wdtdrv)
 	    instmods $wdtdrv
+	    wdtcmdline="$wdtcmdline$(echo $wdtdrv | tr " " ","),"
 	    # however in some cases, we also need to check that if there is
 	    # a specific driver for the parent bus/device.  In such cases
 	    # we also need to enable driver for parent bus/device.
@@ -56,7 +58,10 @@ installkernel() {
 		    wdtpdrv=$(< "$wdtppath/modalias")
 		    wdtpdrv=$(modprobe -R $wdtpdrv)
 		    instmods $wdtpdrv
+		    wdtcmdline="$wdtcmdline$(echo $wdtpdrv | tr " " ","),"
 		    wdtppath=$(readlink -f "$wdtppath/..")
 	    done
     done
+    # ensure that watchdog module is loaded as early as possible
+    [[ $wdtcmdline = "" ]] || echo "rd.driver.pre=$wdtcmdline" > ${initdir}/etc/cmdline.d/04-watchdog.conf
 }
-- 
2.5.0
