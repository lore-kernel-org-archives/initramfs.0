From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 12/33] 95iscsi: Install libgcc_s library
Date: Thu, 20 Nov 2014 15:56:47 +0100
Message-ID: <1416495428-36978-13-git-send-email-trenn@suse.de>
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

iscsiuio is using pthread, which requires libgcc_s for
pthread_cancel to work.
Without this library iscsiuio will crash with SIGABRT.

References: bnc#881692

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95iscsi/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
index 5d2a39b..3641fb8 100755
--- a/modules.d/95iscsi/module-setup.sh
+++ b/modules.d/95iscsi/module-setup.sh
@@ -106,6 +106,7 @@ cmdline() {
 install() {
     inst_multiple umount iscsistart hostname iscsi-iname
     inst_multiple -o iscsiuio
+    inst_libdir_file 'libgcc_s.so*'
     inst_hook cmdline 90 "$moddir/parse-iscsiroot.sh"
     inst_hook cleanup 90 "$moddir/cleanup-iscsi.sh"
     inst "$moddir/iscsiroot.sh" "/sbin/iscsiroot"
-- 
1.8.5.2
