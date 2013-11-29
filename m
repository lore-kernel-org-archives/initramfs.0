From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 04/13] 95zfcp: Make installation optional
Date: Fri, 29 Nov 2013 13:13:45 +0100
Message-ID: <1385727234-5001-5-git-send-email-hare@suse.de>
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

zfcp_cio_free is a RedHat-specific tool, so do not install this
module if the program isn't present.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95zfcp/module-setup.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/modules.d/95zfcp/module-setup.sh b/modules.d/95zfcp/module-setup.sh
index 5d9b506..dfbeed5 100755
--- a/modules.d/95zfcp/module-setup.sh
+++ b/modules.d/95zfcp/module-setup.sh
@@ -5,6 +5,7 @@
 # called by dracut
 check() {
     arch=$(uname -m)
+    [ -x /sbin/zfcp_cio_free ] || return 1
     [ "$arch" = "s390" -o "$arch" = "s390x" ] || return 1
 
     return 0
@@ -12,9 +13,6 @@ check() {
 
 # called by dracut
 depends() {
-    arch=$(uname -m)
-    [ "$arch" = "s390" -o "$arch" = "s390x" ] || return 1
-
     return 0
 }
 
-- 
1.8.1.4
