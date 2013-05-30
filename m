From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [PATCH]selinux: load_policy script fix
Date: Thu, 30 May 2013 14:19:00 +0800
Message-ID: <51a6ef54.GAPY7ltVyx5aFKm7%dyoung@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

chroot load_policy will use selinuxfs which should be mounted
in $NEWROOT/sys/fs/selinux for Fedora 19, but because there's
no $NEWROOT/sys/fs, so later process will fail.

Fixing this by bind mount /sys to $NEWROOT/sys.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/98selinux/selinux-loadpolicy.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- dracut.orig/modules.d/98selinux/selinux-loadpolicy.sh
+++ dracut/modules.d/98selinux/selinux-loadpolicy.sh
@@ -24,7 +24,8 @@ rd_load_policy()
         local ret=0
         local out
         info "Loading SELinux policy"
-        # load_policy does mount /proc and /selinux in
+        mount -o bind /sys $NEWROOT/sys
+        # load_policy does mount /proc and /sys/fs/selinux in
         # libselinux,selinux_init_load_policy()
         if [ -x "$NEWROOT/sbin/load_policy" ]; then
             out=$(LANG=C chroot "$NEWROOT" /sbin/load_policy -i 2>&1)
@@ -35,6 +36,8 @@ rd_load_policy()
             ret=$?
             info $out
         fi
+        umount $NEWROOT/sys/fs/selinux
+        umount $NEWROOT/sys
 
         if [ "$SELINUX" = "disabled" ]; then
             return 0;
