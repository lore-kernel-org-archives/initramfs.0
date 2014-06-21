From: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH] write-ifcfg.sh: Don't overwrite network config in root
 filesystem
Date: Sat, 21 Jun 2014 12:40:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1406211239250.1876@bbs.intern>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; format="flowed"; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch adds the possibility to keep the original
network configuration specified in the root filesystem.
This is necessary in situations with dual stack IPv4 and
IPv6 configurations or different kind on nameservers
(e.g. public ones at boot time, running a dns server
on localhost later on).

Keeping original configuration can be activated by:
networkstatic=yes
on the kernel boot command line.

Signed-off-by: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>
---
  modules.d/45ifcfg/write-ifcfg.sh | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index 803ae8e..033abe5 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -277,7 +277,10 @@ echo "files /etc/sysconfig/network-scripts" >> /run/initramfs/rwtab
  echo "files /var/lib/dhclient" >> /run/initramfs/rwtab
  {
      cp /tmp/net.* /run/initramfs/
-    cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/resolv.conf
-    copytree /tmp/ifcfg /run/initramfs/state/etc/sysconfig/network-scripts
+    networkstatic="$(getarg networkstatic=)"
+    if [ -z "${networkstatic}" ]; then
+        cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/resolv.conf
+        copytree /tmp/ifcfg /run/initramfs/state/etc/sysconfig/network-scripts
+    fi
      cp /tmp/ifcfg-leases/* /run/initramfs/state/var/lib/dhclient
  } > /dev/null 2>&1
-- 
1.9.3
