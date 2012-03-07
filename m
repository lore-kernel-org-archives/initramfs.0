From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] write-ifcfg.sh: add UUID=.. and save the lease files with the same uuid
Date: Wed,  7 Mar 2012 17:21:54 -0500
Message-ID: <1331158914-20638-2-git-send-email-wwoods@redhat.com>
References: <1331158914-20638-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1331158914-20638-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

As described in https://bugzilla.redhat.com/show_bug.cgi?id=541410#c2,
if you want NetworkManager to take over an interface that you're using
for NFS root (or other network root device), you need to:

a) set UUID=<uuid> in ifcfg-<iface>, and
b) save the lease file as /var/lib/dhclient-<uuid>-<iface>.lease

This patch should make write-ifcfg handle both these things.
---
 modules.d/45ifcfg/write-ifcfg.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index 0f431e3..fe986df 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -18,11 +18,13 @@ if [ -e /tmp/bridge.info ]; then
 fi
 
 mkdir -m 0755 -p /tmp/ifcfg/
+mkdir -m 0755 -p /tmp/ifcfg-leases/
 
 for netif in $IFACES ; do
     # bridge?
     unset bridge
     unset bond
+    uuid=$(cat /proc/sys/kernel/random/uuid)
     if [ "$netif" = "$bridgename" ]; then
         bridge=yes
     elif [ "$netif" = "$bondname" ]; then
@@ -35,10 +37,12 @@ for netif in $IFACES ; do
         echo "DEVICE=$netif"
         echo "ONBOOT=yes"
         echo "NETBOOT=yes"
+        echo "UUID=$uuid"
         if [ -f /tmp/net.$netif.lease ]; then
             strstr "$ip" '*:*:*' &&
             echo "DHCPV6C=yes"
             echo "BOOTPROTO=dhcp"
+            cp /tmp/net.$netif.lease /tmp/ifcfg-leases/dhclient-$uuid-$netif.lease
         else
             echo "BOOTPROTO=none"
         # If we've booted with static ip= lines, the override file is there
@@ -135,9 +139,12 @@ done
 
 # Pass network opts
 mkdir -m 0755 -p /run/initramfs/state/etc/sysconfig/network-scripts
+mkdir -m 0755 -p /run/initramfs/state/var/lib/dhclient
 echo "files /etc/sysconfig/network-scripts" >> /run/initramfs/rwtab
+echo "files /var/lib/dhclient" >> /run/initramfs/rwtab
 {
     cp /tmp/net.* /run/initramfs/
     cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/
     cp -a -t /run/initramfs/state/etc/sysconfig/network-scripts/ /tmp/ifcfg/*
+    cp /tmp/ifcfg-leases/* /run/initramfs/state/var/lib/dhclient
 } > /dev/null 2>&1
-- 
1.7.7.6
