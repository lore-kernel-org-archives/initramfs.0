From: Chao Fan <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] remove the incomplete .img file
Date: Tue, 21 Jul 2015 17:18:42 +0800
Message-ID: <1437470322-992-1-git-send-email-cfan@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chao Fan <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

If the directory where the .img file is saved has no enough space, or in
other wrong conditions, dracut will get an incomplete file xxx.img. But
sometimes this .img file will be loaded when rebooting the system. And then
some bugs will happen because this .img file is wrong.

So I think dracut should remove the incomplete file because this .img file
with problems was made by dracut. And then the wrong file will not be loaded
anymore.

Signed-off-by: Chao Fan <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dracut.sh b/dracut.sh
index ee0a039..122ae0c 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1651,6 +1651,7 @@ if ! (
             | $compress >> "$outfile"
     ); then
     dfatal "dracut: creation of $outfile failed"
+	rm -f $outfile
     exit 1
 fi
 dinfo "*** Creating initrd image file '$outfile' done ***"
-- 
2.1.0
