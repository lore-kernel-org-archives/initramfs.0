From: Radek Vykydal <rvykydal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] Don't write DHCPV6C=yes for each dhcp (ipv4) configuration.
Date: Thu, 14 Mar 2013 09:50:07 +0100
Message-ID: <1363251007-983-1-git-send-email-rvykydal@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Caused probably by commit 32ec0a762d1dce36f20857ffd222863a3d550ed7
---
 modules.d/45ifcfg/write-ifcfg.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index ae37358..79c1987 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -105,9 +105,7 @@ for netif in $IFACES ; do
         echo "UUID=$uuid"
         [ -n "$mtu" ] && echo "MTU=$mtu"
         if [ -f /tmp/net.$netif.lease ]; then
-            strstr "$ip" '*:*:*' &&
-            echo "IPV6INIT=yes"
-            echo "DHCPV6C=yes"
+            strstr "$ip" '*:*:*' && echo "IPV6INIT=yes"
             echo "BOOTPROTO=dhcp"
             cp /tmp/net.$netif.lease /tmp/ifcfg-leases/dhclient-$uuid-$netif.lease
         else
-- 
1.7.11.7
