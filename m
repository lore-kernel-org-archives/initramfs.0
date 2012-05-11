From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] ifcfg: fix output for ipv6 static addressing
Date: Fri, 11 May 2012 18:45:07 -0400
Message-ID: <1336776308-15211-2-git-send-email-wwoods@redhat.com>
References: <1336776308-15211-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336776308-15211-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

IPV6 configuration is pretty different than IPV4; write out the correct
set of values to make static IPV6 addressing work.
---
 modules.d/45ifcfg/write-ifcfg.sh |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index f612762..06e3812 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -46,12 +46,21 @@ for netif in $IFACES ; do
             echo "BOOTPROTO=dhcp"
             cp /tmp/net.$netif.lease /tmp/ifcfg-leases/dhclient-$uuid-$netif.lease
         else
-            echo "BOOTPROTO=none"
-        # If we've booted with static ip= lines, the override file is there
+            # If we've booted with static ip= lines, the override file is there
             [ -e /tmp/net.$netif.override ] && . /tmp/net.$netif.override
-            echo "IPADDR=$ip"
-            echo "NETMASK=$mask"
-            [ -n "$gw" ] && echo "GATEWAY=$gw"
+            if strstr "$ip" "*:*:*"; then
+                echo "IPV6_AUTOCONF=no"
+                echo "IPV6ADDR=$ip/$mask"
+            else
+                echo "BOOTPROTO=none"
+                echo "IPADDR=$ip"
+                echo "NETMASK=$mask"
+            fi
+            if strstr "$gw" "*:*:*"; then
+                echo "IPV6_DEFAULTGW=$gw"
+            elif [ -n "$gw" ]; then
+                echo "GATEWAY=$gw"
+            fi
         fi
     } > /tmp/ifcfg/ifcfg-$netif
 
-- 
1.7.7.6
