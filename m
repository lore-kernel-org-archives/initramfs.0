From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 18/50] outfile processing can fit all on one line, so make it.
Date: Mon, 16 Feb 2009 14:06:21 -0500
Message-ID: <200902161906.n1GJ6L8e027979@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=95994c57c572c4442f911560fe5cbedead2df56e
Commit:     95994c57c572c4442f911560fe5cbedead2df56e
Parent:     5a862b968a525b8d6fb3ac643daf0f9caa3ab186
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:13 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 18/50] outfile processing can fit all on one line, so make it.
---
 dracut |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/dracut b/dracut
index ae53caf..84abdb5 100755
--- a/dracut
+++ b/dracut
@@ -24,8 +24,7 @@ while (($# > 0)); do
 done
 
 [[ $2 ]] && kernel=$2 || kernel=$(uname -r)
-[[ $1 ]] && outfile=$(readlink -f $1) || \
-    outfile="/boot/initrd-$kernel.img"
+[[ $1 ]] && outfile=$(readlink -f $1) || outfile="/boot/initrd-$kernel.img"
 
 if [[ -f $outfile && ! $force ]]; then
     echo "Will not override existing initramfs ($outfile) without --force"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
