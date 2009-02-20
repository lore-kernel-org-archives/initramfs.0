From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] Make exec failure not kill init or switch_root.
Date: Fri, 20 Feb 2009 09:24:26 -0800 (PST)
Message-ID: <fddb443a2ab88c15e296d7ab9e8bab0a04887f6d.1235149680.git.victor.lowther@gmail.com>
References: <101475621c53b8698d94deb257b95ad2291f4d63.1235149680.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=h4z/u6OhIUx8L+2jRriU8JnHuJGQ0+qAEB2skIJvY4s=;
        b=sMTiJGzwtd4BKELLXYGNSc037pqAjbdZbJzfOucMgj8blWykN6fIJy4jvY7bHuEaOo
         bLA5gCWORncar9AQ4nghwEugda1YpqLRpRtwZLhtMXpfDqgTHJPlVGlNnpIY/h6Cb//W
         w+/MNx3zqE1Q/by3PdWC1InqO++m1jYH603BI=
In-Reply-To: <101475621c53b8698d94deb257b95ad2291f4d63.1235149680.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If exec fails, then the shell will die unless the next command
is part of a command list. So, exec $whatever || onoes is the way to go

There are also some minor cleanups that were leftovers from splitting
out switch_root in its current form.
---
 init        |   16 ++++++++--------
 switch_root |    5 ++---
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/init b/init
index 06689a6..358ef02 100755
--- a/init
+++ b/init
@@ -57,7 +57,7 @@ udevd --daemon
 udevadm trigger >/dev/null 2>&1
 
 # mount the rootfs
-export NEWROOT="/sysroot"
+NEWROOT="/sysroot"
 
 # FIXME: there's got to be a better way ...
 # it'd be nice if we had a udev rule that just did all of the bits for
@@ -96,10 +96,10 @@ INIT=$(getarg init)
 }
 	    
 source_all pre-pivot
-
-exec switch_root "$NEWROOT" "$INIT"  $CMDLINE
-# davej doesn't like initrd bugs
-echo "Something went very badly wrong in the initrd.  Please "
-echo "file a bug against mkinitrd."
-sleep 100d
-exit 1
+echo "Switching to real root filesystem $root"
+exec switch_root "$NEWROOT" "$INIT"  $CMDLINE || {
+    # davej doesn't like initrd bugs
+    echo "Something went very badly wrong in the initrd.  Please "
+    echo "file a bug against mkinitrd."
+    emergency_shell
+}
diff --git a/switch_root b/switch_root
index 1cc80e9..d142e97 100755
--- a/switch_root
+++ b/switch_root
@@ -72,7 +72,6 @@ update_newroot_libpath
 
 # start looking for required binaries and bits of infrastructure
 BINDIRS="/bin /sbin /usr/bin /usr/sbin"
-INITDIRS="/sbin /etc /"
 RM=$(simple_find rm $BINDIRS) || die "Cannnot find rm on $NEWROOT"
 CHROOT=$(simple_find chroot $BINDIRS) || die "Cannot find chroot on $NEWROOT"
 LDD=$(simple_find ldd $BINDIRS) || die "Cannot find ldd on $NEWROOT"
@@ -108,5 +107,5 @@ run_from_newroot "$MOUNT_LDSO" "$MOUNT" -n --move . /
 # exec init.
 NEWROOT="."
 update_newroot_libpath
-run_from_newroot "$CHROOT_LDSO" exec "$CHROOT" "$NEWROOT" "$INIT" "$@"
-die "The chroot did not take for some reason"
+run_from_newroot "$CHROOT_LDSO" exec "$CHROOT" "$NEWROOT" "$INIT" "$@" || \
+    die "The chroot did not take for some reason"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
