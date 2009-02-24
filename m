From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Make exec failure not kill init or switch_root.
Date: Tue, 24 Feb 2009 05:00:04 GMT
Message-ID: <200902240500.n1O504j5010513@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=9cead591ad8fa7de856d4dc3777bb7c155a6d3b8
Commit:     9cead591ad8fa7de856d4dc3777bb7c155a6d3b8
Parent:     3f9c86ab865dfb8b33eb746729133c685c916b68
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 20 09:24:26 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 23 13:22:01 2009 -0500

    Make exec failure not kill init or switch_root.
    
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
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
