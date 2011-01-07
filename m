From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 2ca68bb82bc610cc9db6a5de5cae9c19f3bfc269
Date: Fri,  7 Jan 2011 11:05:27 +0000
Message-ID: <E1PbA8X-0006xI-Im@sfp-scmshell-4.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  2ca68bb82bc610cc9db6a5de5cae9c19f3bfc269 (commit)
       via  e2d86d001ad96ade298efdbe0c1e4b5189648846 (commit)
      from  8082a0946e5702217d9b04f8d67287ebd4958da6 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 2ca68bb82bc610cc9db6a5de5cae9c19f3bfc269
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Fri Jan 7 12:05:42 2011 +0100

    base/install: make install of "less" optional

diff --git a/modules.d/99base/install b/modules.d/99base/install
index 57bf4bc..4a18fbf 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -2,7 +2,8 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 dracut_install mount mknod mkdir modprobe pidof sleep chroot \
-    sed ls flock cp mv dmesg rm ln rmmod mkfifo less 
+    sed ls flock cp mv dmesg rm ln rmmod mkfifo 
+dracut_install -o less 
 if [ ! -e "${initdir}/bin/sh" ]; then
     dracut_install bash
     (ln -s bash "${initdir}/bin/sh" || :)
commit e2d86d001ad96ade298efdbe0c1e4b5189648846
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Jan 3 09:48:37 2011 +0100

    fips: s/==/=

diff --git a/modules.d/01fips/fips.sh b/modules.d/01fips/fips.sh
index 0596839..c51b16c 100755
--- a/modules.d/01fips/fips.sh
+++ b/modules.d/01fips/fips.sh
@@ -61,7 +61,7 @@ do_fips()
     return 0
 }
 
-if ! fipsmode=$(getarg fips) || [ $fipsmode == "0" ]; then
+if ! fipsmode=$(getarg fips) || [ $fipsmode = "0" ]; then
     rm -f /etc/modprobe.d/fips.conf >/dev/null 2>&1
 else
     set -e
-----------------------------------------------------------------------

Summary of changes:
 modules.d/01fips/fips.sh |    2 +-
 modules.d/99base/install |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)


-- 
dracut - Initramfs generator using udev
