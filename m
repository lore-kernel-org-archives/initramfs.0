From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 06/10] add rm to be installed for initqueue
Date: Fri,  3 Jul 2009 18:45:16 +0200
Message-ID: <1246639520-3094-7-git-send-email-harald@redhat.com>
References: <1246639520-3094-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246639520-3094-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/99base/install |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/install b/modules.d/99base/install
index 4ecba9c..3f5b29a 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -1,5 +1,6 @@
 #!/bin/bash
-dracut_install mount mknod mkdir modprobe pidof sleep chroot sed ls flock cp mv dmesg 
+dracut_install mount mknod mkdir modprobe pidof sleep chroot \
+    sed ls flock cp mv dmesg rm
 if [ ! -e "${initdir}/bin/sh" ]; then
     dracut_install bash
     (ln -s bash "${initdir}/bin/sh" || :)
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
