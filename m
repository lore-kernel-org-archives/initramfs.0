From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 dracut 3/3] watchdog: ensure that module is loaded as early as possible
Date: Mon,  7 Mar 2016 09:54:46 +0530
Message-ID: <28a6dc93202c66f9dfaa1ceae073040ae71508bb.1457321591.git.panand@redhat.com>
References: <cover.1457321591.git.panand@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1457321591.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <cover.1457321591.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
References: <cover.1457321591.git.panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

Signed-off-by: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/04watchdog/module-setup.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/modules.d/04watchdog/module-setup.sh b/modules.d/04watchdog/module-setup.sh
index 62e3fdf7829f..7667850ece8f 100755
--- a/modules.d/04watchdog/module-setup.sh
+++ b/modules.d/04watchdog/module-setup.sh
@@ -33,6 +33,7 @@ install() {
 }
 
 installkernel() {
+    wdtcmdline=""
     cd /sys/class/watchdog
     for dir in */; do
 	    cd $dir
@@ -46,6 +47,7 @@ installkernel() {
 		    # represented by modalias
 		    wdtdrv=`modprobe -R $wdtdrv | tr "\n" "," | sed 's/.$//'`
 		    instmods $wdtdrv
+		    wdtcmdline="$wdtcmdline$wdtdrv,"
 		    # however in some cases, we also need to check that if
 		    # there is a specific driver for the parent bus/device.
 		    # In such cases we also need to enable driver for parent
@@ -56,9 +58,14 @@ installkernel() {
 			    wdtpdrv=`cat $wdtppath/modalias`
 			    wdtpdrv=`modprobe -R $wdtpdrv | tr "\n" "," | sed 's/.$//'`
 			    instmods $wdtpdrv
+			    wdtcmdline="$wdtcmdline$wdtpdrv,"
 			    wdtppath="$wdtppath/.."
 		    done
 	    fi
 	    cd ..
     done
+    # ensure that watchdog module is loaded as early as possible
+    if [[ $wdtcmdline ]]; then
+	    echo "rd.driver.pre=$wdtcmdline" > ${initdir}/etc/cmdline.d/04-watchdog.conf
+    fi
 }
-- 
2.5.0
