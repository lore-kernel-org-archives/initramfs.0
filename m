From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] 40network/ifup.sh: do_static() and do_ipv6auto return 0 if no errors.
Date: Thu, 18 Oct 2012 16:43:28 +0800
Message-ID: <1350549808-8891-1-git-send-email-chaowang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Commit a0be1ed removes some lines from do_static() and do_ipv6auto().

When $hostname is empty, do_static() and do_ipv6auto() will return 1
and fails to run setup_net at the last of ifup.sh

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/ifup.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 95289c9..db233de 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -88,6 +88,8 @@ do_ipv6auto() {
     wait_for_if_up $netif
 
     [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
+
+    return 0
 }
 
 # Handle static ip configuration
@@ -108,6 +110,8 @@ do_static() {
 
     [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
     [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
+
+    return 0
 }
 
 # loopback is always handled the same way
-- 
1.7.12.2
