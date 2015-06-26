From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 3/8] Reset IFS variable
Date: Fri, 26 Jun 2015 16:55:52 +0200
Message-ID: <1435330557-17685-4-git-send-email-trenn@suse.de>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435330557-17685-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Setting and unsetting the IFS variable is tricky. To be on the
safe side we should always reset the IFS variable to its original
value after parsing.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95fcoe/parse-fcoe.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/modules.d/95fcoe/parse-fcoe.sh b/modules.d/95fcoe/parse-fcoe.sh
index b66fa3e..a214007 100755
--- a/modules.d/95fcoe/parse-fcoe.sh
+++ b/modules.d/95fcoe/parse-fcoe.sh
@@ -26,8 +26,10 @@ initqueue --onetime modprobe -b -q bnx2fc
 udevadm settle --timeout=30
 
 parse_fcoe_opts() {
+    local OLDIFS="$IFS"
     local IFS=:
     set $fcoe
+    IFS="$OLDIFS"
 
     case $# in
         2)
-- 
2.1.4
