From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] systemd: add more groups to deal with tmpfiles handling.
Date: Tue,  7 Jun 2016 10:40:08 +0100
Message-ID: <20160607094008.21012-1-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

Both 'utmp' and 'root' groups are mentioned in tmpfiles.d/systemd.conf
and as such should be included.

It's probably better to have something equiv to inst_rule_group_owner()
for udev rules which parses out users and groups and adds them to the
passwd/group db respectively.

Could also rely on sysusers but as the initramfs is static in this
sense, it's more efficient to pre-define the users IMO.
---
 modules.d/00systemd/module-setup.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/modules.d/00systemd/module-setup.sh b/modules.d/00systemd/module-setup.sh
index 951a5be..abe44d8 100755
--- a/modules.d/00systemd/module-setup.sh
+++ b/modules.d/00systemd/module-setup.sh
@@ -184,6 +184,8 @@ install() {
     grep '^systemd-journal:' /etc/group >> "$initdir/etc/group"
     grep '^wheel:' /etc/group >> "$initdir/etc/group"
     grep '^adm:' /etc/group >> "$initdir/etc/group"
+    grep '^utmp:' /etc/group >> "$initdir/etc/group"
+    grep '^root:' /etc/group >> "$initdir/etc/group"
 
     ln_r $systemdutildir/systemd "/init"
     ln_r $systemdutildir/systemd "/sbin/init"
-- 
2.8.3
