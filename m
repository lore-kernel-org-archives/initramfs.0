From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 040f3d2ffcebad74b8447bb6ce36d68ad910b3af
Date: Wed, 10 Nov 2010 20:28:03 +0000
Message-ID: <E1PGHH5-0008Gy-Gx@sfp-scmshell-2.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  040f3d2ffcebad74b8447bb6ce36d68ad910b3af (commit)
       via  d884af80775e6a3299e65930235b64135e9d4220 (commit)
       via  a4f88b8a49af96423161f5a62376395768871b43 (commit)
       via  3d7c58ca1e0129b6f96fb66ba214eae71337616a (commit)
      from  ce51f3be1188bc27dfa2fd24a04efff664a116b4 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 040f3d2ffcebad74b8447bb6ce36d68ad910b3af
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 10 21:27:33 2010 +0100

    base/init: re-add initqueue-finished

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 1a1a0e5..ef96918 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -187,6 +187,14 @@ while :; do
 
     $UDEV_QUEUE_EMPTY >/dev/null 2>&1 || continue
 
+    for job in /initqueue-settled/*.sh; do
+        [ -e "$job" ] || break
+        job=$job . $job
+        check_finished && break 2
+    done
+
+    $UDEV_QUEUE_EMPTY >/dev/null 2>&1 || continue
+
     # no more udev jobs and queues empty.
     sleep 0.5
 
commit d884af80775e6a3299e65930235b64135e9d4220
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 10 20:45:12 2010 +0100

    rootfs-block/mount-root.sh: remove $NEWROOT/{.autofsck,forcefsck} if possible

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index baa1ce5..93c5c42 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -137,4 +137,6 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
     info "Remounting ${root#block:} with -o ${rflags},${rootopts}"
     mount -t "$rootfs" -o "$rflags","$rootopts" \
         "${root#block:}" "$NEWROOT" 2>&1 | vinfo
+
+    [ -f "$NEWROOT"/forcefsck ] && rm -f "$NEWROOT"/forcefsck 2>/dev/null
 fi
commit a4f88b8a49af96423161f5a62376395768871b43
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 10 20:45:02 2010 +0100

    rootfs-block/mount-root.sh: set prompt in emergency shell

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index f56fbed..baa1ce5 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -127,7 +127,7 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
             warn "*** An error occurred during the file system check."
             warn "*** Dropping you to a shell; the system will retry"
             warn "*** to mount the system, when you leave the shell."
-            emergency_shell "(Repair filesystem)"
+            emergency_shell -n "(Repair filesystem)"
         else
             echo $out|vinfo
             [ $RD_ROOTFS_FSCK -gt 0 ] && warn "fsck returned with $RD_ROOTFS_FSCK"
commit 3d7c58ca1e0129b6f96fb66ba214eae71337616a
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 10 20:43:22 2010 +0100

    rootfs-block/mount-root.sh: echo fsck return code to
    /dev/.initramfs/fsck

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index b242acf..f56fbed 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -117,6 +117,8 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
         info fsck -T -t noopts=_netdev -A $fsckoptions
         out=$(fsck -T -t noopts=_netdev -A $fsckoptions) 
         export RD_ROOTFS_FSCK=$?
+        mkdir -p /dev/.initramfs
+        echo $RD_ROOTFS_FSCK > /dev/.initramfs/fsck
         
         # A return of 4 or higher means there were serious problems.
         if [ $RD_ROOTFS_FSCK -gt 3 ]; then
-----------------------------------------------------------------------

Summary of changes:
 modules.d/95rootfs-block/mount-root.sh |    6 +++++-
 modules.d/99base/init                  |    8 ++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
