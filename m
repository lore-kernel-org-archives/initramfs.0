From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] net-lib: ibft_to_cmdline() fixes
Date: Wed, 4 Sep 2013 01:29:58 +0800
Message-ID: <20130903172958.GA6373@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Fix 3 issues in ibft_to_cmdline():
- unset local variables at the beginning of each loop
- only write vlan.conf when we write out ip=xxx
- when vlan id is 0, don't write out vlan.conf. Because 0 means untagged
  and we don't actually need vlan interface.
---
 modules.d/40network/net-lib.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index ca4b393..82c4f72 100644
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -203,11 +203,13 @@ fix_bootif() {
 }
 
 ibft_to_cmdline() {
-    local iface="" mac="" dev=""
-    local dhcp="" ip="" gw="" mask="" hostname=""
+    local iface=""
     modprobe -q iscsi_ibft
     (
         for iface in /sys/firmware/ibft/ethernet*; do
+            local mac="" dev=""
+            local dhcp="" ip="" gw="" mask="" hostname=""
+
             [ -e ${iface}/mac ] || continue
             mac=$(read a < ${iface}/mac; echo $a)
             [ -z "$mac" ] && continue
@@ -216,10 +218,6 @@ ibft_to_cmdline() {
             [ -e /tmp/net.${dev}.has_ibft_config ] && continue
 
             [ -e ${iface}/dhcp ] && dhcp=$(read a < ${iface}/dhcp; echo $a)
-            if [ -e ${iface}/vlan ]; then
-               vlan=$(read a < ${iface}/vlan; echo $a)
-                echo "vlan=$vlan:$dev"
-            fi
 
             if [ -n "$dhcp" ]; then
                 echo "ip=$dev:dhcp"
@@ -244,6 +242,11 @@ ibft_to_cmdline() {
                 ls -l ${iface} | vinfo
             fi
 
+            if [ -e ${iface}/vlan ]; then
+               vlan=$(read a < ${iface}/vlan; echo $a)
+               [ "$vlan" -ne "0" ] && echo "vlan=$vlan:$dev"
+            fi
+
             echo $mac > /tmp/net.${dev}.has_ibft_config
         done
     ) >> /etc/cmdline.d/40-ibft.conf
-- 
1.8.3.1
