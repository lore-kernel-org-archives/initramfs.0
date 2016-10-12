From: Chad Dupuis <chad.dupuis-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] fcoe: Allow more time for the bnx2x link negotiation before brining up fcoe interfaces.
Date: Wed, 12 Oct 2016 11:32:47 -0400
Message-ID: <1476286367-30606-1-git-send-email-chad.dupuis@cavium.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: chad.dupuis-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org

bnx2x can take no longer than 3 seconds to initialize the link in some setups
which can cause fipvlan to fail and thus the fcoe interface(s) won't be
created.

Add another 10 seconds to give the link enough time to initialize.

Signed-off-by: Chad Dupuis <chad.dupuis-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 modules.d/95fcoe/fcoe-up.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/95fcoe/fcoe-up.sh b/modules.d/95fcoe/fcoe-up.sh
index fb3b4c4..ddc87b1 100755
--- a/modules.d/95fcoe/fcoe-up.sh
+++ b/modules.d/95fcoe/fcoe-up.sh
@@ -84,8 +84,8 @@ elif [ "$netdriver" = "bnx2x" ]; then
     # If driver is bnx2x, do not use /sys/module/fcoe/parameters/create but fipvlan
     modprobe 8021q
     udevadm settle --timeout=30
-    # Sleep for 3 s to allow dcb negotiation
-    sleep 3
+    # Sleep for 13 s to allow dcb negotiation
+    sleep 13
     fipvlan "$netif" -c -s
 else
     vlan="no"
-- 
1.8.5.6
