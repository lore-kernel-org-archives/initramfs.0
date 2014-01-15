From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] insert wdt kernel modules when watchdog is active
Date: Wed, 15 Jan 2014 20:53:50 +0800
Message-ID: <1389790430-17808-3-git-send-email-bhe@redhat.com>
References: <1389790430-17808-1-git-send-email-bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389790430-17808-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

When watchdog is enabled in 1st kernel, then crash dump in kdump
kernel will be interrupted if watchdog is timeout. Since some
wdt drivers can stop the watchdog when its driver is loaded,
e.g iTCO_wdt, this can benefit crash dump.

Add watchdog driver which is active in system to initramfs, its
loading can stop watchdog.
---
 modules.d/04watchdog/module-setup.sh | 37 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/modules.d/04watchdog/module-setup.sh b/modules.d/04watchdog/module-setup.sh
index 44dce61..51d454b 100755
--- a/modules.d/04watchdog/module-setup.sh
+++ b/modules.d/04watchdog/module-setup.sh
@@ -14,18 +14,29 @@ depends() {
 
 # called by dracut
 install() {
-    inst_hook cmdline   00 "$moddir/watchdog.sh"
-    inst_hook cmdline   50 "$moddir/watchdog.sh"
-    inst_hook pre-trigger 00 "$moddir/watchdog.sh"
-    inst_hook initqueue 00 "$moddir/watchdog.sh"
-    inst_hook mount     00 "$moddir/watchdog.sh"
-    inst_hook mount     50 "$moddir/watchdog.sh"
-    inst_hook mount     99 "$moddir/watchdog.sh"
-    inst_hook pre-pivot 00 "$moddir/watchdog.sh"
-    inst_hook pre-pivot 99 "$moddir/watchdog.sh"
-    inst_hook cleanup   00 "$moddir/watchdog.sh"
-    inst_hook cleanup   99 "$moddir/watchdog.sh"
-    inst_hook emergency 02 "$moddir/watchdog-stop.sh"
-    inst_multiple -o wdctl
+    if [[$testonly = "yes" ]]; then
+        inst_hook cmdline   00 "$moddir/watchdog.sh"
+        inst_hook cmdline   50 "$moddir/watchdog.sh"
+        inst_hook pre-trigger 00 "$moddir/watchdog.sh"
+        inst_hook initqueue 00 "$moddir/watchdog.sh"
+        inst_hook mount     00 "$moddir/watchdog.sh"
+        inst_hook mount     50 "$moddir/watchdog.sh"
+        inst_hook mount     99 "$moddir/watchdog.sh"
+        inst_hook pre-pivot 00 "$moddir/watchdog.sh"
+        inst_hook pre-pivot 99 "$moddir/watchdog.sh"
+        inst_hook cleanup   00 "$moddir/watchdog.sh"
+        inst_hook cleanup   99 "$moddir/watchdog.sh"
+        inst_hook emergency 02 "$moddir/watchdog-stop.sh"
+        inst_multiple -o wdctl
+    fi
 }
 
+installkernel() {
+    if [[$testonly = "no" ]]; then
+        wdt=$(lsmod|cut -f1 -d' '|grep "wdt$")
+        if [ -n "$wdt" ]; then
+            instmods $wdt
+            [ "$wdt" = "iTCO_wdt" ] && instmods lpc_ich
+        fi
+    fi
+}
-- 
1.8.3.1
