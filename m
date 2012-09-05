From: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] network: fix ip=ibft regression
Date: Wed,  5 Sep 2012 16:54:04 -0700
Message-ID: <1346889244-17926-1-git-send-email-cleech@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

It looks like ip=ibft has been busted since
  25aa3c5 network: refactor stuff from netroot/parse-ip-opts to net-lib
which moved ibft parsing code out to the ibft_to_cmdline function.

The use of ifname_mac was partially replaced by a local mac, but not
completely, causing ibft_to_cmdline to abort without generating network
configuration options.

Signed-off-by: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/net-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index 641b21e..10b630e 100644
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -145,8 +145,8 @@ ibft_to_cmdline() {
         for iface in /sys/firmware/ibft/ethernet*; do
             [ -e ${iface}/mac ] || continue
             mac=$(read a < ${iface}/mac; echo $a)
-            [ -z "$ifname_mac" ] && continue
-            dev=$(set_ifname ibft $ifname_mac)
+            [ -z "$mac" ] && continue
+            dev=$(set_ifname ibft $mac)
             dhcp=$(read a < ${iface}/dhcp; echo $a)
             if [ -n "$dhcp" ]; then
                 echo "ip=$dev:dhcp"
-- 
1.7.11.4
