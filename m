From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:34:41 -0800 (PST)
Message-ID: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:from:subject
         :to:x-mailer;
        bh=xKbAdArzZJCY31mZnql/PMTxM73Ucm19zM6ZN7eJ+rY=;
        b=pBMV3QnOmk4ic/c/L0IEXW0FAH9R3CncpymwTAPlNykgbvTQ+dPIQrP+bHJi2vXvpY
         2fVcLleUUmK2AFS/GcQaCDmY4YfCowdr2b4TKC+8BcNTjdvVckYHgws5A94Nnpgx3XkR
         p/5ILkYYe0bzATehD4GzqgQ2Cri2R/MDBAOIs=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi, I enjoy hacking on system infrastructure and am a bash programming 
aficionado. With that in mind, I present this patch series against current
master -- it simplifies several bits of code and shaves about 200 lines out
of the codebase.  The final result has been tested on a Fedora 10 box that
uses lvm on top of dm-crypt, and it works fine.  I have not tested all
intermediate steps -- life is too short.

Comments, flames, commit access to the repo welcome.

These patches are also availble at http://git.fnordovax.org/dracut/ 

We have a path.  Do not specify full paths to commands that are in it.

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
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
