From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 4/5] 95rootfs-block/mount-root.sh: Rely on det_fs and wrap_fsck
Date: Fri, 20 May 2011 17:09:26 +0200
Message-ID: <1305904167-14199-5-git-send-email-soltys@ziu.info>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305904167-14199-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Use common fsck and det_fs code. Verify filesystem type more
aggressively, which has a chance to be more resistant to
accidental mistakes.

Also, there's no need to generate custom fstab for the sake of fsck
anymore.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/95rootfs-block/mount-root.sh |   47 ++++++-------------------------
 1 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index 8e86024..9334323 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -26,8 +26,10 @@ filter_rootopts() {
 }
 
 if [ -n "$root" -a -z "${root%%block:*}" ]; then
-    mount -t ${fstype:-auto} -o "$rflags",ro "${root#block:}" "$NEWROOT" \
-        && ROOTFS_MOUNTED=yes
+
+    # sanity - determine/fix fstype
+    rootfs=$(det_fs "${root#block:}" "$fstype" "cmdline")
+    mount -t ${rootfs} -o "$rflags",ro "${root#block:}" "$NEWROOT"
 
     READONLY=
     fsckoptions=
@@ -71,7 +73,6 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
         fsckoptions="-a $fsckoptions"
     fi
 
-    rootfs=${fstype:-auto}
     rootopts=
     if getargbool 1 rd.fstab -n rd_NO_FSTAB \
         && ! getarg rootflags \
@@ -86,7 +87,8 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
             [ "${dev%%#*}" != "$dev" ] && continue
 
             if [ "$mp" = "/" ]; then
-                rootfs=$fs
+                # sanity - determine/fix fstype
+                rootfs=$(det_fs "${root#block:}" "$fs" "$NEWROOT/etc/fstab")
                 rootopts=$opts
                 break
             fi
@@ -96,41 +98,10 @@ if [ -n "$root" -a -z "${root%%block:*}" ]; then
     fi
 
     umount "$NEWROOT"
-    if [ "$rootfs" = "auto" ]; then
-        rootfs=$(udevadm info --query=env --name=${root#block:} | \
-            while read line; do
-                if strstr $line ID_FS_TYPE; then
-                    eval $line
-                    echo $ID_FS_TYPE
-                    break
-                fi
-            done)
-        rootfs=${rootfs:-auto}
-    fi
 
-    # backslashes are treated as escape character in fstab
-    esc_root=$(echo ${root#block:} | sed 's,\\,\\\\,g')
-    printf '%s %s %s %s,%s 1 1 \n' "$esc_root" "$NEWROOT" "$rootfs" "$rflags" "$rootopts"  > /etc/fstab
-
-    if [ -z "$fastboot" -a "$READONLY" != "yes" ]; then
-        info "Checking filesystems"
-        info fsck -T -t noopts=_netdev -A $fsckoptions
-        out=$(fsck -T -t noopts=_netdev -A $fsckoptions)
-        export RD_ROOTFS_FSCK=$?
-        echo $RD_ROOTFS_FSCK > /run/initramfs/root-fsck
-
-        # A return of 4 or higher means there were serious problems.
-        if [ $RD_ROOTFS_FSCK -gt 3 ]; then
-            warn $out
-            warn "fsck returned with error code $RD_ROOTFS_FSCK"
-            warn "*** An error occurred during the file system check."
-            warn "*** Dropping you to a shell; the system will retry"
-            warn "*** to mount the system, when you leave the shell."
-            emergency_shell -n "(Repair filesystem)"
-        else
-            echo $out|vinfo
-            [ $RD_ROOTFS_FSCK -gt 0 ] && warn "fsck returned with $RD_ROOTFS_FSCK"
-        fi
+    if [ -z "$fastboot" -a "$READONLY" != "yes" ] && ! strstr "${rflags},${rootopts}" _netdev; then
+        wrap_fsck "${root#block:}" "$fsckoptions"
+        echo $? >/run/initramfs/root-fsck
     fi
 
     info "Remounting ${root#block:} with -o ${rflags},${rootopts}"
-- 
1.7.2.1
