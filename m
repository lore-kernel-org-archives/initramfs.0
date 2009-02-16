From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 01/50] We have a path.  Do not specify full paths to commands that are in it.
Date: Mon, 16 Feb 2009 14:05:49 -0500
Message-ID: <200902161905.n1GJ5nAY027139@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=09f9fec00c04858806d235688b6d728a20c3201e
Commit:     09f9fec00c04858806d235688b6d728a20c3201e
Parent:     dd1ae3a105d3dc11bcb514d73401b1631cd7c608
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:29 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 01/50] We have a path.  Do not specify full paths to commands that are in it.
---
 init |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/init b/init
index 706127f..eb8998d 100755
--- a/init
+++ b/init
@@ -7,18 +7,18 @@
 
 emergency_shell()
 {
-    [ -x /bin/plymouth ] && /bin/plymouth --hide-splash
+    [ -x /bin/plymouth ] && plymouth --hide-splash
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
     echo
     bash < /dev/console
 }
-trap "emergency_shell" 0 2
 
 echo "Starting initrd..."
 export PATH=/sbin:/bin:/usr/sbin:/usr/bin
 export TERM=linux
 
+trap "emergency_shell" 0 2
 # /dev/console comes from the built-in initramfs crud in the kernel
 # someday, we may need to mkdir /dev first here
 exec > /dev/console 2>&1 < /dev/console
@@ -38,13 +38,13 @@ mknod /dev/tty1 c 4 1
 
 # start plymouth if it's available
 # arguably we need some of udev run first for fbmods and above devnodes :/
-[ -x /bin/plymouthd ] && /bin/plymouthd --attach-to-session
-[ -x /bin/plymouth ] && /bin/plymouth --show-splash
+[ -x /bin/plymouthd ] && plymouthd --attach-to-session
+[ -x /bin/plymouth ] && plymouth --show-splash
 
 
 # start up udev and trigger cold plugs
-/sbin/udevd --daemon
-/sbin/udevadm trigger
+udevd --daemon
+udevadm trigger
 
 # mount the rootfs
 NEWROOT="/sysroot"
@@ -108,10 +108,10 @@ fi
 # kill off udev
 kill `pidof udevd`
 
-[ -x /bin/plymouth ] && /bin/plymouth --newroot=$NEWROOT
+[ -x /bin/plymouth ] && plymouth --newroot=$NEWROOT
 
 # FIXME: nash die die die
-exec /sbin/switch_root
+exec switch_root
 # davej doesn't like initrd bugs
 echo "Something went very badly wrong in the initrd.  Please "
 echo "file a bug against mkinitrd."
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
