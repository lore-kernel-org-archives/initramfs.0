From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 03/42] Fixup mdraid setup
Date: Thu, 11 Dec 2014 15:45:54 +0100
Message-ID: <1418309193-11208-4-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

This sed script to edit 64-md-raid-assemble.rules needs to
be adjusted for latest mdadm

References: bnc#866660

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90mdraid/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90mdraid/module-setup.sh b/modules.d/90mdraid/module-setup.sh
index bc4c514..ce3394a 100755
--- a/modules.d/90mdraid/module-setup.sh
+++ b/modules.d/90mdraid/module-setup.sh
@@ -86,7 +86,7 @@ install() {
     for rule in 64-md-raid.rules 64-md-raid-assembly.rules; do
         rule_path="${initdir}${udevdir}/rules.d/${rule}"
         [ -f "${rule_path}" ] && sed -i -r \
-            -e '/RUN\+?="[[:alpha:]/]*mdadm[[:blank:]]+(--incremental|-I)[[:blank:]]+(\$env\{DEVNAME\}|\$tempnode|\$devnode)/d' \
+            -e '/(RUN|IMPORT\{program\})\+?="[[:alpha:]/]*mdadm[[:blank:]]+(--incremental|-I)[[:blank:]]+(--export )?(\$env\{DEVNAME\}|\$tempnode|\$devnode)/d' \
             "${rule_path}"
     done
 
-- 
1.8.5.2
