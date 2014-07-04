From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v3] network: add static route support
Date: Fri,  4 Jul 2014 11:01:21 +0800
Message-ID: <1404442881-5654-1-git-send-email-bhe@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Now in dracut only default gateway is added. However as below you can
see, if a service target is in different subnet with default gateway,
a subnet route to that service target has to be added into dracut.

sh> ip route show
default via 192.168.122.1 dev eth0  proto static  metric 1024
192.168.200.0/24 via 192.168.100.222 dev ens10  proto static  metric 1

Now add a cmdline parameter rd.route="" and the related operation to
parse it. User can add static route by specify it in cmdline like. For
now the PREFIX/nexthop/output_device is enough to route.

rd.route="192.168.200.0/24_via_192.168.100.222_dev_ens10"
---
 dracut.cmdline.7.asc           | 8 ++++++++
 modules.d/40network/net-lib.sh | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
index fef13b3..e2ab8a7 100644
--- a/dracut.cmdline.7.asc
+++ b/dracut.cmdline.7.asc
@@ -536,6 +536,14 @@ interface name. Better name it "bootnet" or "bluesocket".
     list of physical (ethernet) interfaces. Bridge without parameters assumes
     bridge=br0:eth0
 
+**rd.route=**__<route-options>__::
+    Add static route to route table with route options which are separated by
+    underscore. Among them some are necessary, such as the destination prefix
+    of the route, the address of the nexthop route, the output device name.
+    It's like
+    rd.route=192.168.200.0/24_via_192.168.100.222_dev_ens10
+
+
 NFS
 ~~~
 **root=**\[_<server-ip>_:]__<root-dir>__[:__<nfs-options>__]::
diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index a82f1a8..b428abb 100755
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -103,6 +103,15 @@ setup_net() {
     [ -e /tmp/net.$netif.resolv.conf ] && \
         cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
 
+    # add static route
+    local _p _r
+    for _p in $(getargs rd.route=); do
+        if strstr "$_p" "$netif"; then
+            _r=${_p//'_'/' '}
+            ip route add $_r
+        fi
+    done
+
     # Handle STP Timeout: arping the default gateway.
     # (or the root server, if a) it's local or b) there's no gateway.)
     # Note: This assumes that if no router is present the
-- 
1.9.0
