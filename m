From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] 90multipath: added kpartx.rules; multipath.rules - different prefix
Date: Thu, 26 Jul 2012 11:38:04 +0200
Message-ID: <1343295484-20678-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 modules.d/90multipath/module-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
index 5944d25..69c4441 100755
--- a/modules.d/90multipath/module-setup.sh
+++ b/modules.d/90multipath/module-setup.sh
@@ -85,6 +85,6 @@ install() {
 
     inst_hook pre-trigger 02 "$moddir/multipathd.sh"
     inst_hook cleanup   02 "$moddir/multipathd-stop.sh"
-    inst_rules 40-multipath.rules
+    inst_rules 40-multipath.rules 65-multipath.rules 66-kpartx.rules
 }
 
-- 
1.7.8.6
