From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 07/50] Get rid of `` subprocess expansion when killing udevd.
Date: Mon, 16 Feb 2009 14:06:00 -0500
Message-ID: <200902161906.n1GJ607H027303@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=8b691309de20bb20c064cf8c9bd3502a9eddc76a
Commit:     8b691309de20bb20c064cf8c9bd3502a9eddc76a
Parent:     39b4c02111cae677cc33c731ab146c94404110c7
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:47 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 07/50] Get rid of `` subprocess expansion when killing udevd.
    
    $() subprocess expansion is so much easier to read.
---
 init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init b/init
index 2b7aa36..599f8ad 100755
--- a/init
+++ b/init
@@ -101,7 +101,7 @@ if [ -x $NEWROOT/usr/sbin/load_policy ]; then
 fi
 
 # kill off udev
-kill `pidof udevd`
+kill $(pidof udevd)
 
 [ -x /bin/plymouth ] && plymouth --newroot=$NEWROOT
 
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
