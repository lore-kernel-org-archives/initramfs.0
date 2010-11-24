From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 3f003263d292af26b1f7971439df3a813d7b0f93
Date: Wed, 24 Nov 2010 18:01:39 +0000
Message-ID: <E1PLJf6-00038I-7f@sfp-scmshell-2.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  3f003263d292af26b1f7971439df3a813d7b0f93 (commit)
      from  b9cc6f7ca95014c779364908ce6aa99997d4ae73 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 3f003263d292af26b1f7971439df3a813d7b0f93
Author: Tomasz Torcz <tomek-e+FrjxkDqoI/dUmziOgvOQ@public.gmane.org>
Date:   Wed Nov 24 18:33:19 2010 +0100

    - move btrfs rules order from 40 to 80 for ID_FS_TYPE to work (which is populated by 60-persistent-storage.rules)

diff --git a/modules.d/90btrfs/40-btrfs.rules b/modules.d/90btrfs/80-btrfs.rules
similarity index 100%
rename from modules.d/90btrfs/40-btrfs.rules
rename to modules.d/90btrfs/80-btrfs.rules
diff --git a/modules.d/90btrfs/install b/modules.d/90btrfs/install
index af934fc..e4858e2 100755
--- a/modules.d/90btrfs/install
+++ b/modules.d/90btrfs/install
@@ -2,5 +2,5 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
-inst_rules "$moddir/40-btrfs.rules"
+inst_rules "$moddir/80-btrfs.rules"
 dracut_install btrfsctl
-----------------------------------------------------------------------

Summary of changes:
 .../90btrfs/{40-btrfs.rules => 80-btrfs.rules}     |    0
 modules.d/90btrfs/install                          |    2 +-
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename modules.d/90btrfs/{40-btrfs.rules => 80-btrfs.rules} (100%)


-- 
dracut - Initramfs generator using udev
