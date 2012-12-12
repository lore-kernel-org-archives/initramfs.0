From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 5/6 v3] Get ifaces for udev rule use
Date: Wed, 12 Dec 2012 12:23:25 +0800
Message-ID: <20121212042614.248428515@redhat.com>
References: <20121212042320.618863612@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=patch5
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

In case BOOTIF is not set and IFACES are not set in bonding/vlan/bridge code,
net-genrule.sh will fall to bring up all net interfaces.

Here add a failsafe option to read IFACES from /tmp/net.ifaces

[v1->v2]: move IFACES reading from net.ifaces after bonding/vlan/bridge info
code chunks.
[v2->v3]: [ -n "$IFACES" ] should be  [ -z "$IFACES" ]

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/net-genrules.sh |    4 ++++
 1 file changed, 4 insertions(+)

--- dracut.orig/modules.d/40network/net-genrules.sh
+++ dracut/modules.d/40network/net-genrules.sh
@@ -39,6 +39,10 @@ fi
         IFACES+=" $phydevice"
     fi
 
+    if [ -z "$IFACES" ]; then
+        [ -e /tmp/net.ifaces ] && read IFACES < /tmp/net.ifaces
+    fi
+
     ifup='/sbin/ifup $env{INTERFACE}'
     [ -z "$netroot" ] && ifup="$ifup -m"
 
