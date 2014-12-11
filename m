From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 30/42] 95fcoe: update fcoe interface check
Date: Thu, 11 Dec 2014 15:46:21 +0100
Message-ID: <1418309193-11208-31-git-send-email-trenn@suse.de>
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

The 'create' sysfs entry has been removed for newer fcoe modules,
so just check if the module directory exists.

References: bnc#877288

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95fcoe/parse-fcoe.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/modules.d/95fcoe/parse-fcoe.sh b/modules.d/95fcoe/parse-fcoe.sh
index 59de56f..9604503 100755
--- a/modules.d/95fcoe/parse-fcoe.sh
+++ b/modules.d/95fcoe/parse-fcoe.sh
@@ -20,14 +20,11 @@
 
 
 # BRCM: Later, should check whether bnx2x is loaded first before loading bnx2fc so do not load bnx2fc when there are no Broadcom adapters
-[ -e /sys/module/fcoe/parameters/create ] || modprobe -a fcoe || die "FCoE requested but kernel/initrd does not support FCoE"
+[ -d /sys/module/fcoe ] || modprobe -a fcoe || die "FCoE requested but kernel/initrd does not support FCoE"
 
 modprobe bnx2fc >/dev/null 2>&1
 udevadm settle --timeout=30
 
-# FCoE actually supported?
-[ -e /sys/module/fcoe/parameters/create ] || modprobe fcoe || die "FCoE requested but kernel/initrd does not support FCoE"
-
 parse_fcoe_opts() {
     local IFS=:
     set $fcoe
-- 
1.8.5.2
