From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] systemd: ensure autofs4 and ipv6 are included
Date: Mon, 16 Dec 2013 03:40:58 +0000
Message-ID: <1387165258-10335-1-git-send-email-crrodriguez@opensuse.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

Systemd tries to load this modules very early.
Even though they are not strictly required it it is a good
thing to have them around.
---
 modules.d/98systemd/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98systemd/module-setup.sh
index 748e25b..eb58158 100755
--- a/modules.d/98systemd/module-setup.sh
+++ b/modules.d/98systemd/module-setup.sh
@@ -182,6 +182,7 @@ install() {
     inst_script "$moddir/dracut-pre-pivot.sh" /bin/dracut-pre-pivot
 
     inst_rules 99-systemd.rules
+    instmods autofs4 ipv6
 
     for i in \
         emergency.target \
-- 
1.8.4
