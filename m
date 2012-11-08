From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch RFC 5/6] Get ifaces for udev rule use
Date: Thu, 08 Nov 2012 11:40:23 +0800
Message-ID: <20121108034317.735680044@redhat.com>
References: <20121108034018.789330224@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=network-get-ifaces-for-udev-rule-use.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

In case without BOOTIF, but /tmp/ifaces are already created.
net-genrule.sh will fall to bring up all net interfaces.

Fix by reading from /tmp/ifaces before generating rules instead.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/net-genrules.sh |    2 ++
 1 file changed, 2 insertions(+)

--- dracut.orig/modules.d/40network/net-genrules.sh
+++ dracut/modules.d/40network/net-genrules.sh
@@ -19,6 +19,8 @@ if [ -z "$netroot" ] && [ ! -e "/tmp/net
     return
 fi
 
+[ -e /tmp/net.ifaces ] && read IFACES < /tmp/net.ifaces
+
 # Write udev rules
 {
     # bridge: attempt only the defined interface
