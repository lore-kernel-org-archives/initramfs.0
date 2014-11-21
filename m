From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 11/15] Fix non-export of journal dev boot options.
Date: Fri, 21 Nov 2014 14:20:47 +0100
Message-ID: <1416576051-62838-12-git-send-email-trenn@suse.de>
References: <1416576051-62838-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416576051-62838-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

From: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

cmdline_journal does not contain linefeeds anymore, so read
silently skipped it altogether.

Signed-off-by: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95rootfs-block/module-setup.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/modules.d/95rootfs-block/module-setup.sh b/modules.d/95rootfs-block/module-setup.sh
index 258b32f..c2f71bb 100755
--- a/modules.d/95rootfs-block/module-setup.sh
+++ b/modules.d/95rootfs-block/module-setup.sh
@@ -43,9 +43,8 @@ cmdline() {
 # called by dracut
 install() {
     if [[ $hostonly_cmdline == "yes" ]]; then
-        cmdline_journal | while read journaldev; do
-            [[ $journaldev ]] && printf "%s\n" "$journaldev" >> "${initdir}/etc/cmdline.d/95root-journaldev.conf"
-        done
+        local _journaldev=$(cmdline_journal)
+        [[ $_journaldev ]] && printf "%s\n" "$_journaldev" >> "${initdir}/etc/cmdline.d/95root-journaldev.conf"
     fi
 
     inst_multiple umount
-- 
1.8.5.2
