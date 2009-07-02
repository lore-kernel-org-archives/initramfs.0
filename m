From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: initqueue
Date: Thu, 2 Jul 2009 14:39:46 +0200
Message-ID: <4A4CAA92.9000401@bfh.ch>
References: <4A4C87DF.10904@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4C87DF.10904-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald Hoyer wrote:
> To move all "big" jobs out of the udev event handling, I introduce the 
> "initqueue". This prevents the job from being killed by udev timeouts.
> 
> See
> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut;a=commit;h=eab677a2164bccb3990487dc5ef4549b30cb1055 
> 
> 
> for the patch.
> 
> Basically inside a udev event, you don't do
> 
> RUN+="/sbin/ifup $env{INTERFACE}"
> 
> you now queue this in the initqueue with:
> 
> RUN+="/sbin/initqueue /sbin/ifup $env{INTERFACE}"
> 
> Inside init all jobs are worked on in serial order by the do_initqueue() 
> function.
> 
> Now we have no more side effects due to the parallel nature of udev and 
> still be fast, in case udev supports "udevadm settle --exit-if-exists="

Please don't do that. That way we actually loose the benefit of doing as
much in parallel as possible. Instead please consider the patch below.
I've been fiddling with this for a few weeks now. It basically replaces
the current "wait-for-root" loop with a loop that queries the udev-queue
and only exits if either root is available or all udev events have been
processed.

It works, except if a udev event takes longer than the default 180s as is
the case with an unpatches cryptsetup and/or if we do user-interaction
from within udev which we shouldn't do anyway.

Thank you,
Philippe

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 27c4dad..e14dc20 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -46,6 +46,11 @@ mkdir /dev/shm
 mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts >/dev/null 2>&1
 
+# Set version specific udevadm options
+UDEVVERSION=$(udevadm --version)
+UDEVADMOPTS=""
+[ $UDEVVERSION -ge 143 ] && UDEVADMOPTS="--exit-if-exists=$NEWROOT/proc"
+
 # run scriptlets to parse the command line
 getarg 'rdbreak=cmdline' && emergency_shell
 source_all cmdline
@@ -76,7 +81,7 @@ source_all pre-trigger
 
 # then the rest
 udevadm trigger $udevtriggeropts  >/dev/null 2>&1
-udevadm settle --timeout=30 >/dev/null 2>&1
+udevadm settle --timeout=30 $UDEVADMOPTS >/dev/null 2>&1
 
 # pre-mount happens before we try to mount the root filesystem,
 # and happens once.
@@ -86,18 +91,23 @@ getarg 'rdbreak=mount' && emergency_shell
 
 # mount scripts actually try to mount the root filesystem, and may
 # be sourced any number of times. As soon as one suceeds, no more are sourced.
-i=0
-while :; do
-    [ -d "$NEWROOT/proc" ] && break;
-
+while [ ! -d "$NEWROOT/proc" ] ; do
     for f in /mount/*.sh; do
        [ -x "$f" ] && . "$f";
        [ "$ROOTFS_MOUNTED" ] && break;
     done
 
-    sleep 0.5
-    i=$(($i+1))
-    { flock -s 9 ; [ $i -gt 20 ] && emergency_shell; } 9>/.console_lock
+    # If the queue was empty and mount scripts failed as well, bail out
+    [ -n "$EMPTYQUEUE" ] && break;
+
+    # Give udev events some time before we try anything. If the queue
+    # is empty, give mount-scripts another chance to get the root
+    udevadm settle --timeout 5 $UDEVADMOPTS && EMPTYQUEUE="1"
+done
+
+# udev queue is empty, no root? Let the user figure this out
+while [ ! -d "$NEWROOT/proc" ] ; do
+    { flock -s 9 ; emergency_shell; } 9>/.console_lock
 done
 
 # pre pivot scripts are sourced just before we switch over to the new root.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
