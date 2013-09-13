From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] ifup: do not dhcp on network interface of secondary stack
Date: Fri, 13 Sep 2013 22:28:44 +0800
Message-ID: <20130913142844.GD2070@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Configure cmdline to:
 ip=br0:dhcp bridge=br0:bond0 bond=bond0:eth0

By default ifup bond0 will run dhcp on bond0, which is wrong. bond0
isn't the top interface. we should really run dhcp on br0.

So if we ifup an network interface on secondary stack, we should not
dhcp. Fix this issue with this patch.
---
 modules.d/40network/ifup.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 3261647..9f6f449 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -336,6 +336,13 @@ for p in $(getargs ip=); do
     exit 0
 done
 
+# netif isn't the top stack? Then we should exit here.
+# eg. netif is bond0. br0 is on top of it. dhcp br0 is correct but dhcp
+#     bond0 doesn't make sense.
+if [ -n "$DO_BOND_SETUP" -o -n "$DO_TEAM_SETUP" -o -n "$DO_VLAN_SETUP" ]; then
+    exit 0
+fi
+
 # no ip option directed at our interface?
 if [ ! -e /tmp/setup_net_${netif}.ok ]; then
     do_dhcp -4
-- 
1.8.3.1
