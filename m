From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 27/33] 99base: Increase initqueue timeout in non systemd case
Date: Thu, 20 Nov 2014 15:57:02 +0100
Message-ID: <1416495428-36978-28-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

In case of systemd is used the timeout already is set to 180s, compare
with file: modules.d/98systemd/dracut-initqueue.sh

Do the same if systemd is not used, e.g. in kdump case.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/99base/init.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index 3afe6d5..76b1247 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -165,7 +165,7 @@ make_trace_mem "hook initqueue" '1:shortmem' '2+:mem' '3+:slab'
 getarg 'rd.break=initqueue' -d 'rdbreak=initqueue' && emergency_shell -n initqueue "Break before initqueue"
 
 RDRETRY=$(getarg rd.retry -d 'rd_retry=')
-RDRETRY=${RDRETRY:-30}
+RDRETRY=${RDRETRY:-180}
 RDRETRY=$(($RDRETRY*2))
 export RDRETRY
 main_loop=0
-- 
1.8.5.2
