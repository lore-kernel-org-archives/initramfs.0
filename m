From: Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V5 dracut 0/3] Install kernel module for active watchdog
Date: Mon, 18 Apr 2016 18:36:14 +0530
Message-ID: <20160418130614.GD28676@dhcppc6.redhat.com>
References: <cover.1458099200.git.panand@redhat.com>
 <5710BA3B.8030600@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5710BA3B.8030600-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi Harald,

On 15/04/2016:11:54:03 AM, Harald Hoyer wrote:
> pushed, please review my changes:
> <https://github.com/dracutdevs/dracut/commit/74e2d1e69f5527ab31b01fc19f67143d1f091980>

Thanks for rewriting the module nicely. I have to learn a lot in shell scripting :-).

I have commented at github. I found two errors during my testing:
(1) A case when install_kenrel() may not return 0 and it will cause to fail
dracut process.
(2) _wdtppath calculation before while loop need to be corrected, otherwise we
will not be able to install parent device's driver.

Following patches on top op upstream/master is working fine.

diff --git a/modules.d/04watchdog/module-setup.sh b/modules.d/04watchdog/module-setup.sh
index 04686f6..d50429f 100755
--- a/modules.d/04watchdog/module-setup.sh
+++ b/modules.d/04watchdog/module-setup.sh
@@ -56,7 +56,7 @@ installkernel() {
         # however in some cases, we also need to check that if there is
         # a specific driver for the parent bus/device.  In such cases
         # we also need to enable driver for parent bus/device.
-        _wdtppath=$(readlink -f "$_dir/device/..")
+        _wdtppath=$(readlink -f "$_dir/device/")
         while [[ -d "$_wdtppath" ]] && [[ "$_wdtppath" != "/sys" ]]; do
             _wdtppath=$(readlink -f "$_wdtppath/..")
             [[ -f "$_wdtppath/modalias" ]] || continue
@@ -73,5 +73,5 @@ installkernel() {
     done
     # ensure that watchdog module is loaded as early as possible
     _alldrivers="${!_drivers[*]}"
-    [[ $_alldrivers ]] && echo "rd.driver.pre=${_alldrivers// /,}" > ${initdir}/etc/cmdline.d/00-watchdog.conf
+    [[ $_alldrivers = "" ]] || echo "rd.driver.pre=${_alldrivers// /,}" > ${initdir}/etc/cmdline.d/00-watchdog.conf
 }

~Pratyush
