From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 04/42] 95udev-rules: Include correct sg3_utils rules
Date: Thu, 11 Dec 2014 15:45:55 +0100
Message-ID: <1418309193-11208-5-git-send-email-trenn@suse.de>
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

sg3_utils now provides two rules 55-scsi-sg3_id.rules and
58-scsi-sg3_symlink.rules, which need to be included instead
of the older 59-scsi-sg3_utils.rules.

References: bnc#873151

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95udev-rules/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/95udev-rules/module-setup.sh b/modules.d/95udev-rules/module-setup.sh
index 9d6f960..e50709d 100755
--- a/modules.d/95udev-rules/module-setup.sh
+++ b/modules.d/95udev-rules/module-setup.sh
@@ -31,6 +31,7 @@ install() {
         50-udev.rules 95-late.rules \
         50-firmware.rules \
         59-scsi-sg3_utils.rules \
+        55-scsi-sg3_id.rules 58-scsi-sg3_symlink.rules \
         70-uaccess.rules 71-seat.rules 73-seat-late.rules \
         75-net-description.rules \
         80-net-name-slot.rules 80-net-setup-link.rules \
-- 
1.8.5.2
