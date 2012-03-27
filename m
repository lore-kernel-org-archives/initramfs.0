From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] network: add save_netinfo, fix problems with nfs->NM takeover
Date: Mon, 26 Mar 2012 20:28:48 -0400
Message-ID: <1332808128-16497-2-git-send-email-wwoods@redhat.com>
References: <1332808128-16497-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332808128-16497-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

For NetworkManager to properly take over a NFS-root system, we need to
have the interface name(s) in /tmp/net.ifaces and save the dhclient
lease. This lets the ifcfg module do its magic.

save_netinfo should properly write out /tmp/net.ifaces when needed, and
copies the dhclient files into place.
---
 modules.d/40network/net-lib.sh |   15 +++++++++++++++
 modules.d/40network/netroot.sh |   10 ++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index b9a4953..6279cb4 100644
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -105,6 +105,21 @@ setup_net() {
     > /tmp/net.$netif.did-setup
 }
 
+save_netinfo() {
+    local netif="$1" IFACES="" f="" i=""
+    [ -e /tmp/net.ifaces ] && read IFACES < /tmp/net.ifaces
+    # Add $netif to the front of IFACES (if it's not there already).
+    set -- "$netif"
+    for i in $IFACES; do [ "$i" != "$netif" ] && set -- "$@" "$i"; done
+    IFACES="$*"
+    for i in $IFACES; do
+        for f in /tmp/dhclient.$i.*; do
+            [ -f $f ] && cp -f $f /tmp/net.${f#/tmp/dhclient.}
+        done
+    done
+    echo $IFACES > /tmp/net.ifaces
+}
+
 set_ifname() {
     local name="$1" mac="$2" num=0 n=""
     # if it's already set, return the existing name
diff --git a/modules.d/40network/netroot.sh b/modules.d/40network/netroot.sh
index ac1c215..1bb62bb 100755
--- a/modules.d/40network/netroot.sh
+++ b/modules.d/40network/netroot.sh
@@ -84,14 +84,8 @@ source_hook netroot
 # Run the handler; don't store the root, it may change from device to device
 # XXX other variables to export?
 if $handler $netif $netroot $NEWROOT; then
-    # Network rootfs mount successful
-    for iface in $IFACES ; do
-        [ -f /tmp/dhclient.$iface.lease ] &&    cp /tmp/dhclient.$iface.lease    /tmp/net.$iface.lease
-        [ -f /tmp/dhclient.$iface.dhcpopts ] && cp /tmp/dhclient.$iface.dhcpopts /tmp/net.$iface.dhcpopts
-    done
-
-    # Save used netif for later use
-    [ ! -f /tmp/net.ifaces ] && echo $netif > /tmp/net.ifaces
+    # Network rootfs mount successful - save interface info for ifcfg etc.
+    save_netinfo $netif
 else
     warn "Mounting root via '$netif' failed"
     # If we're trying with multiple interfaces, put that one down.
-- 
1.7.7.6
