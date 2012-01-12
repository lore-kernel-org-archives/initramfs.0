From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH usrmove branch] fstab-sys: mount it in initramfs instead of
 newroot if mount point is not found
Date: Thu, 12 Jan 2012 16:00:31 +0800
Message-ID: <20120112080031.GA32416@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

fstab-sys now also handles device passed by dracut argument "--mount"
The "--mount" mount point is possible not exist in $NEWROOT. Thus mount it
in initramfs if mount point is not exist in real rootfs

---
 modules.d/95fstab-sys/mount-sys.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/modules.d/95fstab-sys/mount-sys.sh b/modules.d/95fstab-sys/mount-sys.sh
index a8fbd50..4de7285 100755
--- a/modules.d/95fstab-sys/mount-sys.sh
+++ b/modules.d/95fstab-sys/mount-sys.sh
@@ -20,7 +20,12 @@ fstab_mount() {
         fi
         _fs=$(det_fs "$_dev" "$_fs")
         info "Mounting $_dev"
-        mount -v -t $_fs -o $_opts $_dev $NEWROOT/$_mp 2>&1 | vinfo
+        if [[ -d $NEWROOT/$_mp ]]; then
+            mount -v -t $_fs -o $_opts $_dev $NEWROOT/$_mp 2>&1 | vinfo
+        else
+            mkdir -p "$_mp"
+            mount -v -t $_fs -o $_opts $_dev $_mp 2>&1 | vinfo
+        fi
     done < $1
     return 0
 }
-- 
1.7.7.5
