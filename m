From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] fix ifup for static ipv6
Date: Mon, 11 Jun 2012 13:46:21 -0400
Message-ID: <1339436782-31960-1-git-send-email-wwoods@redhat.com>
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
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index f785968..245b450 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -105,10 +105,13 @@ do_static() {
     wait_for_if_up $netif
     [ -n "$macaddr" ] && ip link set address $macaddr
     [ -n "$mtu" ] && ip link set mtu $mtu
-    # do not flush addr for ipv6
-    strstr $ip '*:*:*' || \
+    if strstr $ip '*:*:*'; then
+        # note no ip addr flush for ipv6
+        ip addr add $ip/$mask dev $netif
+    else
         ip addr flush dev $netif
-    ip addr add $ip/$mask brd + dev $netif
+        ip addr add $ip/$mask brd + dev $netif
+    fi
 
     [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
     [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
-- 
1.7.10.2
