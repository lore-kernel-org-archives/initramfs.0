From: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 12/12] multipath: Fix warning about multipath if not needed
Date: Thu, 12 May 2016 20:03:36 +0200
Message-ID: <1463076216-410-13-git-send-email-trenn@suse.com>
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

Although no device uses multipath, the module checks
for presence of the multipath binary first, printing a
warning if not present. This patch fixes the wrong ordering.

Signed-off-by: Thomas Renninger <trenn-IBi9RG/b67k@public.gmane.org>
---
 modules.d/90multipath/module-setup.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/modules.d/90multipath/module-setup.sh b/modules.d/90multipath/module-setup.sh
index 1676798..db91296 100755
--- a/modules.d/90multipath/module-setup.sh
+++ b/modules.d/90multipath/module-setup.sh
@@ -21,13 +21,14 @@ majmin_to_mpath_dev() {
 # called by dracut
 check() {
     local _rootdev
-    # if there's no multipath binary, no go.
-    require_binaries multipath || return 1
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
         for_each_host_dev_and_slaves is_mpath || return 255
     }
 
+    # if there's no multipath binary, no go.
+    require_binaries multipath || return 1
+
     return 0
 }
 
-- 
2.1.4
