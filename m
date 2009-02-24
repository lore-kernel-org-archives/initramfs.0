From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Support rootflags and rootfstype kernel parameters.
Date: Tue, 24 Feb 2009 05:00:12 GMT
Message-ID: <200902240500.n1O50Cmr011162@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=9689f4c8cefc72f7d95d22d557765da9acb1f883
Commit:     9689f4c8cefc72f7d95d22d557765da9acb1f883
Parent:     945a2d4df0c2a9563090a0c04f16873bcb0a3709
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Sat Feb 21 08:24:35 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 23 13:22:01 2009 -0500

    Support rootflags and rootfstype kernel parameters.
    
    This also folds in support for ro and rw flags.
---
 init |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/init b/init
index 7b0c61b..581c2b9 100755
--- a/init
+++ b/init
@@ -79,10 +79,16 @@ udevadm settle --timeout=30
 source_all pre-mount
 
 echo "Trying to mount rootfs $root"
-rwopt="$(getarg rw)" || rwopt="ro"
+if rflags="$(getarg rootflags)"; then
+    rflags="${rflags#rootflags=}"
+    getarg rw >/dev/null && rflags="${rflags},rw" || rflags="${rflags},ro"
+else
+     getarg rw >/dev/null && rflags=rw || rflags=ro
+fi
 [ -e "$root" ] || emergency_shell
-ln -s "$root" /dev/root    
-mount -o $rwopt /dev/root $NEWROOT || emergency_shell
+ln -s "$root" /dev/root 
+fstype="$(getarg rootfstype)" && fstype="-t ${fstype#rootfstype=}" 
+mount $fstype -o $rflags /dev/root $NEWROOT || emergency_shell
 
 INIT=$(getarg init)
 [ "$INIT" ] || {
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
