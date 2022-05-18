From: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
Subject: [PATCH v2] dracut: dmsquash-live: overlay module can be built-in the kernel
Date: Wed, 18 May 2022 11:47:07 +0200
Message-ID: <20220518094707.943732-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr7AleePNhw8E/8Jj/GY6Fy+1cElKsUwmSMx89DyOR4=;
 b=CpBCN1RZsJVCAajb3NT1g28XqSkdoCQ00Hhzm8A7YwEAU7E9pQAv461fH0+U62nfbkGfZgv7N47AevOaDJMRTtgVc3mEsi/L9TrbY5SJ8oyl5IhcR3E9EJ+C+WkRr4gI7m94THIPTFmHHBU0L2nGqrcJC9uV05i3AelLngCTF8E=
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: German Maglione <gmaglione-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>

The dmsquash-live module assumes that `overlay` is always a module.
Therefore, when `overlay` is built-in the kernel, this module will fail
to detect the presence of such a feature.

This patch adds a fallback mechanism to check also `/proc/filesystem`.
This is also what happens with the dracut NSF module when loading the
kernel module `rpc_pipefs`.

Signed-off-by: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
---
 v1 -> v2: do not use unnecessary sub-shell in the if statement

 modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index fd8a858a..f68a979c 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -170,7 +170,7 @@ do_live_overlay() {
         fi
     fi
     if [ -n "$overlayfs" ]; then
-        if ! modprobe overlay; then
+        if ! { modprobe overlay || strstr "$(cat /proc/filesystems)" overlay; }; then
             if [ "$overlayfs" = required ]; then
                 die "OverlayFS is required but not available."
                 exit 1
-- 
2.27.0

