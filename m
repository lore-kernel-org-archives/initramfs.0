From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] network: support multiple bonding interfaces
Date: Wed, 12 Dec 2012 14:45:04 +0800
Message-ID: <3a4c80307e5f44719a4fdc77e53063e1a8575614.1355294587.git.bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> 

Currently dracut only support 1 bond, namyly bond0 by default. However multiple
bonds configuration may be needed. For example in kdump, in 1st kernel, more
than one bonds may be configured, and bondX other than bond0 is used as output
interface to remote host which will store dump core. This patch can solve this
problem, to write real bond information to initramfs, 2nd kdump kernel will
use it to create the relevant bondX interface.

Tested-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/ifup.sh         |   15 ++++++++++-----
 modules.d/40network/net-genrules.sh |    9 ++++++---
 modules.d/40network/parse-bond.sh   |    6 +++---
 modules.d/40network/parse-bridge.sh |    6 ------
 modules.d/45ifcfg/write-ifcfg.sh    |    9 +++++----
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 70bc161..c425b25 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -19,14 +19,18 @@ type ip_to_var >/dev/null 2>&1 || . /lib/net-lib.sh
 netif=$1
 
 # enslave this interface to bond?
-if [ -e /tmp/bond.info ]; then
-    . /tmp/bond.info
+for i in /tmp/bond.*.info; do
+    [ -e "$i" ] || continue
+    unset bondslaves
+    unset bondname
+    . "$i"
     for slave in $bondslaves ; do
         if [ "$netif" = "$slave" ] ; then
             netif=$bondname
+            break 2
         fi
     done
-fi
+done
 
 # bridge this interface?
 if [ -e /tmp/bridge.info ]; then
@@ -122,11 +126,12 @@ if [ "$netif" = "lo" ] ; then
 fi
 
 # start bond if needed
-if [ -e /tmp/bond.info ]; then
-    . /tmp/bond.info
+if [ -e /tmp/bond.${netif}.info ]; then
+    . /tmp/bond.${netif}.info
 
     if [ "$netif" = "$bondname" ] && [ ! -e /tmp/net.$bondname.up ] ; then # We are master bond device
         modprobe bonding
+        echo "+$netif" >  /sys/class/net/bonding_masters
         ip link set $netif down
 
         # Stolen from ifup-eth
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index d2197ff..abb6087 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -28,11 +28,14 @@ fi
     fi
 
     # bond: attempt only the defined interface (override bridge defines)
-    if [ -e /tmp/bond.info ]; then
-        . /tmp/bond.info
+    for i in /tmp/bond.*.info; do
+        [ -e "$i" ] || continue
+        unset bondslaves
+        unset bondname
+        . "$i"
         # It is enough to fire up only one
         IFACES+=" ${bondslaves%% *}"
-    fi
+    done
 
     if [ -e /tmp/vlan.info ]; then
         . /tmp/vlan.info
diff --git a/modules.d/40network/parse-bond.sh b/modules.d/40network/parse-bond.sh
index 983eb3a..25c51b8 100755
--- a/modules.d/40network/parse-bond.sh
+++ b/modules.d/40network/parse-bond.sh
@@ -54,8 +54,8 @@ if getarg bond >/dev/null; then
     fi
     # Make it suitable for initscripts export
     bondoptions=$(str_replace "$bondoptions" ";" ",")
-    echo "bondname=$bondname" > /tmp/bond.info
-    echo "bondslaves=\"$bondslaves\"" >> /tmp/bond.info
-    echo "bondoptions=\"$bondoptions\"" >> /tmp/bond.info
+    echo "bondname=$bondname" > /tmp/bond.${bondname}.info
+    echo "bondslaves=\"$bondslaves\"" >> /tmp/bond.${bondname}.info
+    echo "bondoptions=\"$bondoptions\"" >> /tmp/bond.${bondname}.info
     return
 fi
diff --git a/modules.d/40network/parse-bridge.sh b/modules.d/40network/parse-bridge.sh
index 1f027bb..8c305c0 100755
--- a/modules.d/40network/parse-bridge.sh
+++ b/modules.d/40network/parse-bridge.sh
@@ -37,12 +37,6 @@ parsebridge() {
 unset bridgename ethnames
 
 iface=eth0
-if [ -e /tmp/bond.info ]; then
-    . /tmp/bond.info
-    if [ -n "$bondname" ] ; then
-        iface=$bondname
-    fi
-fi
 
 # Parse bridge for bridgename and ethnames
 if bridge="$(getarg bridge)"; then
diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index ae37358..57dbe60 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -9,10 +9,6 @@ udevadm settle --timeout=30
 
 read IFACES < /tmp/net.ifaces
 
-if [ -e /tmp/bond.info ]; then
-    . /tmp/bond.info
-fi
-
 if [ -e /tmp/bridge.info ]; then
     . /tmp/bridge.info
 fi
@@ -89,6 +85,11 @@ for netif in $IFACES ; do
     # bridge?
     unset bridge
     unset bond
+    unset bondslaves
+    unset bondname
+    unset bondoptions
+    [ -e /tmp/bond.${netif}.info ] && . /tmp/bond.${netif}.info
+
     uuid=$(cat /proc/sys/kernel/random/uuid)
     if [ "$netif" = "$bridgename" ]; then
         bridge=yes
-- 
1.7.1
