From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/4] systemd/dracut-iniqueue - continue waiting if any
 timeout script makes progress
Date: Thu, 26 Mar 2015 15:41:47 +1100
Message-ID: <20150326044146.10121.82753.stgit@notabene.brown>
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

A number of timeout scripts can be registered.  If any one of them
makes progress - e.g. assembles a degraded md array - then
the main loop should wait a bit longer rather than pressing forward.

This is particularly important is resume-from-hibernate requires a
degraded md array.  Both the script to forcibly assemble the md array
and the script to abort hibernation if the device doesn't appear
are 'timeout' scripts.  There needs to be a reasonable delay between
these running.

So: if any script has indicated that progress was made, break of out
the loop and go back to normal waiting.

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/98dracut-systemd/dracut-initqueue.sh |    1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/98dracut-systemd/dracut-initqueue.sh b/modules.d/98dracut-systemd/dracut-initqueue.sh
index 88cd1e056ed7..af9cec2c5b8c 100755
--- a/modules.d/98dracut-systemd/dracut-initqueue.sh
+++ b/modules.d/98dracut-systemd/dracut-initqueue.sh
@@ -60,6 +60,7 @@ while :; do
             job=$job . $job
             udevadm settle --timeout=0 >/dev/null 2>&1 || main_loop=0
             [ -f $hookdir/initqueue/work ] && main_loop=0
+            [ $main_loop -eq 0 ] && break
         done
     fi
 

