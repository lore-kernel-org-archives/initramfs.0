From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 1/8] Give the kernel some time to up interfaces
Date: Thu, 17 Sep 2009 17:16:42 +0200
Message-ID: <1253200609-31629-2-git-send-email-philippe.seewer@bfh.ch>
References: <1253200609-31629-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1253200609-31629-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

According to stock isc dhclient-script and other implementations
it is a good idea to wait a second after upping an interface to
let things settle.
---
 modules.d/40network/dhclient-script |    2 ++
 modules.d/40network/ifup            |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index a866952..c7c73cc 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -52,6 +52,8 @@ netif=$interface
 case $reason in
     PREINIT)
 	ip link set $netif up
+	# Give the kernel some time to up the interface
+	sleep 1
 	;;
     BOUND)
 	setup_interface 
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 37b78cd..ce39dcd 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -32,8 +32,9 @@ do_dhcp() {
 
 # Handle static ip configuration
 do_static() {
-{
+    {
 	echo ip link set $netif up 
+	echo sleep 1
 	echo ip addr flush dev $netif
 	echo ip addr add $ip/$mask dev $netif
     } > /tmp/net.$netif.up
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
