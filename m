From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 06/12] network/iscsi: Skip invalid ibft dhcp address
Date: Thu, 12 May 2016 20:03:30 +0200
Message-ID: <1463076216-410-7-git-send-email-trenn@suse.com>
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

From: Thomas Blume <thomas.blume-IBi9RG/b67k@public.gmane.org>

bsc#953361

CC: Hannes Reinecke <hare-IBi9RG/b67k@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/40network/net-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index 322d5b5..61aa2a9 100755
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -289,7 +289,7 @@ ibft_to_cmdline() {
                         ;;
                 esac
             fi
-            if [ -n "$dhcp" ] || [ "$origin" -eq 3 ]; then
+            if [ -n "$dhcp" -a "$dhcp" != "0.0.0.0" ] || [ -z "$dhcp" -a "$origin" -eq 3 ]; then
                 if [ "$family" = "ipv6" ] ; then
                     echo "ip=$dev:dhcp6"
                 else
-- 
2.1.4
