From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 32/42] 95fcoe: skip VLAN devices in fcoe-up
Date: Thu, 11 Dec 2014 15:46:23 +0100
Message-ID: <1418309193-11208-33-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

DCB & fipvlan can only be called on real devices, not VLAN
ones. So skip any VLAN devices which might been added to the
list of network interfaces.

References: bnc#878583

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95fcoe/fcoe-up.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/modules.d/95fcoe/fcoe-up.sh b/modules.d/95fcoe/fcoe-up.sh
index b9d0411..7f6eb1b 100755
--- a/modules.d/95fcoe/fcoe-up.sh
+++ b/modules.d/95fcoe/fcoe-up.sh
@@ -16,6 +16,14 @@ type ip_to_var >/dev/null 2>&1 || . /lib/net-lib.sh
 netif=$1
 dcb=$2
 
+iflink=$(cat /sys/class/net/$netif/iflink)
+ifindex=$(cat /sys/class/net/$netif/ifindex)
+if [ "$iflink" != "$ifindex" ] ; then
+    # Skip VLAN devices
+    exit 0
+fi
+
+ip link set dev $netif up
 linkup "$netif"
 
 netdriver=$(readlink -f /sys/class/net/$netif/device/driver)
-- 
1.8.5.2
