From: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Subject: [PATCH] Search in for KMS-capable drivers in extra/ as well
Date: Fri, 19 Nov 2010 18:32:30 +0100
Message-ID: <1290187950-6598-1-git-send-email-lkundrak@v3.sk>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>

User can have an out-of-tree video driver supporting KMS installed;
Intel GMA500 drivers from RPM Fusion are one example of such module.
---
 modules.d/50plymouth/installkernel |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/50plymouth/installkernel b/modules.d/50plymouth/installkernel
index d84eee9..61a8dfb 100755
--- a/modules.d/50plymouth/installkernel
+++ b/modules.d/50plymouth/installkernel
@@ -2,6 +2,6 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 # Include KMS capable drm drivers
-for modname in $(find "$srcmods/kernel/drivers/gpu/drm" -name '*.ko' 2>/dev/null); do
+for modname in $(find "$srcmods/kernel/drivers/gpu/drm" "$srcmods/extra" -name '*.ko' 2>/dev/null); do
     grep -q drm_crtc_init  $modname && instmods $modname
 done
-- 
1.7.3.2
