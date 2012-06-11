From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] ifcfg: fix output for ipv6 static addressing
Date: Mon, 11 Jun 2012 13:46:22 -0400
Message-ID: <1339436782-31960-2-git-send-email-wwoods@redhat.com>
References: <1339436782-31960-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339436782-31960-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

IPV6 configuration is pretty different than IPV4; write out the correct
set of values to make static IPV6 addressing work.
---
 modules.d/45ifcfg/write-ifcfg.sh |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index 202a16a..b62170d 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -109,16 +109,25 @@ for netif in $IFACES ; do
             echo "BOOTPROTO=dhcp"
             cp /tmp/net.$netif.lease /tmp/ifcfg-leases/dhclient-$uuid-$netif.lease
         else
-            echo "BOOTPROTO=none"
-        # If we've booted with static ip= lines, the override file is there
+            # If we've booted with static ip= lines, the override file is there
             [ -e /tmp/net.$netif.override ] && . /tmp/net.$netif.override
-            echo "IPADDR=$ip"
-            if strstr "$mask" "."; then
-                echo "NETMASK=$mask"
+            if strstr "$ip" '*:*:*'; then
+                echo "IPV6_AUTOCONF=no"
+                echo "IPV6ADDR=$ip/$mask"
             else
-                echo "PREFIX=$mask"
+                echo "BOOTPROTO=none"
+                echo "IPADDR=$ip"
+                if strstr "$mask" "."; then
+                    echo "NETMASK=$mask"
+                else
+                    echo "PREFIX=$mask"
+                fi
+            fi
+            if strstr "$gw" '*:*:*'; then
+                echo "IPV6_DEFAULTGW=$gw"
+            elif [ -n "$gw" ]; then
+                echo "GATEWAY=$gw"
             fi
-            [ -n "$gw" ] && echo "GATEWAY=$gw"
         fi
     } > /tmp/ifcfg/ifcfg-$netif
 
-- 
1.7.10.2
