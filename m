From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, RHEL-6, updated. 2f25c3f4a563063684f0cecdaa87790dfcf9c1f6
Date: Wed, 26 Jan 2011 12:36:01 +0000
Message-ID: <E1Pi4bZ-0004Ee-Th@sfp-scmshell-2.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, RHEL-6 has been updated
       via  2f25c3f4a563063684f0cecdaa87790dfcf9c1f6 (commit)
      from  0828d4c3574693ae80c217229e1bba6948dc9509 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 2f25c3f4a563063684f0cecdaa87790dfcf9c1f6
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Dec 8 13:46:25 2010 +0100

    fcoe/parse-fcoe.sh: removed second else

diff --git a/modules.d/95fcoe/parse-fcoe.sh b/modules.d/95fcoe/parse-fcoe.sh
index 52def0a..f862131 100755
--- a/modules.d/95fcoe/parse-fcoe.sh
+++ b/modules.d/95fcoe/parse-fcoe.sh
@@ -73,7 +73,5 @@ else
         fi
         source /sbin/fcoe-genrules.sh
     done
-else
-    warn "Invalid arguments for fcoe=$fcoe"
 fi
 
-----------------------------------------------------------------------

Summary of changes:
 modules.d/95fcoe/parse-fcoe.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)


-- 
dracut - Initramfs generator using udev
