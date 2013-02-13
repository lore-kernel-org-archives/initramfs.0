From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] crypt: Fix device detection.
Date: Wed, 13 Feb 2013 00:25:38 +0000
Message-ID: <1360715138-19755-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

The host device/fs rework led to a regression in crypt detection.
It was only checking the host filesystems, not it's slaves and thus
never detected if crypt support was needed.

Code now mirrors the lvm module's check

https://bugs.mageia.org/show_bug.cgi?id=9040
---

I've not specifically checked, but other modules might also have been affected by this change in behaviour.


 modules.d/90crypt/module-setup.sh | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/modules.d/90crypt/module-setup.sh b/modules.d/90crypt/module-setup.sh
index 5c1c71b..9980f3f 100755
--- a/modules.d/90crypt/module-setup.sh
+++ b/modules.d/90crypt/module-setup.sh
@@ -8,15 +8,9 @@ check() {
     type -P cryptsetup >/dev/null || return 1
 
     check_crypt() {
-        local dev=$1 fs=$2
-        [[ $fs = "crypto_LUKS" ]] || return 1
-        ID_FS_UUID=$(udevadm info --query=property --name=$dev \
-            | while read line; do
-                [[ ${line#ID_FS_UUID} = $line ]] && continue
-                eval "$line"
-                echo $ID_FS_UUID
-                break
-                done)
+        local ID_FS_TYPE ID_FS_UUID
+        eval $(udevadm info --query=property --name=/dev/block/$1|egrep '(ID_FS_TYPE|ID_FS_UUID)=')
+        [[ ${ID_FS_TYPE} = "crypto_LUKS" ]] || return 1
         [[ ${ID_FS_UUID} ]] || return 1
         if ! [[ $kernel_only ]]; then
             echo " rd.luks.uuid=luks-${ID_FS_UUID} " >> "${initdir}/etc/cmdline.d/90crypt.conf"
@@ -25,7 +19,7 @@ check() {
     }
 
     [[ $hostonly ]] || [[ $mount_needs ]] && {
-        for_each_host_dev_fs check_crypt || return 1
+        for_each_host_dev_and_slaves check_crypt || return 1
     }
 
     return 0
-- 
1.8.1.3
