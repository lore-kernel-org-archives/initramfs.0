From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 06/10] Install /bin/mount
Date: Wed, 27 Nov 2013 16:44:17 +0100
Message-ID: <1385567061-13247-7-git-send-email-hare@suse.de>
References: <1385567061-13247-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385567061-13247-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

systemd relies on /bin/mount to be present, so install it.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/99fs-lib/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/99fs-lib/module-setup.sh b/modules.d/99fs-lib/module-setup.sh
index 7979bab..b24207d 100755
--- a/modules.d/99fs-lib/module-setup.sh
+++ b/modules.d/99fs-lib/module-setup.sh
@@ -85,4 +85,5 @@ install() {
     fi
 
     inst_multiple -o $_helpers fsck
+    inst /usr/bin/mount /bin/mount
 }
-- 
1.8.1.4
