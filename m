From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. ae202ef02e2bbc553753a6cc4749e61d8cf9a7a6
Date: Fri, 19 Nov 2010 18:07:51 +0000
Message-ID: <E1PJVNS-0007Ov-Jz@sfp-scmshell-1.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  ae202ef02e2bbc553753a6cc4749e61d8cf9a7a6 (commit)
      from  7f7a91b75f94d1f6343f701c05d14bb70a8c378d (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit ae202ef02e2bbc553753a6cc4749e61d8cf9a7a6
Author: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Date:   Fri Nov 19 18:32:30 2010 +0100

    Search in for KMS-capable drivers in extra/ as well
    
    User can have an out-of-tree video driver supporting KMS installed;
    Intel GMA500 drivers from RPM Fusion are one example of such module.

diff --git a/modules.d/50plymouth/installkernel b/modules.d/50plymouth/installkernel
index d84eee9..61a8dfb 100755
--- a/modules.d/50plymouth/installkernel
+++ b/modules.d/50plymouth/installkernel
@@ -2,6 +2,6 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 # Include KMS capable drm drivers
-for modname in $(find "$srcmods/kernel/drivers/gpu/drm" -name '*.ko' 2>/dev/null); do
+for modname in $(find "$srcmods/kernel/drivers/gpu/drm" "$srcmods/extra" -name '*.ko' 2>/dev/null); do
     grep -q drm_crtc_init  $modname && instmods $modname
 done
-----------------------------------------------------------------------

Summary of changes:
 modules.d/50plymouth/installkernel |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
