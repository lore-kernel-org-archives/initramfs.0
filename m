From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/5] run setup_net at start of initqueue/online hook
Date: Thu,  5 Apr 2012 13:01:36 -0400
Message-ID: <1333645299-16837-3-git-send-email-wwoods@redhat.com>
References: <1333645299-16837-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1333645299-16837-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This makes sure the network is active and ready to use during the
initqueue/online hook.

It also makes it so you can run setup_net repeatedly without causing
error messages.
---
 modules.d/40network/net-genrules.sh |    3 +++
 modules.d/40network/net-lib.sh      |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 84fd3ac..b3d5584 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -53,5 +53,8 @@ fix_bootif() {
 
     # Run the "online" hook
     printf 'SUBSYSTEM=="net", ACTION=="online", RUN+="/sbin/initqueue --onetime --env netif=$env{INTERFACE} source_hook initqueue/online"\n'
+    # And make sure we run setup_net at the start of the hook
+    echo '. /lib/net-lib.sh; setup_net $netif' > \
+            $hookdir/initqueue/online/05-setup_net.sh
 
 } > /etc/udev/rules.d/60-net.rules
diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index 467c79f..a7abe81 100644
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -59,12 +59,14 @@ ifdown() {
     ip link set $netif down
     ip addr flush dev $netif
     echo "#empty" > /etc/resolv.conf
+    rm -f /tmp/net.$netif.did-setup
     # TODO: send "offline" uevent?
 }
 
 setup_net() {
     local netif="$1" f="" gw_ip="" netroot_ip="" iface="" IFACES=""
     [ -e /tmp/net.$netif.up ] || return 1
+    [ -e /tmp/net.$netif.did-setup ] && return
     [ -e "/tmp/net.ifaces" ] && read IFACES < /tmp/net.ifaces
     [ -z "$IFACES" ] && IFACES="$netif"
     for iface in $IFACES ; do
@@ -100,6 +102,7 @@ setup_net() {
     if [ -n "$dest" ] && ! arping -q -f -w 60 -I $netif $dest ; then
         info "Resolving $dest via ARP on $netif failed"
     fi
+    > /tmp/net.$netif.did-setup
 }
 
 set_ifname() {
-- 
1.7.7.6
