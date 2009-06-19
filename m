From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [RFT PATCH] Delay netroot mounting by 1 second
Date: Fri, 19 Jun 2009 15:45:48 +0200
Message-ID: <4A3B968C.5070600@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

While testing in our production environment, I discovered
that the time between interface configuration and trying 
to mount the nfs root is too short if the dhcp-server 
provides an mtu. Having to set a mtu means that netroot
executes 'ip link down', set's the mtu and the does
'ip link up' again.

This results in the mount error "No route to host", because
the network equipment has not had enough time to "shake hands". 
The patch below adds a sleep 1 after interface configuration, 
to give the equipment enough time.

Could anyone with a similar environment (and possibly with
a netroot server reachable only via default route) test this
with and without this patch to confirm?

Thank you,
Philippe


diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index f719d93..81b99f7 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -88,7 +88,11 @@ for iface in $IFACES ; do
     . /tmp/net.$iface.up
 done
 
-[ -e /tmp/net.$netif.gw ]          && . /tmp/net.$netif.gw
+# Wait a bit until we continue to give the interface(s) time to
+# configure
+sleep 1
+
+[ -e /tmp/net.$netif.gw ]          && . /tmp/net.$netif.gw 
 [ -e /tmp/net.$netif.hostname ]    && . /tmp/net.$netif.hostname
 [ -e /tmp/net.$netif.resolv.conf ] && cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
