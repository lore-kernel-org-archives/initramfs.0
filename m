From: Ross Lagerwall <ross.lagerwall-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Require all interfaces to be up before using iscsistart -b
Date: Thu, 14 May 2015 09:30:11 +0100
Message-ID: <1431592211-5652-1-git-send-email-ross.lagerwall@citrix.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ross Lagerwall <ross.lagerwall-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>

If multiple targets are specified in the ibft, iscsistart will log into
all of them, possibly using multiple interfaces. Since iscsistart is run
indirectly from ifup, require that all interfaces are up before actually
logging into the targets.
---
 modules.d/95iscsi/iscsiroot.sh |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/modules.d/95iscsi/iscsiroot.sh b/modules.d/95iscsi/iscsiroot.sh
index 1de6fb7..b9e99cb 100755
--- a/modules.d/95iscsi/iscsiroot.sh
+++ b/modules.d/95iscsi/iscsiroot.sh
@@ -45,6 +45,11 @@ fi
 
 handle_firmware()
 {
+    # iscsistart -b may use multiple interfaces so only run when
+    # all are ready.
+    type all_ifaces_up >/dev/null 2>&1 || . /lib/net-lib.sh
+    all_ifaces_up || return 1
+
     if ! [ -e /tmp/iscsistarted-firmware ]; then
         if ! iscsistart -f; then
             warn "iscistart: Could not get list of targets from firmware."
-- 
1.7.10.4
