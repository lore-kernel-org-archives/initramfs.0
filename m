From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 01/15] 95iscsi: parse output from iscsiadm correctly
Date: Fri, 21 Nov 2014 14:20:37 +0100
Message-ID: <1416576051-62838-2-git-send-email-trenn@suse.de>
References: <1416576051-62838-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416576051-62838-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Due to some obsure reason the IFS parameter is not set correctly
when evaluating get_ibft_mod(). So change the parsing to not rely
on IFS altogether.

References: bnc#886199

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95iscsi/module-setup.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/modules.d/95iscsi/module-setup.sh b/modules.d/95iscsi/module-setup.sh
index 9975e59..f13119f 100755
--- a/modules.d/95iscsi/module-setup.sh
+++ b/modules.d/95iscsi/module-setup.sh
@@ -30,15 +30,16 @@ check() {
 
 get_ibft_mod() {
     local ibft_mac=$1
+    local iface_mac iface_mod
     # Return the iSCSI offload module for a given MAC address
-    iscsiadm -m iface | while read iface_name iface_desc ; do
-        IFS=$','
-        set -- $iface_desc
-        if [ "$ibft_mac" = "$2" ] ; then
-            echo $1
+    for iface_desc in $(iscsiadm -m iface | cut -f 2 -d ' '); do
+        iface_mod=${iface_desc%%,*}
+        iface_mac=${iface_desc#*,}
+        iface_mac=${iface_mac%%,*}
+        if [ "$ibft_mac" = "$iface_mac" ] ; then
+            echo $iface_mod
             return 0
         fi
-        unset IFS
     done
 }
 
-- 
1.8.5.2
