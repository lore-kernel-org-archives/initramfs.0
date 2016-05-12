From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 02/12] 40network: always start netroot in ifup.sh
Date: Thu, 12 May 2016 20:03:26 +0200
Message-ID: <1463076216-410-3-git-send-email-trenn@suse.com>
References: <1463076216-410-1-git-send-email-trenn@suse.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463076216-410-1-git-send-email-trenn-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.blume-IBi9RG/b67k@public.gmane.org, pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org, hare-IBi9RG/b67k@public.gmane.org, fvogt-IBi9RG/b67k@public.gmane.org, trenn-IBi9RG/b67k@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

It's totally irrelevant how the network is configured when
trying to setup netroot. It only matters if it could be
configured at all.
So change the logic the check for correct network setup
and then start netroot.

References: bnc#881235

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/40network/ifup.sh | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 1185523..3234c56 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -388,19 +388,11 @@ for p in $(getargs ip=); do
             > /tmp/net.$(cat /sys/class/net/${netif}/address).up
         fi
 
-        case $autoconf in
-            dhcp|on|any|dhcp6)
-            ;;
-            *)
-                if [ $ret -eq 0 ]; then
-                    setup_net $netif
-                    source_hook initqueue/online $netif
-                    if [ -z "$manualup" ]; then
-                        /sbin/netroot $netif
-                    fi
-                fi
-                ;;
-        esac
+        setup_net $netif
+        source_hook initqueue/online $netif
+        if [ -z "$manualup" ]; then
+            /sbin/netroot $netif
+        fi
         exit $ret
     fi
 done
-- 
2.1.4
