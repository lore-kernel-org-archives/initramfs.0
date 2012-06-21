From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] network: support vlan tagged bonding
Date: Thu, 21 Jun 2012 11:44:35 +0800
Message-ID: <1340250275-24823-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch adds support of vlan tagged bonding, for example,
bond0.2. In case of regression, I also tested bond0 and eth0.2,
all work fine.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 modules.d/40network/ifup.sh         |    8 ++++++--
 modules.d/40network/net-genrules.sh |    6 +++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 31eb966..316a21a 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -188,7 +188,7 @@ if [ -e /tmp/bridge.info ]; then
         brctl setfd $bridgename 0
         for ethname in $ethnames ; do
             if [ "$ethname" = "$bondname" ] ; then
-                DO_BOND_SETUP=yes ifup $bondname
+                DO_BOND_SETUP=yes ifup $bondname -m
             else
                 ip link set $ethname up
             fi
@@ -211,7 +211,11 @@ get_vid() {
 
 if [ "$netif" = "$vlanname" ] && [ ! -e /tmp/net.$vlanname.up ]; then
     modprobe 8021q
-    ip link set "$phydevice" up
+    if [ "$phydevice" = "$bondname" ] ; then
+        DO_BOND_SETUP=yes ifup $phydevice -m
+    else
+        ip link set "$phydevice" up
+    fi
     wait_for_if_up "$phydevice"
     ip link add dev "$vlanname" link "$phydevice" type vlan id "$(get_vid $vlanname; echo $?)"
 fi
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 99d0fe5..867abcf 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -21,19 +21,19 @@ fix_bootif() {
     # bridge: attempt only the defined interface
     if [ -e /tmp/bridge.info ]; then
         . /tmp/bridge.info
-        IFACES=${ethnames%% *}
+        IFACES+=" ${ethnames%% *}"
     fi
 
     # bond: attempt only the defined interface (override bridge defines)
     if [ -e /tmp/bond.info ]; then
         . /tmp/bond.info
         # It is enough to fire up only one
-        IFACES=${bondslaves%% *}
+        IFACES+=" ${bondslaves%% *}"
     fi
 
     if [ -e /tmp/vlan.info ]; then
         . /tmp/vlan.info
-        IFACES=$phydevice
+        IFACES+=" $phydevice"
     fi
 
     ifup='/sbin/ifup $env{INTERFACE}'
-- 
1.7.7.6
