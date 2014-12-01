From: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] 40network: Fix the syntax to correct the judgment sentence
Date: Mon,  1 Dec 2014 12:37:06 +0800
Message-ID: <1417408626-28037-1-git-send-email-mhuang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

In the judgment sentence, it will print the following warning message,
becasuse of lacking the blank on the left of ']'.

/lib/net-lib.sh: line 110: [: missing `]'

Signed-off-by: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/40network/net-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index 48e7014..d9c5a1d 100755
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -105,7 +105,7 @@ setup_net() {
     # add static route
     for _p in $(getargs rd.route); do
         route_to_var "$_p" || continue
-        [ -n "$route_dev" ] && [ "$route_dev" != "$netif"] && continue
+        [ -n "$route_dev" ] && [ "$route_dev" != "$netif" ] && continue
         ip route add "$route_mask" ${route_gw:+via "$route_gw"} ${route_dev:+dev "$route_dev"}
         if strstr ":" "$route_mask"; then
             printf -- "%s\n" "$route_mask ${route_gw:+via $route_gw} ${route_dev:+dev $route_dev}" \
-- 
1.8.3.1
