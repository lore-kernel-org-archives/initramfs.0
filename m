From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 21/42] 99base: Increase initqueue timeout in non systemd case
Date: Thu, 11 Dec 2014 15:46:12 +0100
Message-ID: <1418309193-11208-22-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

In case of systemd is used the timeout already is set to 180s, compare
with file: modules.d/98systemd/dracut-initqueue.sh

Do the same if systemd is not used, e.g. in kdump case.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/99base/init.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
index 7fcea4a..918dea5 100755
--- a/modules.d/99base/init.sh
+++ b/modules.d/99base/init.sh
@@ -166,7 +166,7 @@ make_trace_mem "hook initqueue" '1:shortmem' '2+:mem' '3+:slab'
 getarg 'rd.break=initqueue' -d 'rdbreak=initqueue' && emergency_shell -n initqueue "Break before initqueue"
 
 RDRETRY=$(getarg rd.retry -d 'rd_retry=')
-RDRETRY=${RDRETRY:-30}
+RDRETRY=${RDRETRY:-180}
 RDRETRY=$(($RDRETRY*2))
 export RDRETRY
 main_loop=0
-- 
1.8.5.2
