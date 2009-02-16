From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 06/50] Bashify results testing for selinux policy loading
Date: Mon, 16 Feb 2009 14:05:59 -0500
Message-ID: <200902161905.n1GJ5x21027276@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=39b4c02111cae677cc33c731ab146c94404110c7
Commit:     39b4c02111cae677cc33c731ab146c94404110c7
Parent:     e0bb3c3613a7b706984f12829892365fa42a404d
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:45 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 06/50] Bashify results testing for selinux policy loading
---
 init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init b/init
index 2ebf1b0..2b7aa36 100755
--- a/init
+++ b/init
@@ -92,7 +92,7 @@ mount -t sysfs /sys $NEWROOT/sys
 # FIXME: load selinux policy.  this should really be done after we switchroot 
 if [ -x $NEWROOT/usr/sbin/load_policy ]; then
   chroot $NEWROOT /usr/sbin/load_policy -i
-  if [ $? -eq 3 ]; then
+  if (($? == 3)); then
     echo "Initial SELinux policy load failed and enforcing mode requested."
     echo "Not continuing"
     sleep 100d
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
