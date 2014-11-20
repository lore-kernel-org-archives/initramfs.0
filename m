From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 13/33] 95iscsi: Set correct iscsi_started value for iSCSI firmware
Date: Thu, 20 Nov 2014 15:56:48 +0100
Message-ID: <1416495428-36978-14-git-send-email-trenn@suse.de>
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

When iSCSI firmware booting is selected we should not rely on
'netroot' or 'iscsiroot' variables to be set.

References: bnc#873448

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95iscsi/parse-iscsiroot.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/modules.d/95iscsi/parse-iscsiroot.sh b/modules.d/95iscsi/parse-iscsiroot.sh
index ca57668..85c3027 100755
--- a/modules.d/95iscsi/parse-iscsiroot.sh
+++ b/modules.d/95iscsi/parse-iscsiroot.sh
@@ -90,8 +90,12 @@ if [ -n "$netroot" ] && [ "$root" != "/dev/root" ] && [ "$root" != "dhcp" ]; the
     fi
 fi
 
-netroot_enc=$(str_replace "$netroot" '/' '\2f')
-echo "[ -f '/tmp/iscsistarted-$netroot_enc' ]" > $hookdir/initqueue/finished/iscsi_started.sh
+if [ -n "$iscsi_firmware" ] ; then
+    echo "[ -f '/tmp/iscsistarted-firmware' ]" > $hookdir/initqueue/finished/iscsi_started.sh
+else
+    netroot_enc=$(str_replace "$netroot" '/' '\2f')
+    echo "[ -f '/tmp/iscsistarted-$netroot_enc' ]" > $hookdir/initqueue/finished/iscsi_started.sh
+fi
 
 # Done, all good!
 rootok=1
-- 
1.8.5.2
