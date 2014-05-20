From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] 98systemd: fixup rootfs-generator installation path
Date: Tue, 20 May 2014 11:20:10 +0200
Message-ID: <1400577610-119478-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

The rootfs-generator was installed in the wrong path
in the initrd, cause it never to be run.

References: bnc#878714

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/98systemd/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98systemd/module-setup.sh
index e14ce39..4516b9a 100755
--- a/modules.d/98systemd/module-setup.sh
+++ b/modules.d/98systemd/module-setup.sh
@@ -192,7 +192,7 @@ install() {
     inst_script "$moddir/dracut-mount.sh" /bin/dracut-mount
     inst_script "$moddir/dracut-pre-pivot.sh" /bin/dracut-pre-pivot
 
-    inst_script "$moddir/rootfs-generator.sh" /lib/systemd/system-generators/dracut-rootfs-generator
+    inst_script "$moddir/rootfs-generator.sh" $systemdutildir/system-generators/dracut-rootfs-generator
 
     inst_binary true
     ln_r $(type -P true) "/usr/bin/loginctl"
-- 
1.8.5.2
