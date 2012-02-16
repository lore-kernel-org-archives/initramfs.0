From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] add function wait_for_route_ok
Date: Thu, 16 Feb 2012 09:36:29 +0800
Message-ID: <20120216013629.GA2833@darkstar.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Manually setuping nic through udev is not always done when
we want network access. Here add a function wait_for_route_ok to
wait and make sure the network is accesible

[v1 -> v2]:
Harald: don't use bash syntax
Add check for [ -n "$li" ] because `ip route show` will show nothing probably

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 6b70adf..afd366e 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -392,6 +392,17 @@ wait_for_if_up() {
     return 1
 }
 
+wait_for_route_ok() {
+    local cnt=0
+    while [ $cnt -lt 200 ]; do
+        li=$(ip route show)
+        [ -n "$li" ] && [ -z "${li##*$1*}" ] && return 0
+        sleep 0.1
+        cnt=$(($cnt+1))
+    done
+    return 1
+}
+
 # root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
 # root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
 nfsroot_to_var() {
-- 
1.7.7.5
