From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] systemd: pre-pivot hooks runs after /sysroot is mounted
Date: Fri, 16 Aug 2013 13:13:28 +0800
Message-ID: <20130816051328.GA30982@dhcp16-109.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If rootflags=nofail, sysroot.mount won't strictly run "Before"
initrd-root-fs.target. So we need to order dracut-pre-pivot after
sysroot.mount.
---
 modules.d/98systemd/dracut-pre-pivot.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/98systemd/dracut-pre-pivot.service b/modules.d/98systemd/dracut-pre-pivot.service
index 56818b9..dd4e49b 100644
--- a/modules.d/98systemd/dracut-pre-pivot.service
+++ b/modules.d/98systemd/dracut-pre-pivot.service
@@ -10,7 +10,7 @@
 [Unit]
 Description=dracut pre-pivot and cleanup hook
 Documentation=man:dracut-pre-pivot.service(8)
-After=initrd.target initrd-parse-etc.service
+After=initrd.target initrd-parse-etc.service sysroot.mount
 After=dracut-initqueue.service dracut-pre-mount.service dracut-mount.service
 Before=initrd-cleanup.service
 ConditionPathExists=/etc/initrd-release
-- 
1.8.3.1
