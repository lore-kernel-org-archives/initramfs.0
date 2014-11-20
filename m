From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 08/33] 90multipath: Install libgcc_s library
Date: Thu, 20 Nov 2014 15:56:43 +0100
Message-ID: <1416495428-36978-9-git-send-email-trenn@suse.de>
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

multipathd is using pthreads, which require libgcc_s for
pthread_cancel to work. Without it multipathd might crash
with SIGABRT.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90multipath/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
index 3c2e3a9..7a60b2e 100755
--- a/modules.d/90multipath/module-setup.sh
+++ b/modules.d/90multipath/module-setup.sh
@@ -87,6 +87,7 @@ install() {
     inst $(command -v partx) /sbin/partx
 
     inst_libdir_file "libmultipath*" "multipath/*"
+    inst_libdir_file 'libgcc_s.so*'
 
     if dracut_module_included "systemd"; then
         inst_multiple \
-- 
1.8.5.2
