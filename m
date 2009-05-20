From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] module-init-tools only recognizes files ending in *.conf,
 so only copy files of that pattern.
Date: Wed, 20 May 2009 15:37:06 -0400
Message-ID: <4A145BE2.7090700@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

 From a21e155e3f701b60f4f0f63fb4a596613af4b843 Mon Sep 17 00:00:00 2001
From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Wed, 20 May 2009 15:35:23 -0400
Subject: [PATCH] module-init-tools only recognizes files ending in *.conf, so only copy files of that pattern.

---
  modules.d/90kernel-modules/install |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90kernel-modules/install b/modules.d/90kernel-modules/install
index 6e7c02d..a0f894b 100755
--- a/modules.d/90kernel-modules/install
+++ b/modules.d/90kernel-modules/install
@@ -8,4 +8,4 @@ while read d mp t rest; do
  done </proc/mounts
  
  [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
-dracut_install $(find /etc/modprobe.d/ -type f )
+dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
