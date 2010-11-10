From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. e53fdd1c35f647441dec690e57f23ab0ebd3343e
Date: Wed, 10 Nov 2010 21:12:17 +0000
Message-ID: <E1PGHxu-00070G-Ie@sfp-scmshell-3.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  e53fdd1c35f647441dec690e57f23ab0ebd3343e (commit)
      from  040f3d2ffcebad74b8447bb6ce36d68ad910b3af (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit e53fdd1c35f647441dec690e57f23ab0ebd3343e
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 10 22:10:54 2010 +0100

    rootfs-block/mount-root.sh: remove $NEWROOT/.autofsck if possible

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index 93c5c42..fecc347 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -139,4 +139,5 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
         "${root#block:}" "$NEWROOT" 2>&1 | vinfo
 
     [ -f "$NEWROOT"/forcefsck ] && rm -f "$NEWROOT"/forcefsck 2>/dev/null
+    [ -f "$NEWROOT"/.autofsck ] && rm -f "$NEWROOT"/.autofsck 2>/dev/null
 fi
-----------------------------------------------------------------------

Summary of changes:
 modules.d/95rootfs-block/mount-root.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


-- 
dracut - Initramfs generator using udev
