From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 07/33] 90multipath: install correct multipath rules
Date: Thu, 20 Nov 2014 15:56:42 +0100
Message-ID: <1416495428-36978-8-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

The multipath and kpartx rules have different numbers in SUSE.

The 11-dm-mpath.rules file had been missing, causing
blacklisting to not work properly.

References: bnc#873151, bnc#872662, bnc#883149

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90multipath/module-setup.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
index c86c5d9..3c2e3a9 100755
--- a/modules.d/90multipath/module-setup.sh
+++ b/modules.d/90multipath/module-setup.sh
@@ -100,6 +100,9 @@ install() {
 
     inst_hook cleanup   80 "$moddir/multipathd-needshutdown.sh"
 
-    inst_rules 40-multipath.rules 62-multipath.rules 65-multipath.rules 66-kpartx.rules
+    inst_rules 40-multipath.rules 56-multipath.rules \
+	62-multipath.rules 65-multipath.rules \
+	66-kpartx.rules 67-kpartx-compat.rules \
+	11-dm-mpath.rules
 }
 
-- 
1.8.5.2
