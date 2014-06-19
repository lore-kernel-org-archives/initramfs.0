From: Daniel Schaal <farbing-S0/GAf8tV78@public.gmane.org>
Subject: [PATCH] 98systemd: also install systemd-journald-dev-log.socket
Date: Thu, 19 Jun 2014 11:38:25 +0200
Message-ID: <1403170705-1936-1-git-send-email-farbing@web.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Daniel Schaal <farbing-S0/GAf8tV78@public.gmane.org>

The /dev/log socket was moved to /run on systemd 214, install the
newly added socket unit.
---
 modules.d/98systemd/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98systemd/module-setup.sh
index cf1b2e7..bf3f4b1 100755
--- a/modules.d/98systemd/module-setup.sh
+++ b/modules.d/98systemd/module-setup.sh
@@ -106,6 +106,7 @@ install() {
         $systemdsystemunitdir/sockets.target.wants/systemd-udevd-control.socket \
         $systemdsystemunitdir/sockets.target.wants/systemd-udevd-kernel.socket \
         $systemdsystemunitdir/sockets.target.wants/systemd-journald.socket \
+        $systemdsystemunitdir/sockets.target.wants/systemd-journald-dev-log.socket \
         $systemdsystemunitdir/sysinit.target.wants/systemd-udevd.service \
         $systemdsystemunitdir/sysinit.target.wants/systemd-udev-trigger.service \
         $systemdsystemunitdir/sysinit.target.wants/kmod-static-nodes.service \
-- 
2.0.0
