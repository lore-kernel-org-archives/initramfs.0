From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/4] 40network: Fix race condition when wait for networks
Date: Mon, 23 Mar 2015 17:12:16 +0100
Message-ID: <1427127138-12932-3-git-send-email-trenn@suse.de>
References: <1427127138-12932-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427127138-12932-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Pawel Wieczorkiewicz <pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org>, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Pawel Wieczorkiewicz <pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org>

If no network related params are specific, but rd.neednet=1 is set,
the default initqueue action is to wait until one of the network
interfaces is marked as setup properly.

This also help with initqueue's race condition when the network interface
shows upd late

References: bnc#866771

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/40network/net-genrules.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 77e47b5..2c955b7 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -95,7 +95,10 @@ command -v fix_bootif >/dev/null || . /lib/net-lib.sh
     else
         cond='ACTION=="add", SUBSYSTEM=="net"'
         # if you change the name of "91-default-net.rules", also change modules.d/80cms/cmssetup.sh
-        echo "$cond, $runcmd" > /etc/udev/rules.d/91-default-net.rules
+        if [ "$NEEDNET" = "1" ]; then
+            echo "$cond, $runcmd" > /etc/udev/rules.d/91-default-net.rules
+            echo "[ -f /tmp/net.*.did-setup ]" >$hookdir/initqueue/finished/wait-network.sh
+        fi
     fi
 
 # if you change the name of "90-net.rules", also change modules.d/80cms/cmssetup.sh
-- 
2.1.4
