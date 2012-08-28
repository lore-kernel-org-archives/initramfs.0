From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] use check_block_and_slaves in for_each_host_dev_and_slaves
Date: Tue, 28 Aug 2012 10:05:49 +0800
Message-ID: <20120828020549.GA6961@dhcp-16-143.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


for_each_host_dev_and_slaves currently is used in some module check()
functions and it's not necessary iterate all slaves. So use
check_block_and_slaves instead of check_block_and_slaves_all is fine.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut-functions.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- dracut.orig/dracut-functions.sh
+++ dracut/dracut-functions.sh
@@ -468,7 +468,7 @@ for_each_host_dev_and_slaves()
     local _dev
     for _dev in ${host_devs[@]}; do
         [[ -b "$_dev" ]] || continue
-        check_block_and_slaves_all $_func $(get_maj_min $_dev) && return 0
+        check_block_and_slaves $_func $(get_maj_min $_dev) && return 0
     done
     return 1
 }
