From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 07/12] nfs: Fix nfs rootfs in case of mounting via IPv4 not hostname
Date: Thu, 12 May 2016 20:03:31 +0200
Message-ID: <1463076216-410-8-git-send-email-trenn@suse.com>
References: <1463076216-410-1-git-send-email-trenn@suse.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463076216-410-1-git-send-email-trenn-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.blume-IBi9RG/b67k@public.gmane.org, pwieczorkiewicz-l3A5Bk7waGM@public.gmane.org, hare-IBi9RG/b67k@public.gmane.org, fvogt-IBi9RG/b67k@public.gmane.org, trenn-IBi9RG/b67k@public.gmane.org

https://bugzilla.suse.com/show_bug.cgi?id=931307
Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/95nfs/module-setup.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/95nfs/module-setup.sh b/modules.d/95nfs/module-setup.sh
index 9767e57..c8dfa94 100755
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
