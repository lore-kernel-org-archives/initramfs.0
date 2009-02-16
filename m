From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 17/50] Tighten up the font installation case statement as well.
Date: Mon, 16 Feb 2009 14:06:19 -0500
Message-ID: <200902161906.n1GJ6JkN027941@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=5a862b968a525b8d6fb3ac643daf0f9caa3ab186
Commit:     5a862b968a525b8d6fb3ac643daf0f9caa3ab186
Parent:     b2b11f55796902d18e4840410837f5d7eaa6adf4
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:11 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 17/50] Tighten up the font installation case statement as well.
---
 dracut |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/dracut b/dracut
index a19f910..ae53caf 100755
--- a/dracut
+++ b/dracut
@@ -97,12 +97,8 @@ if [ -f /etc/sysconfig/i18n ]; then
     for FN in /lib/kbd/consolefonts/$SYSFONT.* ; do
         inst "$FN" "$initdir"
         case $FN in
-            *.gz)
-                gzip -d "$initdir$FN"
-                ;;
-            *.bz2)
-                bzip2 -d "$initdir$FN"
-                ;;
+            *.gz) gzip -d "$initdir$FN" ;;
+            *.bz2) bzip2 -d "$initdir$FN" ;;
         esac
     done
     [[ $SYSFONTACM ]] && inst /lib/kbd/consoletrans/$SYSFONTACM "$initdir"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
