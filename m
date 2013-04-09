From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] ifup.sh: Add support for bridge over a vlan tagged interface
Date: Tue,  9 Apr 2013 18:56:40 +0800
Message-ID: <1365505000-4831-1-git-send-email-chaowang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch add support for bridge a vlan tagged interface, like
br0 -> bond0.7 -> bond0 -> eth0

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

Hi, Harald

I tested it in F19 with br0->bond0.7->bond0->eth0 and network is expected in
2nd kernel.

Thanks

 modules.d/40network/ifup.sh | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 815ab64..e265841 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -39,6 +39,20 @@ if [ -e /tmp/team.info ]; then
     done
 fi
 
+if [ -e /tmp/vlan.info ]; then
+    . /tmp/vlan.info
+    if [ "$netif" = "$phydevice" ]; then
+        if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
+            : # We need to really setup bond (recursive call)
+        elif [ "$netif" = "$teammaster" ] && [ -n "$DO_TEAM_SETUP" ] ; then
+            : # We need to really setup team (recursive call)
+        else
+            netif="$vlanname"
+            use_vlan='true'
+        fi
+    fi
+fi
+
 # bridge this interface?
 if [ -e /tmp/bridge.info ]; then
     . /tmp/bridge.info
@@ -48,6 +62,8 @@ if [ -e /tmp/bridge.info ]; then
                 : # We need to really setup bond (recursive call)
             elif [ "$netif" = "$teammaster" ] && [ -n "$DO_TEAM_SETUP" ] ; then
                 : # We need to really setup team (recursive call)
+            elif [ "$netif" = "$vlanname" ] && [ -n "$DO_VLAN_SETUP" ]; then
+                : # We need to really setup vlan (recursive call)
             else
                 netif="$bridgename"
                 use_bridge='true'
@@ -56,20 +72,6 @@ if [ -e /tmp/bridge.info ]; then
     done
 fi
 
-if [ -e /tmp/vlan.info ]; then
-    . /tmp/vlan.info
-    if [ "$netif" = "$phydevice" ]; then
-        if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
-            : # We need to really setup bond (recursive call)
-        elif [ "$netif" = "$teammaster" ] && [ -n "$DO_TEAM_SETUP" ] ; then
-            : # We need to really setup team (recursive call)
-        else
-            netif="$vlanname"
-            use_vlan='true'
-        fi
-    fi
-fi
-
 # disable manual ifup while netroot is set for simplifying our logic
 # in netroot case we prefer netroot to bringup $netif automaticlly
 [ -n "$2" -a "$2" = "-m" ] && [ -z "$netroot" ] && manualup="$2"
@@ -218,6 +220,8 @@ if [ -e /tmp/bridge.info ]; then
                 DO_BOND_SETUP=yes ifup $bondname -m
             elif [ "$ethname" = "$teammaster" ] ; then
                 DO_TEAM_SETUP=yes ifup $teammaster -m
+            elif [ "$ethname" = "$vlanname" ]; then
+                DO_VLAN_SETUP=yes ifup $vlanname -m
             else
                 linkup $ethname
             fi
@@ -247,6 +251,7 @@ if [ "$netif" = "$vlanname" ] && [ ! -e /tmp/net.$vlanname.up ]; then
         linkup "$phydevice"
     fi
     ip link add dev "$vlanname" link "$phydevice" type vlan id "$(get_vid $vlanname)"
+    ip link set "$vlanname" up
 fi
 
 # setup nameserver
-- 
1.8.2
