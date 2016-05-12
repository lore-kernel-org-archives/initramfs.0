From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 04/12] 40network: Update iBFT scanning code to handle IPv6
Date: Thu, 12 May 2016 20:03:28 +0200
Message-ID: <1463076216-410-5-git-send-email-trenn@suse.com>
References: <1463076216-410-1-git-send-email-trenn@suse.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463076216-410-1-git-send-email-trenn-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.blume-IBi9RG/b67k@public.gmane.org, pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org, hare-IBi9RG/b67k@public.gmane.org, fvogt-IBi9RG/b67k@public.gmane.org, trenn-IBi9RG/b67k@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

IPv6 addresses should be specified in brackets so that the
ip= scanning code doesn't get confused.

References: bnc#887542

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/40network/net-lib.sh | 48 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index 31f1a56..c372665 100755
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -241,23 +241,54 @@ ibft_to_cmdline() {
 
             [ -e /tmp/net.${dev}.has_ibft_config ] && continue
 
+            [ -e ${iface}/flags ] && flags=$(read a < ${iface}/flags; echo $a)
+            # Skip invalid interfaces
+            (( $flags & 1 )) || continue
+            # Skip interfaces not used for booting
+            (( $flags & 2 )) || continue
             [ -e ${iface}/dhcp ] && dhcp=$(read a < ${iface}/dhcp; echo $a)
-
-            if [ -n "$dhcp" ]; then
-                echo "ip=$dev:dhcp"
+            [ -e ${iface}/origin ] && origin=$(read a < ${iface}/origin; echo $a)
+            [ -e ${iface}/ip-addr ] && ip=$(read a < ${iface}/ip-addr; echo $a)
+
+            if [ -n "$ip" ] ; then
+                case "$ip" in
+                    *.*.*.*)
+                        family=ipv4
+                        ;;
+                    *:*)
+                        family=ipv6
+                        ;;
+                esac
+            fi
+            if [ -n "$dhcp" ] || [ "$origin" -eq 3 ]; then
+                if [ "$family" = "ipv6" ] ; then
+                    echo "ip=$dev:dhcp6"
+                else
+                    echo "ip=$dev:dhcp"
+                fi
             elif [ -e ${iface}/ip-addr ]; then
-                [ -e ${iface}/ip-addr ] && ip=$(read a < ${iface}/ip-addr; echo $a)
                 # skip not assigned ip adresses
                 [ "$ip" = "0.0.0.0" ] && continue
                 [ -e ${iface}/gateway ] && gw=$(read a < ${iface}/gateway; echo $a)
                 [ "$gateway" = "0.0.0.0" ] && unset $gateway
                 [ -e ${iface}/subnet-mask ] && mask=$(read a < ${iface}/subnet-mask; echo $a)
+                [ -e ${iface}/prefix-len ] && prefix=$(read a < ${iface}/prefix-len; echo $a)
                 [ -e ${iface}/primary-dns ] && dns1=$(read a < ${iface}/primary-dns; echo $a)
                 [ "$dns1" = "0.0.0.0" ] && unset $dns1
                 [ -e ${iface}/secondary-dns ] && dns2=$(read a < ${iface}/secondary-dns; echo $a)
                 [ "$dns2" = "0.0.0.0" ] && unset $dns2
                 [ -e ${iface}/hostname ] && hostname=$(read a < ${iface}/hostname; echo $a)
-                if [ -n "$ip" ] && [ -n "$mask" ]; then
+                if [ "$family" = "ipv6" ] ; then
+                    if [ -n "$ip" ] ; then
+                        [ -n "$prefix" ] || prefix=64
+                        ip="[${ip}/${prefix}]"
+                        mask=
+                    fi
+                    if [ -n "$gw" ] ; then
+                        gw="[${gw}]"
+                    fi
+                fi
+                if [ -n "$ip" ] && [ -n "$mask" -o -n "$prefix" ]; then
                     echo "ip=$ip::$gw:$mask:$hostname:$dev:none${dns1:+:$dns1}${dns2:+:$dns2}"
                 else
                     warn "${iface} does not contain a valid iBFT configuration"
@@ -439,6 +470,13 @@ ip_to_var() {
             esac
             ;;
     esac
+    # Extract prefix length from CIDR notation
+    case $ip in
+        */*)
+            mask=${ip##*/}
+            ip=${ip%/*}
+            ;;
+    esac
 
     # ip=<ipv4-address> means anaconda-style static config argument cluster:
     # ip=<ip> gateway=<gw> netmask=<nm> hostname=<host> mtu=<mtu>
-- 
2.1.4
