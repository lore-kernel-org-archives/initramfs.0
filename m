From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2]dhclient initqueue hook fix
Date: Mon, 9 Jul 2012 14:56:35 +0800
Message-ID: <20120709065635.GA14094@dhcp-16-143.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

dhclient initqueue hook fix

setup_net is scheduled in initqueue, sometimes it does not get chance to run
So the default route will not be set properly

Add a check in initqueue/finished to resolve this issue.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/dhclient-script.sh |    2 ++
 1 file changed, 2 insertions(+)

--- dracut.orig/modules.d/40network/dhclient-script.sh
+++ dracut/modules.d/40network/dhclient-script.sh
@@ -81,9 +81,11 @@ case $reason in
             echo "setup_net $netif"
             echo "source_hook initqueue/online $netif"
             [ -e /tmp/net.$netif.manualup ] || echo "/sbin/netroot $netif"
+            echo "> /tmp/setup_net_$netif.ok"
             echo "rm -f $hookdir/initqueue/setup_net_$netif.sh"
         } > $hookdir/initqueue/setup_net_$netif.sh
 
+        echo "[ -f /tmp/setup_net_$netif.ok ]" > $hookdir/initqueue/finished/dhclient-$netif.sh
         >/tmp/net.$netif.up
         ;;
     *) echo "dhcp: $reason";;
