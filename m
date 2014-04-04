From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut-pre-pivot pulls in remote-fs.target
Date: Fri,  4 Apr 2014 14:37:42 +0800
Message-ID: <1396593462-29865-1-git-send-email-chaowang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

It turns out that commit f30b74e (dracut-initqueue service runs before
remote-fs-pre.target) is partial fix for remote fs mounts. Because no
one pulls in remote-fs.target, we can never start remote fs mounts.
Now pull in remote-fs.target in dracut-pre-pivot.

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/98systemd/dracut-pre-pivot.service | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/modules.d/98systemd/dracut-pre-pivot.service b/modules.d/98systemd/dracut-pre-pivot.service
index 6db1f2c..d7c7b1d 100644
--- a/modules.d/98systemd/dracut-pre-pivot.service
+++ b/modules.d/98systemd/dracut-pre-pivot.service
@@ -13,6 +13,8 @@ Documentation=man:dracut-pre-pivot.service(8)
 After=initrd.target initrd-parse-etc.service sysroot.mount
 After=dracut-initqueue.service dracut-pre-mount.service dracut-mount.service
 Before=initrd-cleanup.service
+Wants=remote-fs.target
+After=remote-fs.target
 ConditionPathExists=/etc/initrd-release
 ConditionDirectoryNotEmpty=|/lib/dracut/hooks/pre-pivot
 ConditionDirectoryNotEmpty=|/lib/dracut/hooks/cleanup
-- 
1.8.5.3
