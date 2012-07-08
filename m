From: Mark Hamzy <hamzy-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] fix readonly prefix
Date: Sun,  8 Jul 2012 12:36:29 -0500
Message-ID: <1341768989-50296-1-git-send-email-hamzy@us.ibm.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Hamzy <hamzy-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

If no prefix is specified on the command line, then the following is seen:
/sbin/dracut: line 548: unset: prefix: cannot unset: readonly variable

---
 dracut.conf.d/fedora.conf.example |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut.conf.d/fedora.conf.example b/dracut.conf.d/fedora.conf.example
index ee53844..4cb1890 100644
--- a/dracut.conf.d/fedora.conf.example
+++ b/dracut.conf.d/fedora.conf.example
@@ -5,7 +5,7 @@ i18n_vars="/etc/sysconfig/keyboard:KEYTABLE-KEYMAP /etc/sysconfig/i18n:SYSFONT-F
 omit_drivers+=" .*/fs/ocfs/.* "
 stdloglvl=3
 install_items+=" vi /etc/virc ps grep cat rm "
-readonly prefix="/"
+prefix="/"
 systemdutildir=/usr/lib/systemd
 systemdsystemunitdir=/usr/lib/systemd/system
 udevdir=/usr/lib/udev
-- 
1.7.10.4
