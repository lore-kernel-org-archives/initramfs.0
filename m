From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 7f7a91b75f94d1f6343f701c05d14bb70a8c378d
Date: Fri, 19 Nov 2010 12:40:35 +0000
Message-ID: <E1PJQGg-0004Dy-Il@sfp-scmshell-3.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  7f7a91b75f94d1f6343f701c05d14bb70a8c378d (commit)
       via  770b796e52f2b84bcca0c78ddc9975d6b91e41de (commit)
      from  b2415f4414e0a13a81c90b5356ec1a4b7a61468b (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 7f7a91b75f94d1f6343f701c05d14bb70a8c378d
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Fri Nov 19 13:40:34 2010 +0100

    base/init: fix init executable check

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 6557cf4..22cb39a 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -253,7 +253,10 @@ source_all pre-pivot
 # Try to find init.
 for i in "$(getarg real_init=)" "$(getarg init=)" /sbin/init /etc/init /init /bin/sh; do
     [ -n "$i" ] || continue
-    [ -d "$NEWROOT$i" ] || [ -L "$NEWROOT$i" -o -x "$NEWROOT$i" ] && { INIT="$i"; break; }
+    if ! [ -d "$NEWROOT$i" ] && [ -L "$NEWROOT$i" -o -x "$NEWROOT$i" ]; then
+        INIT="$i"
+        break
+    fi
 done
 
 [ "$INIT" ] || {
commit 770b796e52f2b84bcca0c78ddc9975d6b91e41de
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Fri Nov 19 13:37:17 2010 +0100

    base/init: honor old "real_init="

diff --git a/modules.d/99base/init b/modules.d/99base/init
index f79d102..6557cf4 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -251,7 +251,7 @@ source_all pre-pivot
 
 # by the time we get here, the root filesystem should be mounted.
 # Try to find init.
-for i in "$(getarg init=)" /sbin/init /etc/init /init /bin/sh; do
+for i in "$(getarg real_init=)" "$(getarg init=)" /sbin/init /etc/init /init /bin/sh; do
     [ -n "$i" ] || continue
     [ -d "$NEWROOT$i" ] || [ -L "$NEWROOT$i" -o -x "$NEWROOT$i" ] && { INIT="$i"; break; }
 done
-----------------------------------------------------------------------

Summary of changes:
 modules.d/99base/init |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


-- 
dracut - Initramfs generator using udev
