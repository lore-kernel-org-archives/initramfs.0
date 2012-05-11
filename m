From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] fix ifup for static ipv6 address
Date: Fri, 11 May 2012 18:45:06 -0400
Message-ID: <1336776308-15211-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

"brd +" is not valid for ipv6. This causes the 'ip addr add' command to
fail with the message "Broadcast can be set only for IPv4 addresses".

So: don't use "brd +" for ipv6.
---
 modules.d/40network/ifup.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 2111b41..e2c6023 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -107,10 +107,13 @@ do_static() {
         echo wait_for_if_up $netif
         [ -n "$macaddr" ] && echo ip link set address $macaddr
         [ -n "$mtu" ] && echo ip link set mtu $mtu
-        # do not flush addr for ipv6
-        strstr $ip '*:*:*' || \
+        if strstr $ip '*:*:*'; then
+            # do not flush addr for ipv6
+            echo ip addr add $ip/$mask dev $netif
+        else
             echo ip addr flush dev $netif
-        echo ip addr add $ip/$mask brd + dev $netif
+            echo ip addr add $ip/$mask brd + dev $netif
+        fi
     } > /tmp/net.$netif.up
 
     [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
-- 
1.7.7.6
