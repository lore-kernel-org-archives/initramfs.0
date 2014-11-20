From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 16/33] 95iscsi: More empty cmdline fixes
Date: Thu, 20 Nov 2014 15:56:51 +0100
Message-ID: <1416495428-36978-17-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

This fixes up some 95iscsi/module-setup.sh which might print out empty
commandline files.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95iscsi/module-setup.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
index d30e64f..29bba82 100755
--- a/modules.d/95iscsi/module-setup.sh
+++ b/modules.d/95iscsi/module-setup.sh
@@ -76,12 +76,6 @@ depends() {
 installkernel() {
     local _arch=$(uname -m)
 
-    # Detect iBFT and perform mandatory steps
-    if [[ $hostonly_cmdline == "yes" ]] ; then
-        install_ibft > "${initdir}/etc/cmdline.d/95iscsi.conf"
-        echo >> "${initdir}/etc/cmdline.d/95iscsi.conf"
-    fi
-
     instmods bnx2i qla4xxx cxgb3i cxgb4i be2iscsi
     hostonly="" instmods iscsi_tcp iscsi_ibft crc32c iscsi_boot_sysfs
     iscsi_module_filter() {
@@ -131,6 +125,13 @@ install() {
     inst_multiple umount iscsistart hostname iscsi-iname
     inst_multiple -o iscsiuio
     inst_libdir_file 'libgcc_s.so*'
+
+    # Detect iBFT and perform mandatory steps
+    if [[ $hostonly_cmdline == "yes" ]] ; then
+        local _ibftconf=$(install_ibft)
+        [[ $_ibftconf ]] && printf "%s\n" "$_ibftconf" >> "${initdir}/etc/cmdline.d/95iscsi.conf"
+    fi
+
     inst_hook cmdline 90 "$moddir/parse-iscsiroot.sh"
     inst_hook cleanup 90 "$moddir/cleanup-iscsi.sh"
     inst "$moddir/iscsiroot.sh" "/sbin/iscsiroot"
-- 
1.8.5.2
