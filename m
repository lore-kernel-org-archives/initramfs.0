From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] network: also wait for ethernet interfaces to setup
Date: Mon, 12 Aug 2013 16:43:52 +0800
Message-ID: <20130812084352.GA3445@dhcp16-109.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We only wait for master interfaces for bridge/bonding/team/vlan case.
If none of these complex network is configured, we should wait for
ethernet interface (bootdev) instead.
---
 modules.d/40network/net-genrules.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index f6b7d9a..31cd1e6 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -74,7 +74,13 @@ command -v fix_bootif >/dev/null || . /lib/net-lib.sh
         done
         echo 'LABEL="net_end"'
 
-        for iface in $MASTER_IFACES; do
+        if [ -n "$MASTER_IFACES" ]; then
+            wait_ifaces=$MASTER_IFACES
+        else
+            wait_ifaces=$IFACES
+        fi
+
+        for iface in $wait_ifaces; do
             if [ "$bootdev" = "$iface" ] || [ "$NEEDNET" = "1" ]; then
                 echo "[ -f /tmp/setup_net_${iface}.ok ]" >$hookdir/initqueue/finished/wait-$iface.sh
             fi
-- 
1.8.3.1
