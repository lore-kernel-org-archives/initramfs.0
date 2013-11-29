From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 02/13] 95dasd: Only install module if normalize_dasd_arg is present
Date: Fri, 29 Nov 2013 13:13:43 +0100
Message-ID: <1385727234-5001-3-git-send-email-hare@suse.de>
References: <1385727234-5001-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385727234-5001-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

normalize_dasd_arg is a RedHat specific script, so no point
installing this module if the script isn't present.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95dasd/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/95dasd/module-setup.sh b/modules.d/95dasd/module-setup.sh
index 16207bc..9c93d40 100755
--- a/modules.d/95dasd/module-setup.sh
+++ b/modules.d/95dasd/module-setup.sh
@@ -5,6 +5,7 @@
 # called by dracut
 check() {
     local _arch=$(uname -m)
+    [ -x /sbin/normalize_dasd_arg ] || return 1
     [ "$_arch" = "s390" -o "$_arch" = "s390x" ] || return 1
     return 0
 }
-- 
1.8.1.4
