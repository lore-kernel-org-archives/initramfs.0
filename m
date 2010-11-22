From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 5b928ffade721f63c3d6c6001cf3588493fdc8b0
Date: Mon, 22 Nov 2010 15:28:07 +0000
Message-ID: <E1PKYJc-0001be-Gb@sfp-scmshell-1.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  5b928ffade721f63c3d6c6001cf3588493fdc8b0 (commit)
      from  ae202ef02e2bbc553753a6cc4749e61d8cf9a7a6 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 5b928ffade721f63c3d6c6001cf3588493fdc8b0
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Nov 22 10:05:42 2010 +0100

    dracut.spec: inc release

diff --git a/dracut.spec b/dracut.spec
index 6a9a462..4b7f068 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -15,7 +15,7 @@
 
 Name: dracut
 Version: 008
-%define release_prefix 0.9%{?rdist}
+%define release_prefix 0.10%{?rdist}
 Release: %{release_prefix}
 
 Summary: Initramfs generator using udev
-----------------------------------------------------------------------

Summary of changes:
 dracut.spec |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
