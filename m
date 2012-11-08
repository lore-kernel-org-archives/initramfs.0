From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch RFC 4/6] Wait for link ready before use the interface
Date: Thu, 08 Nov 2012 11:40:22 +0800
Message-ID: <20121108034317.594728251@redhat.com>
References: <20121108034018.789330224@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=network-wait-for-link-ready-before-use.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Some network driver will take long time to initialize. We have an example
in a HP machine which take about one minute for this. The callback such as
"ip link set <dev> up" will fail, afterwards setup for network will also
fail.

Fix this by add a new function wait_for_if_link, wait the link ready before
use it.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/net-lib.sh |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- dracut.orig/modules.d/40network/net-lib.sh
+++ dracut/modules.d/40network/net-lib.sh
@@ -316,6 +316,19 @@ parse_ifname_opts() {
 
 }
 
+# some network driver need long time to initialize, wait before it's ready.
+wait_for_if_link() {
+    local cnt=0
+    local li
+    while [ $cnt -lt 600 ]; do
+        li=$(ip -o link show dev $1 2>/dev/null)
+        [ -n "$li" ] && return 0
+        sleep 0.1
+        cnt=$(($cnt+1))
+    done
+    return 1
+}
+
 wait_for_if_up() {
     local cnt=0
     local li
@@ -340,6 +353,8 @@ wait_for_route_ok() {
 }
 
 linkup() {
-    ip link set $1 up 2>/dev/null && wait_for_if_up $1 2>/dev/null
+    wait_for_if_link $1 2>/dev/null\
+     && ip link set $1 up 2>/dev/null\
+     && wait_for_if_up $1 2>/dev/null
 }
 
