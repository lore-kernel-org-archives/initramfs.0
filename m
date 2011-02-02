From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, RHEL-6, updated. f4dad880857d7c2f11d27cf8450071754e9a3ac7
Date: Wed,  2 Feb 2011 16:42:55 +0000
Message-ID: <E1PkfnK-0004mR-Mm@sfp-scmshell-3.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, RHEL-6 has been updated
       via  f4dad880857d7c2f11d27cf8450071754e9a3ac7 (commit)
      from  cbea975b987fb994c0911c94ea6c83743dead60e (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit f4dad880857d7c2f11d27cf8450071754e9a3ac7
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Fri Jan 28 13:26:03 2011 +0100

    base: install "less" optionally

diff --git a/modules.d/99base/install b/modules.d/99base/install
index c0dff8c..a317442 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -1,6 +1,7 @@
 #!/bin/bash
 dracut_install mount mknod mkdir modprobe pidof sleep chroot \
-    sed ls flock cp mv dmesg rm ln rmmod mkfifo less 
+    sed ls flock cp mv dmesg rm ln rmmod mkfifo
+dracut_install -o less
 if [ ! -e "${initdir}/bin/sh" ]; then
     dracut_install bash
     (ln -s bash "${initdir}/bin/sh" || :)
-----------------------------------------------------------------------

Summary of changes:
 modules.d/99base/install |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
