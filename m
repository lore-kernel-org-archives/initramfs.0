From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 39/42] Also export root= boot param for hostonly-cmdline case.
Date: Thu, 11 Dec 2014 15:46:30 +0100
Message-ID: <1418309193-11208-40-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

From: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

If there's a root fallback, at least attempt to have it falling
back to the last root filesystem this system ran off of.

Signed-off-by: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95rootfs-block/module-setup.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/modules.d/95rootfs-block/module-setup.sh b/modules.d/95rootfs-block/module-setup.sh
index c2f71bb..81de177 100755
--- a/modules.d/95rootfs-block/module-setup.sh
+++ b/modules.d/95rootfs-block/module-setup.sh
@@ -29,14 +29,18 @@ cmdline_journal() {
     return 0
 }
 
-# called by dracut
-cmdline() {
+cmdline_rootfs() {
     local dev=/dev/block/$(find_root_block_device)
     if [ -e $dev ]; then
         printf " root=%s" "$(shorten_persistent_dev "$(get_persistent_dev "$dev")")"
         printf " rootflags=%s" "$(find_mp_fsopts /)"
         printf " rootfstype=%s" "$(find_mp_fstype /)"
     fi
+}
+
+# called by dracut
+cmdline() {
+    cmdline_rootfs
     cmdline_journal
 }
 
@@ -45,6 +49,8 @@ install() {
     if [[ $hostonly_cmdline == "yes" ]]; then
         local _journaldev=$(cmdline_journal)
         [[ $_journaldev ]] && printf "%s\n" "$_journaldev" >> "${initdir}/etc/cmdline.d/95root-journaldev.conf"
+        local _rootdev=$(cmdline_rootfs)
+        [[ $_rootdev ]] && printf "%s\n" "$_rootdev" >> "${initdir}/etc/cmdline.d/95root-dev.conf"
     fi
 
     inst_multiple umount
-- 
1.8.5.2
