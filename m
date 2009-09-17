From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 4/8] Add simple STP timeout handler
Date: Thu, 17 Sep 2009 17:16:45 +0200
Message-ID: <1253200609-31629-5-git-send-email-philippe.seewer@bfh.ch>
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

This patch adds STP timeout error handling with arping. It's rather
simple since it only cares about the primary interface and blindly
assumes that if no gateway is available the root server is on the
same subnet.
---
 modules.d/40network/check   |    2 +-
 modules.d/40network/install |    2 +-
 modules.d/40network/netroot |   23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/modules.d/40network/check b/modules.d/40network/check
index cf06c74..e5cd87e 100755
--- a/modules.d/40network/check
+++ b/modules.d/40network/check
@@ -2,7 +2,7 @@
 
 . $dracutfunctions
 
-for program in ip; do 
+for program in ip arping; do 
   which $program >/dev/null 2>&1
   if [ $? -ne 0 ]; then
     dwarning "Could not find program \"$program\" required by network." 
diff --git a/modules.d/40network/install b/modules.d/40network/install
index a711cb5..c440cc3 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -1,5 +1,5 @@
 #!/bin/bash
-dracut_install ip dhclient brctl
+dracut_install ip dhclient brctl arping
 inst "$moddir/ifup" "/sbin/ifup"
 inst "$moddir/netroot" "/sbin/netroot"
 inst "$moddir/dhclient-script" "/sbin/dhclient-script"
diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 3b343af..3deb031 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -92,6 +92,29 @@ done
 [ -e /tmp/net.$netif.hostname ]    && . /tmp/net.$netif.hostname
 [ -e /tmp/resolv.conf ] && cp -f /tmp/resolv.conf /etc/resolv.conf
 
+# Load interface options
+[ -e /tmp/net.$netif.override ] && . /tmp/net.$netif.override
+[ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
+
+# Handle STP Timeout: arping default router or if not available the
+# root server. Note: This assumes that if no router is present the
+# root server is on the same subnet.
+#
+# TODO There's some netroot variants that don't (yet) have their 
+# server-ip netroot
+[ -n "$new_routers" ] && dest=${new_routers%%,*}
+[ -n "$gw" ] && dest=$gw
+if [ -z "$dest" ] ; then
+    dummy=${netroot#*:}
+    dummy=${dummy%%:*}
+    case "$dummy" in
+       [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*) dest=$dummy;;
+    esac
+fi
+if [ -n "$dest" ] && ! arping -q -f -w 60 -I $netif $dest ; then
+    die "Resolving $dest via ARP on $netif failed"
+fi
+
 # Source netroot hooks before we start the handler
 source_all netroot
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
