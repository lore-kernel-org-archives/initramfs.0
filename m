From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch 2/6 v2] Add function linkup
Date: Fri, 30 Nov 2012 11:20:23 +0800
Message-ID: <20121130032700.154858330@redhat.com>
References: <20121130032021.140175185@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=patch2
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

set link up usually include two steps, ip link set <dev> up and
wait_for_if_up <dev>. Now do these two steps in one function linkup.
Later patch will add other code into it.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/net-lib.sh |    5 +++++
 1 file changed, 5 insertions(+)

--- dracut.orig/modules.d/40network/net-lib.sh
+++ dracut/modules.d/40network/net-lib.sh
@@ -338,3 +338,8 @@ wait_for_route_ok() {
     done
     return 1
 }
+
+linkup() {
+    ip link set $1 up 2>/dev/null && wait_for_if_up $1 2>/dev/null
+}
+

