From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 6/6 v3] Wait for interface up at the early stage
Date: Wed, 12 Dec 2012 12:23:26 +0800
Message-ID: <20121212042614.570389277@redhat.com>
References: <20121212042320.618863612@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=patch6
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

In case long delay of network driver initqueue will exit before net dev is
ready. We have no chance to setup it then.
For dhcp, when we finish the setup there will be a setup_net_<dev>.ok. Doing
same for static ip case. Also add a check to initqueue when we generate udev
rules to ensure it's early enough.

[v1->v2]: only wait for bootdev or it's possible to cause boot fail for 
waiting for non-bootdev. For example bond0->eth0, set bond0 as bootdev and
dhcp, we only need to wait bond0 setup ok.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/ifup.sh         |    1 +
 modules.d/40network/net-genrules.sh |    9 +++++++++
 2 files changed, 10 insertions(+)

--- dracut.orig/modules.d/40network/net-genrules.sh
+++ dracut/modules.d/40network/net-genrules.sh
@@ -43,6 +43,10 @@ fi
         [ -e /tmp/net.ifaces ] && read IFACES < /tmp/net.ifaces
     fi
 
+    if [ -e /tmp/net.bootdev ]; then
+        bootdev=$(cat /tmp/net.bootdev)
+    fi
+
     ifup='/sbin/ifup $env{INTERFACE}'
     [ -z "$netroot" ] && ifup="$ifup -m"
 
@@ -51,14 +55,19 @@ fi
     if [ -n "$BOOTIF" ] ; then
         BOOTIF=$(fix_bootif "$BOOTIF")
         printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="%s"\n' "$BOOTIF" "/sbin/initqueue --onetime $ifup"
+        echo "[ -f /tmp/setup_net_${BOOTIF}.ok ]" >$hookdir/initqueue/finished/wait-${BOOTIF}.sh
 
     # If we have to handle multiple interfaces, handle only them.
     elif [ -n "$IFACES" ] ; then
         for iface in $IFACES ; do
             printf 'SUBSYSTEM=="net", ENV{INTERFACE}=="%s", RUN+="%s"\n' "$iface" "/sbin/initqueue --onetime $ifup"
+            if [ "$bootdev" = "$iface" ]; then
+                echo "[ -f /tmp/setup_net_${iface}.ok ]" >$hookdir/initqueue/finished/wait-$iface.sh
+            fi
         done
 
     # Default: We don't know the interface to use, handle all
+    # Fixme: waiting for the interface as well.
     else
         # if you change the name of "91-default-net.rules", also change modules.d/80cms/cmssetup.sh
         printf 'SUBSYSTEM=="net", RUN+="%s"\n' "/sbin/initqueue --onetime $ifup" > /etc/udev/rules.d/91-default-net.rules
--- dracut.orig/modules.d/40network/ifup.sh
+++ dracut/modules.d/40network/ifup.sh
@@ -109,6 +109,7 @@ do_static() {
     [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
     [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
 
+    > /tmp/setup_net_${netif}.ok
     return 0
 }
 
