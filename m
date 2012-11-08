From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch RFC 6/6] Wait for interface up at the early stage
Date: Thu, 08 Nov 2012 11:40:24 +0800
Message-ID: <20121108034317.844374819@redhat.com>
References: <20121108034018.789330224@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=network-wait-interface-up-at-early-stage.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

In case long delay of network driver initqueue will exit before net dev is
ready. We have no chance to setup it then.
For dhcp, when we finish the setup there will be a setup_net_<dev>.ok. Doing
same for static ip case. Also add a check to initqueue when we generate udev
rules to ensure it's early enough.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/ifup.sh         |    1 +
 modules.d/40network/net-genrules.sh |    3 +++
 2 files changed, 4 insertions(+)

--- dracut.orig/modules.d/40network/net-genrules.sh
+++ dracut/modules.d/40network/net-genrules.sh
@@ -49,14 +49,17 @@ fi
     if [ -n "$BOOTIF" ] ; then
         BOOTIF=$(fix_bootif "$BOOTIF")
         printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="%s"\n' "$BOOTIF" "/sbin/initqueue --onetime $ifup"
+        echo "[ -f /tmp/setup_net_${BOOTIF}.ok ]" >$hookdir/initqueue/finished/wait-${BOOTIF}.sh
 
     # If we have to handle multiple interfaces, handle only them.
     elif [ -n "$IFACES" ] ; then
         for iface in $IFACES ; do
             printf 'SUBSYSTEM=="net", ENV{INTERFACE}=="%s", RUN+="%s"\n' "$iface" "/sbin/initqueue --onetime $ifup"
+            echo "[ -f /tmp/setup_net_${iface}.ok ]" >$hookdir/initqueue/finished/wait-$iface.sh
         done
 
     # Default: We don't know the interface to use, handle all
+    # Fixme: waiting for the interface as well.
     else
         printf 'SUBSYSTEM=="net", RUN+="%s"\n' "/sbin/initqueue --onetime $ifup" > /etc/udev/rules.d/91-default-net.rules
     fi
--- dracut.orig/modules.d/40network/ifup.sh
+++ dracut/modules.d/40network/ifup.sh
@@ -109,6 +109,7 @@ do_static() {
     [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
     [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
 
+    > /tmp/setup_net_${netif}.ok
     return 0
 }
 
