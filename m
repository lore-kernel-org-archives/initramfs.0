From: Radek Vykydal <rvykydal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] Write BOOTPROTO=ibft for ip=ibft to ifcfg files
Date: Thu, 14 Mar 2013 09:51:07 +0100
Message-ID: <1363251067-1096-1-git-send-email-rvykydal@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 modules.d/40network/net-lib.sh   |  1 +
 modules.d/45ifcfg/write-ifcfg.sh | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index 4a4d7e7..f9b461b 100644
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -159,6 +159,7 @@ ibft_to_cmdline() {
                 hostname=$(read a < ${iface}/hostname; echo $a)
                 echo "ip=$ip::$gw:$mask:$hostname:$dev:none"
             fi
+            echo $mac > /tmp/net.${dev}.has_ibft_config
         done
     ) >> /etc/cmdline.d/40-ibft.conf
     # reread cmdline
diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index 79c1987..773dc51 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -106,7 +106,11 @@ for netif in $IFACES ; do
         [ -n "$mtu" ] && echo "MTU=$mtu"
         if [ -f /tmp/net.$netif.lease ]; then
             strstr "$ip" '*:*:*' && echo "IPV6INIT=yes"
-            echo "BOOTPROTO=dhcp"
+            if [ -f /tmp/net.$netif.has_ibft_config ]; then
+                echo "BOOTPROTO=ibft"
+            else
+                echo "BOOTPROTO=dhcp"
+            fi
             cp /tmp/net.$netif.lease /tmp/ifcfg-leases/dhclient-$uuid-$netif.lease
         else
             # If we've booted with static ip= lines, the override file is there
@@ -116,12 +120,16 @@ for netif in $IFACES ; do
                 echo "IPV6_AUTOCONF=no"
                 echo "IPV6ADDR=$ip/$mask"
             else
-                echo "BOOTPROTO=none"
-                echo "IPADDR=$ip"
-                if strstr "$mask" "."; then
-                    echo "NETMASK=$mask"
+                if [-f /tmp/net.$netif.has_ibft_config ]; then
+                    echo "BOOTPROTO=ibft"
                 else
-                    echo "PREFIX=$mask"
+                    echo "BOOTPROTO=none"
+                    echo "IPADDR=$ip"
+                    if strstr "$mask" "."; then
+                        echo "NETMASK=$mask"
+                    else
+                        echo "PREFIX=$mask"
+                    fi
                 fi
             fi
             if strstr "$gw" '*:*:*'; then
-- 
1.7.11.7
