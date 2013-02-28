From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] shutdown: move scripts instead of deleting them
Date: Thu, 28 Feb 2013 16:57:26 -0500
Message-ID: <1362088646-25881-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Unlike every other rd.break=XXX breakpoint, shutdown happens *after* the
shutdown scripts are run. Furthermore, shutdown deletes the scripts
after they run.

This makes debugging tricky if you have something that's supposed to
dynamically generate shutdown scripts - they've all been deleted by the
time the 'shutdown' shell starts.

So just for the sake of clarity, move finished scripts out of the way
to $hookdir/shutdown/done rather than deleting them outright.
---
 modules.d/99shutdown/shutdown.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/modules.d/99shutdown/shutdown.sh b/modules.d/99shutdown/shutdown.sh
index 202ecb1..6f843f6 100755
--- a/modules.d/99shutdown/shutdown.sh
+++ b/modules.d/99shutdown/shutdown.sh
@@ -84,13 +84,14 @@ _check_shutdown() {
         [ -e "$__f" ] || continue
         ( . "$__f" $1 )
         if [ $? -eq 0 ]; then
-            rm -f $__f
+            mv -f $__f $hookdir/shutdown/done
             __s=0
         fi
     done
     return $__s
 }
 
+mkdir -p $hookdir/shutdown/done
 while _check_shutdown; do
 :
 done
-- 
1.8.1.2
