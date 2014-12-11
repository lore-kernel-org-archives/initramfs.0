From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 10/42] 95iscsi: Fixup bnx2i offload booting
Date: Thu, 11 Dec 2014 15:46:01 +0100
Message-ID: <1418309193-11208-11-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

bnx2i is using a separate iSCSI offload engine with a separate
MAC address. As a result, the iBFT information is displaying
a MAC address which does not relate to any MAC address from
the network interfaces.
In addition, the iSCSI offload engine works independently on
the NIC, so we do not need to enable the NIC for iSCSI offload
to work.
This patch modifies the automatic iBFT detection to not set
the 'ip=ibft' flag when bnx2i offload is detected.

References: bnc#855747

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95iscsi/module-setup.sh | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
index 3641fb8..d30e64f 100755
--- a/modules.d/95iscsi/module-setup.sh
+++ b/modules.d/95iscsi/module-setup.sh
@@ -28,14 +28,38 @@ check() {
     return 0
 }
 
+get_ibft_mod() {
+    local ibft_mac=$1
+    # Return the iSCSI offload module for a given MAC address
+    iscsiadm -m iface | while read iface_name iface_desc ; do
+        IFS=$','
+        set -- $iface_desc
+        if [ "$ibft_mac" = "$2" ] ; then
+            echo $1
+            return 0
+        fi
+        unset IFS
+    done
+}
+
 install_ibft() {
     # When iBFT / iscsi_boot is detected:
     # - Use 'ip=ibft' to set up iBFT network interface
+    #   Note: bnx2i is using a different MAC address of iSCSI offloading
+    #         so the 'ip=ibft' parameter must not be set
     # - specify firmware booting cmdline parameter
 
     for d in /sys/firmware/* ; do
+        if [ -d ${d}/ethernet0 ] ; then
+            read ibft_mac < ${d}/ethernet0/mac
+            ibft_mod=$(get_ibft_mod $ibft_mac)
+        fi
+        if [ -z "$ibft_mod" ] && [ -d ${d}/ethernet1 ] ; then
+            read ibft_mac < ${d}/ethernet1/mac
+            ibft_mod=$(get_ibft_mod $ibft_mac)
+        fi
         if [ -d ${d}/initiator ] ; then
-            if [ ${d##*/} = "ibft" ] ; then
+            if [ ${d##*/} = "ibft" ] && [ "$ibft_mod" != "bnx2i" ] ; then
                 echo -n "ip=ibft "
             fi
             echo -n "rd.iscsi.firmware=1"
-- 
1.8.5.2
