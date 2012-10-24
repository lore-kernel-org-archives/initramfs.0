From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drop NEWROOT from module-setup.sh
Date: Wed, 24 Oct 2012 13:06:11 -0400
Message-ID: <1351098371-32307-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This was almost certainly copy-pasted from mount-root.sh, but it's not
valid here - dracut doesn't use NEWROOT outside of the initramfs.
---
 modules.d/95rootfs-block/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/95rootfs-block/module-setup.sh b/modules.d/95rootfs-block/module-setup.sh
index 8254289..732aefb 100755
--- a/modules.d/95rootfs-block/module-setup.sh
+++ b/modules.d/95rootfs-block/module-setup.sh
@@ -15,7 +15,7 @@ check() {
                 rootopts=$opts
                 break
             fi
-        done < "$NEWROOT/etc/fstab"
+        done < /etc/fstab
 
         [ "$rootfs" = "reiserfs" ] && journaldev=$(fs_get_option $rootopts "jdev")
         [ "$rootfs" = "xfs" ] && journaldev=$(fs_get_option $rootopts "logdev")
-- 
1.7.11.7
