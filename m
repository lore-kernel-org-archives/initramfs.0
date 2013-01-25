From: =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Subject: [PATCH] set peer for point-to-point connections
Date: Fri, 25 Jan 2013 14:23:58 +0100
Message-ID: <1359120238-9428-1-git-send-email-dan@danny.cz>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/40network/ifup.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 6c3133e..f64b16f 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -107,12 +107,13 @@ do_static() {
     linkup $netif
     [ -n "$macaddr" ] && ip link set address $macaddr dev $netif
     [ -n "$mtu" ] && ip link set mtu $mtu dev $netif
+    [ -n "$srv" ] && peer="peer $srv"
     if strstr $ip '*:*:*'; then
         # note no ip addr flush for ipv6
-        ip addr add $ip/$mask dev $netif
+        ip addr add $ip/$mask $peer dev $netif
     else
         ip addr flush dev $netif
-        ip addr add $ip/$mask brd + dev $netif
+        ip addr add $ip/$mask $peer brd + dev $netif
     fi
 
     [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
-- 
1.7.7.6
