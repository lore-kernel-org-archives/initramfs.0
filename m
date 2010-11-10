From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 5dc6f240856a37d864298e67233a8312c882a927
Date: Wed, 10 Nov 2010 21:50:40 +0000
Message-ID: <E1PGIZ6-00043s-D7@sfp-scmshell-1.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  5dc6f240856a37d864298e67233a8312c882a927 (commit)
      from  e53fdd1c35f647441dec690e57f23ab0ebd3343e (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 5dc6f240856a37d864298e67233a8312c882a927
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 10 22:50:20 2010 +0100

    base/loginit: s/==/=
    
    stupid bug!

diff --git a/modules.d/99base/loginit b/modules.d/99base/loginit
index 7476262..3ceaede 100755
--- a/modules.d/99base/loginit
+++ b/modules.d/99base/loginit
@@ -11,7 +11,7 @@ QUIET=$1
 exec 6>/init.log
 
 while read line; do 
-    [ "$line" == "DRACUT_LOG_END" ] && exit 0
+    [ "$line" = "DRACUT_LOG_END" ] && exit 0
     echo "<7>dracut: $line" >&5
     # if "quiet" is specified we output to /dev/console
     [ -n "$QUIET" ] && echo "dracut: $line" 
-----------------------------------------------------------------------

Summary of changes:
 modules.d/99base/loginit |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
dracut - Initramfs generator using udev
