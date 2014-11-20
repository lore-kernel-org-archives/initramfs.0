From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 11/33] 95iscsi: Autodetect iSCSI firmware
Date: Thu, 20 Nov 2014 15:56:46 +0100
Message-ID: <1416495428-36978-12-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Wieczorkiewicz <pwieczorkiewicz-IBi9RG/b67k@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Some iSCSI initiator present firmware information in
/sys/firmware/ibft or /sys/firmware/iscsi_bootX

Whenever we detect one of those directories we should assume
that the iSCSI devices should be activated.

Also incorporates SUSE patches:
0049:
95iscsi: Use 'ip=ibft' for ibft autoconfiguration

For iBFT autoconfiguration we should be setting 'ip=ibft'
instead of rd.neednet. This should instruct dracut to only
enable the iBFT interfaces and leave the rest alone.

References: bnc#879038

0054:
95iscsi: update commandline printing

dracut has a separate callout 'cmdline' which should be used
for printing out the generated commandline.


Signed-off-by: Pavel Wieczorkiewicz <pwieczorkiewicz-IBi9RG/b67k@public.gmane.org>
Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95iscsi/module-setup.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
index 8b42d3e..5d2a39b 100755
--- a/modules.d/95iscsi/module-setup.sh
+++ b/modules.d/95iscsi/module-setup.sh
@@ -28,6 +28,21 @@ check() {
     return 0
 }
 
+install_ibft() {
+    # When iBFT / iscsi_boot is detected:
+    # - Use 'ip=ibft' to set up iBFT network interface
+    # - specify firmware booting cmdline parameter
+
+    for d in /sys/firmware/* ; do
+        if [ -d ${d}/initiator ] ; then
+            if [ ${d##*/} = "ibft" ] ; then
+                echo -n "ip=ibft "
+            fi
+            echo -n "rd.iscsi.firmware=1"
+        fi
+    done
+}
+
 # called by dracut
 depends() {
     echo network rootfs-block
@@ -37,6 +52,12 @@ depends() {
 installkernel() {
     local _arch=$(uname -m)
 
+    # Detect iBFT and perform mandatory steps
+    if [[ $hostonly_cmdline == "yes" ]] ; then
+        install_ibft > "${initdir}/etc/cmdline.d/95iscsi.conf"
+        echo >> "${initdir}/etc/cmdline.d/95iscsi.conf"
+    fi
+
     instmods bnx2i qla4xxx cxgb3i cxgb4i be2iscsi
     hostonly="" instmods iscsi_tcp iscsi_ibft crc32c iscsi_boot_sysfs
     iscsi_module_filter() {
@@ -77,6 +98,11 @@ installkernel() {
 }
 
 # called by dracut
+cmdline() {
+    install_ibft
+}
+
+# called by dracut
 install() {
     inst_multiple umount iscsistart hostname iscsi-iname
     inst_multiple -o iscsiuio
-- 
1.8.5.2
