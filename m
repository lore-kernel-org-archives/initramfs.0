From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 15/42] Do not call 'lvm' for non-LVM device-mapper devices
Date: Thu, 11 Dec 2014 15:46:06 +0100
Message-ID: <1418309193-11208-16-git-send-email-trenn@suse.de>
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

If a device-mapper device is not created by LVM it's pointless
to call any 'lvm' programs got extract details; they'll be
failing anyway. So check the UUID before calling 'lvm'.
This speeds up initrd creation and avoids I/O errors on
multipath devices.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut-functions.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 17a71f0..edd8ea9 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -698,10 +698,12 @@ for_each_host_dev_and_slaves()
 # but you cannot create the logical volume without the volume group.
 # And the volume group might be bigger than the devices the LV needs.
 check_vol_slaves() {
-    local _lv _vg _pv
+    local _lv _vg _pv _dm
     for i in /dev/mapper/*; do
         [[ $i == /dev/mapper/control ]] && continue
         _lv=$(get_maj_min $i)
+        _dm=/sys/dev/block/$_lv/dm
+        [[ -f $_dm/uuid  && $(<$_dm/uuid) =~ LVM-* ]] || continue
         if [[ $_lv = $2 ]]; then
             _vg=$(lvm lvs --noheadings -o vg_name $i 2>/dev/null)
             # strip space
-- 
1.8.5.2
