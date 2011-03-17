From: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [dracut GIT] branch, master, updated. 519d339233fa5a99ec36e9cb6285b428eaeb0944
Date: Thu, 17 Mar 2011 11:16:51 GMT
Message-ID: <201103171116.p2HBGp9K016286@hera.kernel.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  519d339233fa5a99ec36e9cb6285b428eaeb0944 (commit)
      from  1e64e4939f785a93fbb79ca814cf35023f264f2b (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 519d339233fa5a99ec36e9cb6285b428eaeb0944
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Thu Mar 17 12:16:33 2011 +0100

    dracut-logger: don't debug log "return 0" of dlog()

diff --git a/dracut-logger b/dracut-logger
index f0c3eec..ce7dbd0 100755
--- a/dracut-logger
+++ b/dracut-logger
@@ -294,8 +294,7 @@ dlog() {
             _do_dlog "$1" "$line"
         done
     fi
-    [ -n "$debug" ] && set -x
-    return 0
+    [ -n "$debug" ] && set -x || :
 }
 
 ## @brief Logs message at TRACE level (6)
-----------------------------------------------------------------------

Summary of changes:
 dracut-logger |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)


-- 
dracut - Initramfs generator using udev
