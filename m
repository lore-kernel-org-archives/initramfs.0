From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 36/42] 99base: Add chown binary
Date: Thu, 11 Dec 2014 15:46:27 +0100
Message-ID: <1418309193-11208-37-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

nvidia driver needs this via modprobe script.
Needs to do change the group after a device node got created.
Add chown instead of chgrp which can also change the owner of a file.

Ask Stefand Dirsch <sndirsch-l3A5Bk7waGM@public.gmane.org> for details.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/99base/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index 7d30320..a1046af 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -15,7 +15,7 @@ depends() {
 install() {
     local _d
 
-    inst_multiple mount mknod mkdir sleep chroot \
+    inst_multiple mount mknod mkdir sleep chroot chown \
         sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink setsid
     inst $(command -v modprobe) /sbin/modprobe
 
-- 
1.8.5.2
