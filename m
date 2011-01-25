From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 444061de67a7d02441519e07ff6acafe78baa752
Date: Tue, 25 Jan 2011 09:33:26 +0000
Message-ID: <E1PhfHH-0005zb-7g@sfp-scmshell-3.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  444061de67a7d02441519e07ff6acafe78baa752 (commit)
      from  ee1fa07f3d8258a78ae83ea2ec0e0d973e9a7624 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 444061de67a7d02441519e07ff6acafe78baa752
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Jan 25 10:35:20 2011 +0100

    base/init: drop "noexec" from /dev/shm

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 22cb39a..8116a4d 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -104,7 +104,7 @@ ln -s /proc/self/fd/1 /dev/stdout >/dev/null 2>&1
 ln -s /proc/self/fd/2 /dev/stderr >/dev/null 2>&1
 mkdir -m 0755 /dev/shm /dev/pts /dev/.udev /dev/.udev/rules.d /dev/.initramfs
 mount -t devpts -o gid=5,mode=620,noexec,nosuid devpts /dev/pts >/dev/null 2>&1
-mount -t tmpfs -o mode=1777,noexec,nosuid,nodev  tmpfs /dev/shm >/dev/null 2>&1
+mount -t tmpfs -o mode=1777,nosuid,nodev  tmpfs /dev/shm >/dev/null 2>&1
 
 if getargbool 0 rd.debug -y rdinitdebug -y rdnetdebug; then
     getarg quiet && DRACUT_QUIET="yes"
-----------------------------------------------------------------------

Summary of changes:
 modules.d/99base/init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
