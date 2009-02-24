From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: We now support mounting the rootfs rw.
Date: Tue, 24 Feb 2009 05:00:10 GMT
Message-ID: <200902240500.n1O50Aae011037@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=945a2d4df0c2a9563090a0c04f16873bcb0a3709
Commit:     945a2d4df0c2a9563090a0c04f16873bcb0a3709
Parent:     c9ac929ddff9aec5c9951815774a7bcb5d120df9
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Sat Feb 21 08:24:30 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 23 13:22:01 2009 -0500

    We now support mounting the rootfs rw.
---
 init |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/init b/init
index ee1123c..7b0c61b 100755
--- a/init
+++ b/init
@@ -79,9 +79,10 @@ udevadm settle --timeout=30
 source_all pre-mount
 
 echo "Trying to mount rootfs $root"
+rwopt="$(getarg rw)" || rwopt="ro"
 [ -e "$root" ] || emergency_shell
 ln -s "$root" /dev/root    
-mount -o ro /dev/root $NEWROOT || emergency_shell
+mount -o $rwopt /dev/root $NEWROOT || emergency_shell
 
 INIT=$(getarg init)
 [ "$INIT" ] || {
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
