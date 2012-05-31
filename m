From: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Handle multiple underlying devices of a bridge
Date: Thu, 31 May 2012 22:07:38 +0800
Message-ID: <1338473258-13467-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

A bridge device with only one underlying ethernet device is almost
useless, for sure we want to support a bridge with multiple
underlying devices.

This patch adds the support by extending <ethname> in the original
bridge= cmdline to a comma-separated list of ethernet interfaces.

Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 dracut.cmdline.7.asc                |    5 ++-
 modules.d/40network/ifup.sh         |   38 ++++++++++++++++++++--------------
 modules.d/40network/net-genrules.sh |    2 +-
 modules.d/40network/parse-bridge.sh |   17 ++++++++-------
 4 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index dcdbbce..b642d2f 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -316,8 +316,9 @@ auto6::: do IPv6 autoconfiguration
     then its values should be separated by semicolon.
     Bond without parameters assumes bond=bond0:eth0,eth1:mode=balance-rr
 
-**bridge=_<bridgename>_:_<ethname>_**::
-    Setup bridge <bridgename> with <ethname>. Bridge without parameters assumes bridge=br0:eth0
+**bridge=_<bridgename>_:_<ethnames>_**::
+    Setup bridge <bridgename> with <ethnames>. <ethnames> is a comma-separated
+    list of physical (ethernet) interfaces. Bridge without parameters assumes bridge=br0:eth0
 
 
 NFS
diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 1aaa1a8..c9516bb 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -31,13 +31,15 @@ fi
 # bridge this interface?
 if [ -e /tmp/bridge.info ]; then
     . /tmp/bridge.info
-    if [ "$netif" = "$ethname" ]; then
-        if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
-            : # We need to really setup bond (recursive call)
-        else
-            netif="$bridgename"
+    for ethname in $ethnames ; do
+        if [ "$netif" = "$ethname" ]; then
+            if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
+                : # We need to really setup bond (recursive call)
+            else
+                netif="$bridgename"
+            fi
         fi
-    fi
+    done
 fi
 
 if [ -e /tmp/vlan.info ]; then
@@ -175,18 +177,22 @@ fi
 
 # XXX need error handling like dhclient-script
 
+if [ -e /tmp/bridge.info ]; then
+    . /tmp/bridge.info
 # start bridge if necessary
-if [ "$netif" = "$bridgename" ] && [ ! -e /tmp/net.$bridgename.up ]; then
-    if [ "$ethname" = "$bondname" ] ; then
-        DO_BOND_SETUP=yes ifup $bondname
-    else
-        ip link set $ethname up
+    if [ "$netif" = "$bridgename" ] && [ ! -e /tmp/net.$bridgename.up ]; then
+        brctl addbr $bridgename
+        brctl setfd $bridgename 0
+        for ethname in $ethnames ; do
+            if [ "$ethname" = "$bondname" ] ; then
+                DO_BOND_SETUP=yes ifup $bondname
+            else
+                ip link set $ethname up
+            fi
+            wait_for_if_up $ethname
+            brctl addif $bridgename $ethname
+        done
     fi
-    wait_for_if_up $ethname
-    # Create bridge and add eth to bridge
-    brctl addbr $bridgename
-    brctl setfd $bridgename 0
-    brctl addif $bridgename $ethname
 fi
 
 get_vid() {
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index ca47b2b..2d3dff2 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -21,7 +21,7 @@ fix_bootif() {
     # bridge: attempt only the defined interface
     if [ -e /tmp/bridge.info ]; then
         . /tmp/bridge.info
-        IFACES=$ethname
+        IFACES=${ethnames%% *}
     fi
 
     # bond: attempt only the defined interface (override bridge defines)
diff --git a/modules.d/40network/parse-bridge.sh b/modules.d/40network/parse-bridge.sh
index 6e1fee1..5728fb6 100755
--- a/modules.d/40network/parse-bridge.sh
+++ b/modules.d/40network/parse-bridge.sh
@@ -3,8 +3,9 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 #
 # Format:
-#       bridge=<bridgename>:<ethname>
+#       bridge=<bridgename>:<ethnames>
 #
+#       <ethnames> is a comma-separated list of physical (ethernet) interfaces
 #       bridge without parameters assumes bridge=br0:eth0
 #
 
@@ -24,16 +25,16 @@ parsebridge() {
         v=${v#*:}
     done
 
-    unset bridgename ethname
+    unset bridgename ethnames
     case $# in
-        0)  bridgename=br0; ethname=$iface ;;
+        0)  bridgename=br0; ethnames=$iface ;;
         1)  die "bridge= requires two parameters" ;;
-        2)  bridgename=$1; ethname=$2 ;;
+        2)  bridgename=$1; ethnames=$(echo $2|tr "," " ") ;;
         *)  die "bridge= requires two parameters" ;;
     esac
 }
 
-unset bridgename ethname
+unset bridgename ethnames
 
 iface=eth0
 if [ -e /tmp/bond.info ]; then
@@ -43,7 +44,7 @@ if [ -e /tmp/bond.info ]; then
     fi
 fi
 
-# Parse bridge for bridgename and ethname
+# Parse bridge for bridgename and ethnames
 if bridge="$(getarg bridge)"; then
     # Read bridge= parameters if they exist
     if [ -n "$bridge" ]; then
@@ -52,9 +53,9 @@ if bridge="$(getarg bridge)"; then
     # Simple default bridge
     if [ -z "$bridgename" ]; then
         bridgename=br0
-        ethname=$iface
+        ethnames=$iface
     fi
     echo "bridgename=$bridgename" > /tmp/bridge.info
-    echo "ethname=$ethname" >> /tmp/bridge.info
+    echo "ethnames=\"$ethnames\"" >> /tmp/bridge.info
     return
 fi
-- 
1.7.7.6
