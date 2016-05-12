From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 03/12] 40network: Only enable network interfaces if explicitly requested
Date: Thu, 12 May 2016 20:03:27 +0200
Message-ID: <1463076216-410-4-git-send-email-trenn@suse.com>
References: <1463076216-410-1-git-send-email-trenn@suse.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463076216-410-1-git-send-email-trenn-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.blume-IBi9RG/b67k@public.gmane.org, pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org, hare-IBi9RG/b67k@public.gmane.org, fvogt-IBi9RG/b67k@public.gmane.org, trenn-IBi9RG/b67k@public.gmane.org

From: Pawel Wieczorkiewicz <pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org>

Currently all available network interfaces are started whenever
40network is pulled in. This causes massive delays during bootup.
This patch modifies the behaviour to start interfaces only if
rd.neednet is specified.

References: bnc#879038

Signed-off-by: Pawel Wieczorkiewicz <pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/40network/net-genrules.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index c964531..acaee7c 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -104,8 +104,8 @@ command -v fix_bootif >/dev/null || . /lib/net-lib.sh
     else
         cond='ACTION=="add", SUBSYSTEM=="net"'
         # if you change the name of "91-default-net.rules", also change modules.d/80cms/cmssetup.sh
-        echo "$cond, $runcmd" > /etc/udev/rules.d/91-default-net.rules
         if [ "$NEEDNET" = "1" ]; then
+            echo "$cond, $runcmd" > /etc/udev/rules.d/91-default-net.rules
             echo "[ -f /tmp/net.*.did-setup ]" >$hookdir/initqueue/finished/wait-network.sh
         fi
     fi
-- 
2.1.4
