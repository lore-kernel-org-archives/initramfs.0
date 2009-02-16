From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 15/50] Tighten up the keymap installation case statement in dracut.
Date: Mon, 16 Feb 2009 14:06:15 -0500
Message-ID: <200902161906.n1GJ6FoF027887@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=dce3f50a7d7fd2d82c976bb4d2e412d82bc64208
Commit:     dce3f50a7d7fd2d82c976bb4d2e412d82bc64208
Parent:     3c3e1e0c4941d15cf21353421b0c616ea075d9dc
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:06 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 15/50] Tighten up the keymap installation case statement in dracut.
---
 dracut |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/dracut b/dracut
index 8cbe0da..13c254f 100755
--- a/dracut
+++ b/dracut
@@ -80,13 +80,9 @@ if [[ -f /etc/sysconfig/keyboard || -f /etc/sysconfig/console/default.kmap ]]; t
 
         for FN in $KEYMAPS; do
             inst $FN "$initdir"
-            case "$FN" in
-                *.gz)
-                    gzip -d "$initdir$FN"
-                    ;;
-                *.bz2)
-                    bzip2 -d "$initdir$FN"
-                    ;;
+            case $FN in
+                *.gz) gzip -d "$initdir$FN" ;;
+                *.bz2) bzip2 -d "$initdir$FN" ;;
             esac
         done
     fi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
