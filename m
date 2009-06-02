From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] install cat for network module
Date: Tue,  2 Jun 2009 13:41:40 +0200
Message-ID: <1243942901-5474-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
 modules.d/40network/install |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/install b/modules.d/40network/install
index 3a06f79..d480391 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -1,5 +1,5 @@
 #!/bin/bash
-dracut_install ip dhclient hostname
+dracut_install ip dhclient hostname cat
 # Include wired net drivers, excluding wireless
 for modname in `find "/lib/modules/$kernel/kernel/drivers" -name '*.ko'`; do
   if nm -uPA $modname | grep -q eth_type_trans; then
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
