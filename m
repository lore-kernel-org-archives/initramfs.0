From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/4] mdraid/mdraid_start.sh: tell mainloop if we make
 progress.
Date: Thu, 26 Mar 2015 15:41:46 +1100
Message-ID: <20150326044145.10121.41272.stgit@notabene.brown>
References: <20150326043938.10121.34223.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150326043938.10121.34223.stgit-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

mdraid_start is a number of scripts which run after a timeout.
If it makes progress, it should tell the main loop so that it
knows that it is worth waiting a bit longer.

So in that case, create the initqueue/work file which the main loop
checks for.

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90mdraid/mdraid_start.sh |    1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/90mdraid/mdraid_start.sh b/modules.d/90mdraid/mdraid_start.sh
index 761e64f312d3..400ab5dc46c7 100755
--- a/modules.d/90mdraid/mdraid_start.sh
+++ b/modules.d/90mdraid/mdraid_start.sh
@@ -27,6 +27,7 @@ _md_force_run() {
 
         _path_d="${_path_s%/*}/degraded"
         [ ! -r "$_path_d" ] && continue
+        > $hookdir/initqueue/work
     done
 }
 

