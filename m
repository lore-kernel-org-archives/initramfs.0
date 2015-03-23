From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 4/4] 95fcoe-uefi: Test for EFI firmware
Date: Mon, 23 Mar 2015 17:12:18 +0100
Message-ID: <1427127138-12932-5-git-send-email-trenn@suse.de>
References: <1427127138-12932-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427127138-12932-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

The fcoe-uefi module should test for EFI firmware when called
in 'hostonly' mode; of no EFI firmware is found then the module
doesn't need to be included.

References: bnc#882412

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95fcoe-uefi/module-setup.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/modules.d/95fcoe-uefi/module-setup.sh b/modules.d/95fcoe-uefi/module-setup.sh
index 8b8c810..5d8477c 100755
--- a/modules.d/95fcoe-uefi/module-setup.sh
+++ b/modules.d/95fcoe-uefi/module-setup.sh
@@ -2,6 +2,9 @@
 
 # called by dracut
 check() {
+    [[ $hostonly ]] || [[ $mount_needs ]] && {
+        [ -d /sys/firmware/efi ] || return 255
+    }
     require_binaries dcbtool fipvlan lldpad ip readlink || return 1
     return 0
 }
-- 
2.1.4
