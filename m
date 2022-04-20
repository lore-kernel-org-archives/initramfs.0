From: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
Subject: [PATCH] dracut: dmsquash-live: overlay module can be built-in the kernel
Date: Wed, 20 Apr 2022 09:15:23 +0200
Message-ID: <20220420071523.1185188-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgYLS/vQ5cEKhuxTs8r7IEeOVDEahkAj9avXkU5rKU4=;
 b=LtzJx0jaJ6cQtERRUPl772gapU+pYiOH+c82S8X5vFwt3avIZBJHbwV4t/hyTFE1gHZzaVnRo7bOE+qtaBwsbFPOOAx+tgXC12Am3oRV8p3+azLENBxt3V3v1m3Bz9VjgEEF+ff4B4j0PEQ/DMiYIov+7hilztvsF1dyGXnKaKU=
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: federico.vaga-vJEk5272eHo@public.gmane.org

The dmsquash-live module assumes that `overlay` is always a module.
Therefore, when `overlay` is built-in the kernel, this module will fail
to detect the presence of such a feature.

This patch adds a fallback mechanism to check also `/proc/filesystem`.
This is also what happens with the dracut NSF module when loading the
kernel module `rpc_pipefs`.

Signed-off-by: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
---
 modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index fd8a858a..b4a44e92 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -170,7 +170,7 @@ do_live_overlay() {
         fi
     fi
     if [ -n "$overlayfs" ]; then
-        if ! modprobe overlay; then
+        if ! (modprobe overlay || strstr "$(cat /proc/filesystems)" overlay); then
             if [ "$overlayfs" = required ]; then
                 die "OverlayFS is required but not available."
                 exit 1
-- 
2.27.0

