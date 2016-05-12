From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 01/12] 40network: Fix race condition when wait for networks
Date: Thu, 12 May 2016 20:03:25 +0200
Message-ID: <1463076216-410-2-git-send-email-trenn@suse.com>
References: <1463076216-410-1-git-send-email-trenn@suse.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463076216-410-1-git-send-email-trenn-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.blume-IBi9RG/b67k@public.gmane.org, pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org, hare-IBi9RG/b67k@public.gmane.org, fvogt-IBi9RG/b67k@public.gmane.org, trenn-IBi9RG/b67k@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Pawel Wieczorkiewicz <pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org>

If no network related params are specific, but rd.neednet=1 is set,
the default initqueue action is to wait until one of the network
interfaces is marked as setup properly.

This also help with initqueue's race condition when the network interface
shows upd late

References: bnc#866771

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/40network/net-genrules.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 5df50bd..c964531 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -105,6 +105,9 @@ command -v fix_bootif >/dev/null || . /lib/net-lib.sh
         cond='ACTION=="add", SUBSYSTEM=="net"'
         # if you change the name of "91-default-net.rules", also change modules.d/80cms/cmssetup.sh
         echo "$cond, $runcmd" > /etc/udev/rules.d/91-default-net.rules
+        if [ "$NEEDNET" = "1" ]; then
+            echo "[ -f /tmp/net.*.did-setup ]" >$hookdir/initqueue/finished/wait-network.sh
+        fi
     fi
 
 # if you change the name of "90-net.rules", also change modules.d/80cms/cmssetup.sh
-- 
2.1.4
