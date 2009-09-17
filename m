From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 2/8] Be a bit more optimistic when setting mtus
Date: Thu, 17 Sep 2009 17:16:43 +0200
Message-ID: <1253200609-31629-3-git-send-email-philippe.seewer@bfh.ch>
References: <1253200609-31629-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1253200609-31629-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

The usual approach to setting mtus is to set the interface down,
set the mtu then set the interface back up again. Modern hardware
and/or drivers may support setting this on the fly, so we try
this and fall back to the old behaviour it it doesn't work.

In addition this patch only allows mtus greater than 576, this is
taken from debian/ubuntu dhclient-script.
---
 modules.d/40network/dhclient-script |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index c7c73cc..e3da4ea 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -13,10 +13,18 @@ setup_interface() {
 
     [ -f /tmp/net.$netif.override ] && . /tmp/net.$netif.override
 
-    if [ -n "$mtu" ] ; then
-	echo ip link set $netif down
-	echo ip link set $netif mtu $mtu
-	echo ip link set $netif up
+    # Taken from debian dhclient-script:
+    # The 576 MTU is only used for X.25 and dialup connections
+    # where the admin wants low latency.  Such a low MTU can cause
+    # problems with UDP traffic, among other things.  As such,
+    # disallow MTUs from 576 and below by default, so that broken
+    # MTUs are ignored, but higher stuff is allowed (1492, 1500, etc).
+    if [ -n "$mtu" ] && [ $mtu -gt 576 ] ; then
+	echo "if ! ip link set $netif mtu $mtu ; then"
+	echo "ip link set $netif down"
+	echo "ip link set $netif mtu $mtu"
+	echo "ip link set $netif up"
+	echo "fi"
     fi > /tmp/net.$netif.up
 
     echo ip addr add $ip${mask:+/$mask} ${bcast:+broadcast $bcast} dev $netif >> /tmp/net.$netif.up
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
