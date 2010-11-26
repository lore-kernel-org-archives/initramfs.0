From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. ab9b7eee0a334d2c367ebd60b7bd22beac68a5f8
Date: Fri, 26 Nov 2010 08:35:43 +0000
Message-ID: <E1PLtmc-000091-Rh@sfp-scmshell-4.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  ab9b7eee0a334d2c367ebd60b7bd22beac68a5f8 (commit)
      from  3f003263d292af26b1f7971439df3a813d7b0f93 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit ab9b7eee0a334d2c367ebd60b7bd22beac68a5f8
Author: Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date:   Fri Nov 26 03:21:17 2010 +0100

    fix installation of `modules.builtin.bin'
    
    `modules.builtin.bin' is installed like a regular file, thereby ending
    up in the wrong place when `--kmoddir' is in effect. Fix this by
    specifying the installation destination.

diff --git a/modules.d/90kernel-modules/install b/modules.d/90kernel-modules/install
index 863ffac..b635216 100755
--- a/modules.d/90kernel-modules/install
+++ b/modules.d/90kernel-modules/install
@@ -4,4 +4,4 @@
 [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
 dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
 inst_hook cmdline 01 "$moddir/parse-kernel.sh"
-inst "$srcmods/modules.builtin.bin"
+inst "$srcmods/modules.builtin.bin" "/lib/modules/$kernel/modules.builtin.bin"
-----------------------------------------------------------------------

Summary of changes:
 modules.d/90kernel-modules/install |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
