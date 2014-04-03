From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut-initqueue service runs before remote-fs-pre.target
Date: Thu, 3 Apr 2014 15:49:26 +0800
Message-ID: <20140403074926.GA25562@dhcp-17-89.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

With the following commit, dracut doesn't mount anything from /etc/fstab

commit e920bfb
Author: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Apr 1 15:20:49 2014 +0800

    fstab: do not mount and fsck from fstab if using systemd

But systemd doesn't mount nfs at all, because no unit is pulling in
remote-fs.target.

dracut must pull in these remote fs mount and all these remote mounts
should start only after network is up (ie. after dracut-initqueue).

Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/98systemd/dracut-initqueue.service | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/modules.d/98systemd/dracut-initqueue.service b/modules.d/98systemd/dracut-initqueue.service
index 03dcc4e..1b9e701 100644
--- a/modules.d/98systemd/dracut-initqueue.service
+++ b/modules.d/98systemd/dracut-initqueue.service
@@ -11,6 +11,8 @@
 Description=dracut initqueue hook
 Documentation=man:dracut-initqueue.service(8)
 DefaultDependencies=no
+Before=remote-fs-pre.target
+Wants=remote-fs-pre.target
 After=systemd-udev-trigger.service
 Wants=systemd-udev-trigger.service
 ConditionPathExists=/etc/initrd-release
-- 
1.8.5.3
