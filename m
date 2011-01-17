From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. cf3bc080c17867ae18652aacccde9101c82ef2c4
Date: Mon, 17 Jan 2011 10:14:21 +0000
Message-ID: <E1Pem6c-00062o-1n@sfp-scmshell-4.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  cf3bc080c17867ae18652aacccde9101c82ef2c4 (commit)
      from  2ca68bb82bc610cc9db6a5de5cae9c19f3bfc269 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit cf3bc080c17867ae18652aacccde9101c82ef2c4
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Jan 17 11:15:16 2011 +0100

    dracut.spec: removed "mount" requirement
    
    mount is part of util-linux-ng. There is no mount package.

diff --git a/dracut.spec b/dracut.spec
index f3b92d7..a14a2ec 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -84,7 +84,6 @@ Requires: udev
 Requires: util-linux-ng >= 2.16
 Requires: initscripts >= 8.63-1
 Requires: plymouth >= 0.8.0-0.2009.29.09.19.1
-Requires: mount
 %endif
 
 %if 0%{?suse_version}
-----------------------------------------------------------------------

Summary of changes:
 dracut.spec |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
