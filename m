From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [PATCH] dracut: make initial devices outside of initramfs
Date: Mon, 25 May 2009 22:42:18 -0400
Message-ID: <1243305738.3584.40.camel@obelisk.thedillows.org>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0905231331400.2058-bvJ793YqIODNUDpmljszgg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Thienemann <andreas-XTk7JcP0uDNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

dash gets upset when it cannot open /dev/tty, and we lose stderr. Even
if we make /dev/tty once we're in the initramfs, it will still be too
late for the inital dash shell running the init script. So, make a small
set of nodes in the dracut script while building the directory structure
of the initramfs.

This allowed the error from the duplicate mknod /dev/null in the
initramfs to surface, so consider it tested. :)
---
On Sat, 2009-05-23 at 13:34 +0200, Andreas Thienemann wrote:
> When using the 00dash module in dracut, the emergency_shell currently has 
> no stderr.
> 
> Problem is related to dash closing stderr if opening /dev/tty fails.

Here's an alternate fix that works with today's dash in F10.
Dave

diff --git a/dracut b/dracut
index 942c420..02e9137 100755
--- a/dracut
+++ b/dracut
@@ -116,6 +116,12 @@ for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts var/run;
     mkdir -p "$initdir/$d"; 
 done
 
+# Make some basic devices in the initramfs, udev will handle the rest.
+mknod "$initdir/dev/null" c 1 3
+mknod "$initdir/dev/tty" c 5 0
+mknod "$initdir/dev/console" c 5 1
+mknod "$initdir/dev/ptmx" c 5 2
+
 # check all our modules to see if they should be sourced
 check_modules
   
@@ -153,4 +159,4 @@ unset item
 
 [[ "$beverbose" = "yes" ]] && ls -lh "$outfile"
 
-exit 0
\ No newline at end of file
+exit 0
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 5ee897e..9a72b30 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -28,19 +28,12 @@ trap "emergency_shell" 0
 
 . /lib/dracut-lib
 
-mknod /dev/null c 1 3
-
 # mount some important things
 mount -t proc /proc /proc >/dev/null 2>&1
 mount -t sysfs /sys /sys >/dev/null 2>&1
 mount -t tmpfs -omode=0755 udev /dev >/dev/null 2>&1
 
 getarg rdinitdebug && set -x
-# Make some basic devices first, let udev handle the rest
-mknod /dev/null c 1 3
-mknod /dev/ptmx c 5 2
-mknod /dev/console c 5 1
-mkdir /dev/pts
 mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts >/dev/null 2>&1
 
 # pre-udev scripts run before udev starts, and are run only once.




--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
