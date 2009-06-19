From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Move kill-dhclient to netroot
Date: Fri, 19 Jun 2009 16:22:42 +0200
Message-ID: <4A3B9F32.2010805@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

We need to kill dhclient before calling switch_root. But doing it in
pre-pivot slows down netroot if we are trying do acquire dhcp addresses
from multiple interfaces.

If, for example, we have two interfaces and the first one succeeds
in acquiring an address and mounts, the second interface might still
be trying to acquire an address. Which means that udevadm settle is
waiting for the timeout to occur.

Killing all running dhclients in netroot after a successful mount 
solves this.


diff --git a/modules.d/40network/install b/modules.d/40network/install
index 0b76cbd..3014d18 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -18,7 +18,6 @@ instmods ecb arc4
 inst_hook pre-udev 60 "$moddir/net-genrules.sh"
 inst_hook cmdline 91 "$moddir/dhcp-root.sh"
 inst_hook cmdline 99 "$moddir/parse-ip-opts.sh"
-inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
 
 # TODO ifcfg config style is redhat specific, this should probably
 # go into its own module at one time
diff --git a/modules.d/40network/kill-dhclient.sh b/modules.d/40network/kill-dhclient.sh
deleted file mode 100755
index 54b3344..0000000
--- a/modules.d/40network/kill-dhclient.sh
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-for f in /tmp/dhclient.*.pid; do
-    [ -e $f ] || continue
-    read PID < $f;
-    kill $PID;
-done
diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 81b99f7..2356b9e 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -108,6 +108,10 @@ if $handler $netif $netroot $NEWROOT; then
        [ -f /tmp/dhclient.$iface.dhcpopts ] && cp /tmp/dhclient.$iface.dhcpopts /tmp/net.$ifa
     done
 
+    # We have root, so we don't need any running dhclients anymore. 
+    # This frees the udev event queue as well
+    [ -n "$(pidof dhclient)" ] && kill $(pidof dhclient)
+
     # Save used netif for later use
     [ ! -f /tmp/net.ifaces ] && echo $netif > /tmp/net.ifaces
 else 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
