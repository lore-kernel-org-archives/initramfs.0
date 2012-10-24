From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] add 'swapoff' to initramfs to fix shutdown/reboot
Date: Wed, 24 Oct 2012 13:06:28 -0400
Message-ID: <1351098388-313-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

systemd shutdown/reboot won't work unless 'swapoff' is available.
---
 modules.d/98systemd/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98systemd/module-setup.sh
index 577bcb9..e60694e 100755
--- a/modules.d/98systemd/module-setup.sh
+++ b/modules.d/98systemd/module-setup.sh
@@ -83,7 +83,7 @@ install() {
         $systemdsystemunitdir/initrd-switch-root.target \
         $systemdsystemunitdir/initrd-switch-root.service \
         $systemdsystemunitdir/umount.target \
-        journalctl systemctl echo
+        journalctl systemctl echo swapoff
 
     if [[ $hostonly ]]; then
         dracut_install -o /etc/systemd/journald.conf \
-- 
1.7.11.7
