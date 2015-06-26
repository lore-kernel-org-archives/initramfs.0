From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 8/8] Use udev rules to create dmraid /dev/mapper/ devices
Date: Fri, 26 Jun 2015 16:55:57 +0200
Message-ID: <1435330557-17685-9-git-send-email-trenn@suse.de>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435330557-17685-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-IBi9RG/b67k@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

From: Hannes Reinecke <hare-IBi9RG/b67k@public.gmane.org>

https://bugzilla.opensuse.org/show_bug.cgi?id=905746
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/90dmraid/dmraid.sh       | 2 --
 modules.d/90dmraid/module-setup.sh | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/modules.d/90dmraid/dmraid.sh b/modules.d/90dmraid/dmraid.sh
index 3dcff38..cc4390f 100755
--- a/modules.d/90dmraid/dmraid.sh
+++ b/modules.d/90dmraid/dmraid.sh
@@ -26,8 +26,6 @@ if [ -n "$DM_RAIDS" ] || getargbool 0 rd.auto; then
                 if [ "${s##$r}" != "$s" ]; then
                     info "Activating $s"
                     dmraid -ay -i -p --rm_partitions "$s" 2>&1 | vinfo
-                    [ -e "/dev/mapper/$s" ] && kpartx -a "/dev/mapper/$s" 2>&1 | vinfo
-                    udevsettle
                 fi
             done
         done
diff --git a/modules.d/90dmraid/module-setup.sh b/modules.d/90dmraid/module-setup.sh
index e8de5f5..b77bbcf 100755
--- a/modules.d/90dmraid/module-setup.sh
+++ b/modules.d/90dmraid/module-setup.sh
@@ -74,6 +74,8 @@ install() {
 
     inst "$moddir/dmraid.sh" /sbin/dmraid_scan
 
+    inst_rules 64-md-raid.rules 66-kpartx.rules 67-kpartx-compat.rules
+
     inst_libdir_file "libdmraid-events*.so*"
 
     inst_rules "$moddir/61-dmraid-imsm.rules"
-- 
2.1.4
