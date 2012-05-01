From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] ifcfg: fix resolv.conf
Date: Tue,  1 May 2012 14:08:34 -0400
Message-ID: <1335895714-21699-2-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

/etc/net.*.resolv.conf is not a useful filename; copy it to resolv.conf
---
 modules.d/45ifcfg/write-ifcfg.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index b81ac39..f612762 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -152,7 +152,7 @@ echo "files /etc/sysconfig/network-scripts" >> /run/initramfs/rwtab
 echo "files /var/lib/dhclient" >> /run/initramfs/rwtab
 {
     cp /tmp/net.* /run/initramfs/
-    cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/
+    cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/resolv.conf
     cp -a -t /run/initramfs/state/etc/sysconfig/network-scripts/ /tmp/ifcfg/*
     cp /tmp/ifcfg-leases/* /run/initramfs/state/var/lib/dhclient
 } > /dev/null 2>&1
-- 
1.7.7.6
