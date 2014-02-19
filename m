From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] use cp to copy early.cpio to /boot for restoring default
 selinux label
Date: Wed, 19 Feb 2014 18:18:42 +0800
Message-ID: <20140219101842.GA10403@dhcp-17-89.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We use mv to move early.cpio from /tmp to /boot and early.cpio will
retain the file label. But later selinux will reject kexec from
accessing this such label under /boot.

What we should do is to copy early.cpio to /boot and the new early.cpio
will have a default file label for /boot. So that later selinux will not
reject accessing to this file.

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut.sh b/dracut.sh
index 5267af5..ddfb760 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1469,7 +1469,7 @@ if [[ $create_early_cpio = yes ]]; then
     echo 1 > "$early_cpio_dir/d/early_cpio"
     # The microcode blob is _before_ the initramfs blob, not after
     (cd "$early_cpio_dir/d";     find . -print0 | cpio --null $cpio_owner_root -H newc -o --quiet >../early.cpio)
-    mv $early_cpio_dir/early.cpio $outfile.$$
+    cp $early_cpio_dir/early.cpio $outfile.$$
 fi
 if ! ( umask 077; cd "$initdir"; find . -print0 | cpio --null $cpio_owner_root -H newc -o --quiet | \
     $compress >> "$outfile.$$"; ); then
-- 
1.8.5.3
