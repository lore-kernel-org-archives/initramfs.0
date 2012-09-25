From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH cleanups] livenet: simplify writing net.ifaces
Date: Tue, 25 Sep 2012 12:10:58 -0400
Message-ID: <1348589458-13212-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

commit db2b12f removed the rd.neednet argument and uses /tmp/net.ifaces
instead. This means we don't need to mess with CMDLINE.
---
 modules.d/90livenet/parse-livenet.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/modules.d/90livenet/parse-livenet.sh b/modules.d/90livenet/parse-livenet.sh
index 365eca1..0e61870 100755
--- a/modules.d/90livenet/parse-livenet.sh
+++ b/modules.d/90livenet/parse-livenet.sh
@@ -9,10 +9,7 @@
 updates=$(getarg live.updates=)
 if [ -n "$updates" ]; then
     # make sure network comes up even if we're doing a local live device
-    if [ -z "$netroot" ]; then
-	echo > /tmp/net.ifaces
-	unset CMDLINE
-    fi
+    [ -z "$netroot" ] && >> /tmp/net.ifaces
     echo "$updates" > /tmp/liveupdates.info
     echo '[ -e /tmp/liveupdates.done ]' > \
         $hookdir/initqueue/finished/liveupdates.sh
-- 
1.7.11.4
