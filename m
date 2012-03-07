From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] write-ifcfg.sh: cleanups
Date: Wed,  7 Mar 2012 17:21:53 -0500
Message-ID: <1331158914-20638-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

mkdir -p creates intermediate directories and never returns an error, so
we don't need to create the intermediate directories ourself.
---
 modules.d/45ifcfg/write-ifcfg.sh |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index d633a96..0f431e3 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -134,11 +134,10 @@ for netif in $IFACES ; do
 done
 
 # Pass network opts
-[ -d /run/initramfs ] || mkdir -m 0755 -p /run/initramfs
-cp /tmp/net.* /run/initramfs/ >/dev/null 2>&1
-for i in /run/initramfs/state /run/initramfs/state/etc/ /run/initramfs/state/etc/sysconfig /run/initramfs/state/etc/sysconfig/network-scripts; do
-    [ -d $i ] || mkdir -m 0755 -p $i
-done
-cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/ >/dev/null 2>&1
-echo "files /etc/sysconfig/network-scripts" > /run/initramfs/rwtab
-cp -a -t /run/initramfs/state/etc/sysconfig/network-scripts/ /tmp/ifcfg/* >/dev/null 2>&1
+mkdir -m 0755 -p /run/initramfs/state/etc/sysconfig/network-scripts
+echo "files /etc/sysconfig/network-scripts" >> /run/initramfs/rwtab
+{
+    cp /tmp/net.* /run/initramfs/
+    cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/
+    cp -a -t /run/initramfs/state/etc/sysconfig/network-scripts/ /tmp/ifcfg/*
+} > /dev/null 2>&1
-- 
1.7.7.6
