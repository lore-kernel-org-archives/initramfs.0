From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 3/4] 40network: always start netroot in ifup.sh
Date: Mon, 23 Mar 2015 17:12:17 +0100
Message-ID: <1427127138-12932-4-git-send-email-trenn@suse.de>
References: <1427127138-12932-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427127138-12932-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

It's totally irrelevant how the network is configured when
trying to setup netroot. It only matters if it could be
configured at all.
So change the logic the check for correct network setup
and then start netroot.

References: bnc#881235

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/40network/ifup.sh | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index de518b6..9af5474 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -338,21 +338,15 @@ for p in $(getargs ip=); do
         esac
     done
 
-    > /tmp/net.${netif}.up
+    if [ $? -eq 0 ]; then
+        > /tmp/net.${netif}.up
 
-    case $autoconf in
-        dhcp|on|any|dhcp6)
-            ;;
-        *)
-            if [ $? -eq 0 ]; then
-                setup_net $netif
-                source_hook initqueue/online $netif
-                if [ -z "$manualup" ]; then
-                    /sbin/netroot $netif
-                fi
-            fi
-            ;;
-    esac
+        setup_net $netif
+        source_hook initqueue/online $netif
+        if [ -z "$manualup" ]; then
+            /sbin/netroot $netif
+        fi
+    fi
 
     exit 0
 done
-- 
2.1.4
