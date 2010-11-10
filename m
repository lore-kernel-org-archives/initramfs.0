From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. ce51f3be1188bc27dfa2fd24a04efff664a116b4
Date: Wed, 10 Nov 2010 19:12:34 +0000
Message-ID: <E1PGG65-0003Ez-Ok@sfp-scmshell-4.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  ce51f3be1188bc27dfa2fd24a04efff664a116b4 (commit)
       via  4cba811f6c3a897022c6fdacbe30ae941dd6597a (commit)
      from  85de3d281a2af1619f237b93172f3316bcc43c22 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit ce51f3be1188bc27dfa2fd24a04efff664a116b4
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 10 20:12:05 2010 +0100

    rootfs-block/mount-root.sh: fixed filesystem type udev parsing

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index bc17848..b242acf 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -97,14 +97,15 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
 
     umount "$NEWROOT"
     if [ "$rootfs" = "auto" ]; then
-        udevadm info --query=env --name=${root#block:} | \
+        rootfs=$(udevadm info --query=env --name=${root#block:} | \
             while read line; do
                 if strstr $line ID_FS_TYPE; then
                     eval $line
-                    rootfs=$ID_FS_TYPE
+                    echo $ID_FS_TYPE
                     break
                 fi
-            done
+            done)
+        rootfs=${rootfs:-auto}
     fi
 
     # backslashes are treated as escape character in fstab
commit 4cba811f6c3a897022c6fdacbe30ae941dd6597a
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 10 20:11:31 2010 +0100

    rootfs-block/mount-root.sh: correctly printf to fstab

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index 00cf475..bc17848 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -109,7 +109,7 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
 
     # backslashes are treated as escape character in fstab
     esc_root=$(echo ${root#block:} | sed 's,\\,\\\\,g')
-    printf "%s $NEWROOT $rootfs ${rflags},${rootopts} 1 1\n" "$esc_root" > /etc/fstab
+    printf '%s %s %s %s,%s 1 1 \n' "$esc_root" "$NEWROOT" "$rootfs" "$rflags" "$rootopts"  > /etc/fstab
 
     if [ -z "$fastboot" -a "$READONLY" != "yes" ]; then
         info "Checking filesystems"
-----------------------------------------------------------------------

Summary of changes:
 modules.d/95rootfs-block/mount-root.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)


-- 
dracut - Initramfs generator using udev
