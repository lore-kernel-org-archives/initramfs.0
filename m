From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 16/50] $MNTIMAGE?  I thought the install dir was $initdir.
Date: Mon, 16 Feb 2009 14:06:17 -0500
Message-ID: <200902161906.n1GJ6HbF027914@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=b2b11f55796902d18e4840410837f5d7eaa6adf4
Commit:     b2b11f55796902d18e4840410837f5d7eaa6adf4
Parent:     dce3f50a7d7fd2d82c976bb4d2e412d82bc64208
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:08 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 16/50] $MNTIMAGE?  I thought the install dir was $initdir.
---
 dracut |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index 13c254f..a19f910 100755
--- a/dracut
+++ b/dracut
@@ -98,10 +98,10 @@ if [ -f /etc/sysconfig/i18n ]; then
         inst "$FN" "$initdir"
         case $FN in
             *.gz)
-                gzip -d "$MNTIMAGE$FN"
+                gzip -d "$initdir$FN"
                 ;;
             *.bz2)
-                bzip2 -d "$MNTIMAGE$FN"
+                bzip2 -d "$initdir$FN"
                 ;;
         esac
     done
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
