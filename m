From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 08/15] 40network: add missing _arch variable declaration
Date: Fri, 21 Nov 2014 14:20:44 +0100
Message-ID: <1416576051-62838-9-git-send-email-trenn@suse.de>
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

The module_setup.sh script was missing an '_arch' declaration,
causing network not to be installed on s390.

Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/40network/module-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
index 55bee4c..f7e0a87 100755
--- a/modules.d/40network/module-setup.sh
+++ b/modules.d/40network/module-setup.sh
@@ -17,6 +17,7 @@ depends() {
 # called by dracut
 installkernel() {
     # Include wired net drivers, excluding wireless
+    local _arch=$(uname -m)
 
     net_module_filter() {
         local _net_drivers='eth_type_trans|register_virtio_device|usbnet_open'
-- 
1.8.5.2
