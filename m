From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] fstab: do not mount and fsck from fstab if using systemd
Date: Tue, 1 Apr 2014 13:19:13 +0800
Message-ID: <20140401051913.GA644@dhcp-17-89.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If using systemd in initramfs, we could run into a race condition when
dracut and systemd both are trying to mount and run fsck for the same
filesystem, and mount or fsck could be a failure.

To fix such failure, we should use systemd to mount/fsck from /etc/fstab
only.

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95fstab-sys/mount-sys.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/modules.d/95fstab-sys/mount-sys.sh b/modules.d/95fstab-sys/mount-sys.sh
index 12711a0..d65cafd 100755
--- a/modules.d/95fstab-sys/mount-sys.sh
+++ b/modules.d/95fstab-sys/mount-sys.sh
@@ -27,7 +27,11 @@ fstab_mount() {
     return 0
 }
 
-[ -f /etc/fstab ] && fstab_mount /etc/fstab
+# systemd will mount and run fsck from /etc/fstab and we don't want to
+# run into a race condition.
+if [ `readlink -f /init` != '/usr/lib/systemd/systemd' ]; then
+    [ -f /etc/fstab ] && fstab_mount /etc/fstab
+fi
 
 # prefer $NEWROOT/etc/fstab.sys over local /etc/fstab.sys
 if [ -f $NEWROOT/etc/fstab.sys ]; then
-- 
1.8.5.3
