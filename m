From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 05/12] 40network: separate 'mask' and 'prefix'
Date: Thu, 12 May 2016 20:03:29 +0200
Message-ID: <1463076216-410-6-git-send-email-trenn@suse.com>
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

The 'mask' parameter is used for both, the (IPv4) netmask and
the prefix length. As both are in different format separate them
out into 'mask' for the netmask and 'prefix' for the prefix length.
And also prefer the use of 'prefix' where possible to ease
calculation and better IPv6 support.

References: bnc#887542

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/40network/ifup.sh          | 17 +++++++++++----
 modules.d/40network/net-lib.sh       | 42 +++++++++++++++++++++++++++++++++---
 modules.d/40network/parse-ip-opts.sh |  2 +-
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 3234c56..4ab597f 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -105,17 +105,26 @@ do_static() {
 
     [ -n "$macaddr" ] && ip link set address $macaddr dev $netif
     [ -n "$mtu" ] && ip link set mtu $mtu dev $netif
-    if strglobin $ip '*:*:*'; then
+    [ -n "$mask" -a -z "$prefix" ] && prefix=$(mask_to_prefix $mask)
+    if [ "${ip##*/}" != "${ip}" ] ; then
+        prefix="${ip##*/}"
+        ip="${ip%/*}"
+    fi
+if strglobin $ip '*:*:*'; then
+        # Always assume /64 prefix for IPv6
+        [ -z "$prefix" ] && prefix=64
         # note no ip addr flush for ipv6
-        ip addr add $ip/$mask ${srv:+peer $srv} dev $netif
+        ip addr add $ip/$prefix ${srv:+peer $srv} dev $netif
         wait_for_ipv6_dad $netif
     else
         if ! arping -f -q -D -c 2 -I $netif $ip; then
             warn "Duplicate address detected for $ip for interface $netif."
             return 1
         fi
+        # Assume /24 prefix for IPv4
+        [ -z "$prefix" ] && prefix=24
         ip addr flush dev $netif
-        ip addr add $ip/$mask ${srv:+peer $srv} brd + dev $netif
+        ip addr add $ip/$prefix ${srv:+peer $srv} brd + dev $netif
     fi
 
     [ -n "$gw" ] && echo ip route replace default via $gw dev $netif > /tmp/net.$netif.gw
@@ -362,7 +371,7 @@ for p in $(getargs ip=); do
     done
 
     # Store config for later use
-    for i in ip srv gw mask hostname macaddr mtu dns1 dns2; do
+    for i in ip srv gw mask prefix hostname macaddr mtu dns1 dns2; do
         eval '[ "$'$i'" ] && echo '$i'="$'$i'"'
     done > /tmp/net.$netif.override
 
diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index c372665..322d5b5 100755
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -20,6 +20,35 @@ get_ip() {
     echo $ip
 }
 
+mask_to_prefix() {
+    local mask="$1"
+    local prefix=0
+    local OLDIFS="$IFS"
+
+    IFS=:
+    set -- $mask
+    IFS="$OLDIFS"
+    for mask in $@ ; do
+        if [ "$mask" -eq 255 ] ; then
+            prefix=$(($prefix + 8))
+        elif [ "$mask" -eq 254 ] ; then
+            prefix=$(($prefix + 7))
+        elif [ "$mask" -eq 252 ] ; then
+            prefix=$(($prefix + 6))
+        elif [ "$mask" -eq 248 ] ; then
+            prefix=$(($prefix + 5))
+        elif [ "$mask" -eq 240 ] ; then
+            prefix=$(($prefix + 4))
+        elif [ "$mask" -eq 224 ] ; then
+            prefix=$(($prefix + 3))
+        elif [ "$mask" -eq 192 ] ; then
+            prefix=$(($prefix + 2))
+        elif [ "$mask" -eq 128 ] ; then
+            prefix=$(($prefix + 1))
+        fi
+    done
+}
+
 iface_for_remote_addr() {
     set -- $(ip -o route get to $1)
     echo $5
@@ -232,7 +261,7 @@ ibft_to_cmdline() {
         for iface in /sys/firmware/ibft/ethernet*; do
             local mac="" dev=""
             local dhcp="" ip="" gw="" mask="" hostname=""
-            local dns1 dns2
+            local dns1 dns2 prefix
 
             [ -e ${iface}/mac ] || continue
             mac=$(read a < ${iface}/mac; echo $a)
@@ -280,6 +309,7 @@ ibft_to_cmdline() {
                 [ -e ${iface}/hostname ] && hostname=$(read a < ${iface}/hostname; echo $a)
                 if [ "$family" = "ipv6" ] ; then
                     if [ -n "$ip" ] ; then
+                        # Prefix defaults to 64 for IPv6
                         [ -n "$prefix" ] || prefix=64
                         ip="[${ip}/${prefix}]"
                         mask=
@@ -287,6 +317,11 @@ ibft_to_cmdline() {
                     if [ -n "$gw" ] ; then
                         gw="[${gw}]"
                     fi
+                else
+                    if [ -n "$prefix" ] ; then
+                        ip="$ip/$prefix"
+                        mask=
+                    fi
                 fi
                 if [ -n "$ip" ] && [ -n "$mask" -o -n "$prefix" ]; then
                     echo "ip=$ip::$gw:$mask:$hostname:$dev:none${dns1:+:$dns1}${dns2:+:$dns2}"
@@ -295,6 +330,7 @@ ibft_to_cmdline() {
                     warn "ip-addr=$ip"
                     warn "gateway=$gw"
                     warn "subnet-mask=$mask"
+                    warn "prefix-len=$prefix"
                     warn "hostname=$hostname"
                 fi
             else
@@ -442,7 +478,7 @@ ip_to_var() {
         fi
     done
 
-    unset ip srv gw mask hostname dev autoconf macaddr mtu dns1 dns2
+    unset ip srv gw mask prefix hostname dev autoconf macaddr mtu dns1 dns2
     case $# in
         0)  autoconf="error" ;;
         1)  autoconf=$1 ;;
@@ -473,7 +509,7 @@ ip_to_var() {
     # Extract prefix length from CIDR notation
     case $ip in
         */*)
-            mask=${ip##*/}
+            prefix=${ip##*/}
             ip=${ip%/*}
             ;;
     esac
diff --git a/modules.d/40network/parse-ip-opts.sh b/modules.d/40network/parse-ip-opts.sh
index 5779ef8..75ad0a4 100755
--- a/modules.d/40network/parse-ip-opts.sh
+++ b/modules.d/40network/parse-ip-opts.sh
@@ -72,7 +72,7 @@ for p in $(getargs ip=); do
             none|off)
                 [ -z "$ip" ] && \
                     die "For argument 'ip=$p'\nValue '$autoopt' without static configuration does not make sense"
-                [ -z "$mask" ] && \
+                [ -z "$mask" -a -z "$prefix" ] && \
                     die "Sorry, automatic calculation of netmask is not yet supported"
                 ;;
             auto6);;
-- 
2.1.4
