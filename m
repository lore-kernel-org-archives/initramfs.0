From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 10/12] fcoe-uefi: Add check for usage
Date: Thu, 12 May 2016 20:03:34 +0200
Message-ID: <1463076216-410-11-git-send-email-trenn@suse.com>
References: <1463076216-410-1-git-send-email-trenn@suse.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463076216-410-1-git-send-email-trenn-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.blume-IBi9RG/b67k@public.gmane.org, pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org, hare-IBi9RG/b67k@public.gmane.org, fvogt-IBi9RG/b67k@public.gmane.org, trenn-IBi9RG/b67k@public.gmane.org

From: Fabian Vogt <fvogt-IBi9RG/b67k@public.gmane.org>

References:
https://bugzilla.suse.com/show_bug.cgi?id=965477

fcoe-uefi gets included by default on EFI systems,
as it does not do the same check that fcoe does,
therefore needlessly pulling in network modules.
This patch copies the check from fcoe to fcoe-uefi.

Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/95fcoe-uefi/module-setup.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/modules.d/95fcoe-uefi/module-setup.sh b/modules.d/95fcoe-uefi/module-setup.sh
index 5d8477c..66af804 100755
--- a/modules.d/95fcoe-uefi/module-setup.sh
+++ b/modules.d/95fcoe-uefi/module-setup.sh
@@ -4,6 +4,11 @@
 check() {
     [[ $hostonly ]] || [[ $mount_needs ]] && {
         [ -d /sys/firmware/efi ] || return 255
+        for c in /sys/bus/fcoe/devices/ctlr_* ; do
+            [ -L $c ] || continue
+            fcoe_ctlr=$c
+        done
+        [ -z "$fcoe_ctlr" ] && return 255
     }
     require_binaries dcbtool fipvlan lldpad ip readlink || return 1
     return 0
-- 
2.1.4
