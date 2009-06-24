From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 2/5] Give the kernel some time to up interfaces
Date: Wed, 24 Jun 2009 20:08:29 +0200
Message-ID: <1245866912-3643-3-git-send-email-philippe.seewer@bfh.ch>
References: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245866912-3643-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

It does not really matter if the kernel needs some time or if
the ethernet handshake takes a while. It's a good idea to wait
a second after upping an interface to let things settle.
---
 modules.d/40network/dhclient-script |    2 ++
 modules.d/40network/ifup            |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 5b36a40..9e7eefd 100755
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
index 89017bb..174edca 100755
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
