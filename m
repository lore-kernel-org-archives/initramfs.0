From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/8] Fix nfs parsing when IPv4 address is used in /etc/fstab
Date: Fri, 26 Jun 2015 16:55:51 +0200
Message-ID: <1435330557-17685-3-git-send-email-trenn@suse.de>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435330557-17685-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

and remove an unneeded subprocess.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95nfs/module-setup.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/95nfs/module-setup.sh b/modules.d/95nfs/module-setup.sh
index 8eb542c..3f30285 100755
--- a/modules.d/95nfs/module-setup.sh
+++ b/modules.d/95nfs/module-setup.sh
@@ -51,9 +51,9 @@ cmdline() {
 
     ### ip= ###
     if [[ $nfs_device = [0-9]*\.[0-9]*\.[0-9]*.[0-9]* ]] || [[ $nfs_device = \[.*\] ]]; then
-        nfs_address="$nfs_device"
+        nfs_address="${nfs_device%%:*}"
     else
-        lookup=$(host $(echo ${nfs_device%%:*})| head -n1)
+        lookup=$(host "${nfs_device%%:*}"| head -n1)
         nfs_address=${lookup##* }
     fi
     ifname=$(ip -o route get to $nfs_address | sed -n 's/.*dev \([^ ]*\).*/\1/p')
-- 
2.1.4
