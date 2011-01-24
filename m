From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. ee1fa07f3d8258a78ae83ea2ec0e0d973e9a7624
Date: Mon, 24 Jan 2011 12:39:24 +0000
Message-ID: <E1PhLho-0005nU-GI@sfp-scmshell-3.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  ee1fa07f3d8258a78ae83ea2ec0e0d973e9a7624 (commit)
      from  cf3bc080c17867ae18652aacccde9101c82ef2c4 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit ee1fa07f3d8258a78ae83ea2ec0e0d973e9a7624
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Jan 24 13:41:24 2011 +0100

    base/install: create emergency subdir

diff --git a/modules.d/99base/install b/modules.d/99base/install
index 4a18fbf..95d60bb 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -13,6 +13,7 @@ inst "$moddir/init" "/init"
 inst "$moddir/initqueue" "/sbin/initqueue"
 inst "$moddir/loginit" "/sbin/loginit"
 mkdir -p ${initdir}/initqueue
+mkdir -p ${initdir}/emergency
 mkdir -p ${initdir}/initqueue-finished
 mkdir -p ${initdir}/initqueue-settled
 mkdir -p ${initdir}/tmp
-----------------------------------------------------------------------

Summary of changes:
 modules.d/99base/install |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


-- 
dracut - Initramfs generator using udev
