From: Gerd von Egidy <gerd.von.egidy-XXsH3GEs1jrby3iVrkZq2A@public.gmane.org>
Subject: [PATCH] Add support for ethernet point-to-point connections configured via DHCP
Date: Thu, 05 Mar 2015 12:07:57 +0100
Message-ID: <13711492.8HAMuGhYIN@thunder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

When current dracut receives an ip with netmask of 255.255.255.255 via DHCP,
setting the also supplied default gateway fails (because it is obviously not
within the netmask).

The setup with a netmask of /32 is quite common in colocation datacenters
where you don't want the machines of two different customers to directly talk
to each other. At least two of the biggest colocation providers in Germany
(1&1 and Strato) do it that way. NetworkManager supports this kind of setup
and the dhclient-scripts of several distributions too.

In this patch I have implemented a simple approach very similar to what is
found in Debian. The dhclient-script from Fedora uses a more sophisticated
approach, but that relies on the ipcalc utility which would introduce a
dependency on Fedora-initscripts for dracut.

Signed-off-by: Gerd von Egidy <gerd.von.egidy-XXsH3GEs1jrby3iVrkZq2A@public.gmane.org>
---
 modules.d/40network/dhclient-script.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/modules.d/40network/dhclient-script.sh b/modules.d/40network/dhclient-script.sh
index 50f1985..98352ec 100755
--- a/modules.d/40network/dhclient-script.sh
+++ b/modules.d/40network/dhclient-script.sh
@@ -43,7 +43,13 @@ setup_interface() {
         valid_lft ${lease_time} preferred_lft ${lease_time} \
         dev $netif
 
-    [ -n "$gw" ] && echo ip route replace default via $gw dev $netif > /tmp/net.$netif.gw
+    if [ -n "$gw" ] ; then
+        if [ "$mask" == "255.255.255.255" ] ; then
+            # point-to-point connection => set explicit route to gateway
+            echo ip route add $gw dev $netif > /tmp/net.$netif.gw
+        fi
+        echo ip route replace default via $gw dev $netif >> /tmp/net.$netif.gw
+    fi
 
     [ -n "${search}${domain}" ] && echo "search $search $domain" > /tmp/net.$netif.resolv.conf
     if  [ -n "$namesrv" ] ; then
-- 
1.9.3
