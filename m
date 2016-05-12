From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 08/12] NFS: Support host being a DNS ALIAS
Date: Thu, 12 May 2016 20:03:32 +0200
Message-ID: <1463076216-410-9-git-send-email-trenn@suse.com>
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

From: Fabian Vogt <fvogt-IBi9RG/b67k@public.gmane.org>

The "host" command may also print something else than
"asdf.local.lan has address 1.2.3.4", like:
"rootserver.local.net is an alias for rainbow.local.net.".
So "head -n1" is not enough.

https://bugzilla.suse.com/show_bug.cgi?id=955592
Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/95nfs/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/95nfs/module-setup.sh b/modules.d/95nfs/module-setup.sh
index c8dfa94..ed62b05 100755
--- a/modules.d/95nfs/module-setup.sh
+++ b/modules.d/95nfs/module-setup.sh
@@ -53,7 +53,7 @@ cmdline() {
     if [[ $nfs_device = [0-9]*\.[0-9]*\.[0-9]*.[0-9]* ]] || [[ $nfs_device = \[.*\] ]]; then
         nfs_address="${nfs_device%%:*}"
     else
-        lookup=$(host "${nfs_device%%:*}"| head -n1)
+        lookup=$(host "${nfs_device%%:*}"| grep " address " | head -n1)
         nfs_address=${lookup##* }
     fi
     ifname=$(ip -o route get to $nfs_address | sed -n 's/.*dev \([^ ]*\).*/\1/p')
-- 
2.1.4
