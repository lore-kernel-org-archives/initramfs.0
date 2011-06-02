From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 3/4] 95rootfs-block/mount-root.sh: squash rootopts into rflags
Date: Thu,  2 Jun 2011 23:22:14 +0200
Message-ID: <1307049735-2345-4-git-send-email-soltys@ziu.info>
References: <1307049735-2345-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1307049735-2345-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Small simplification - prepend rootopts to rflags before mount
operations. Shortens resulting command lines quite a bit.
---
 modules.d/95rootfs-block/mount-root.sh |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/modules.d/95rootfs-block/mount-root.sh b/modules.d/95rootfs-block/mount-root.sh
index 440f1b7..3a43a66 100755
--- a/modules.d/95rootfs-block/mount-root.sh
+++ b/modules.d/95rootfs-block/mount-root.sh
@@ -94,21 +94,24 @@ mount_root() {
         rootopts=$(filter_rootopts $rootopts)
     fi
 
+    # we want rootflags (rflags) to take precedence so prepend rootopts to
+    # them; rflags is guaranteed to not be empty
+    rflags="${rootopts:+"${rootopts},"}${rflags}"
+
     umount "$NEWROOT"
 
     # backslashes are treated as escape character in fstab
     esc_root=$(echo ${root#block:} | sed 's,\\,\\\\,g')
-    printf '%s %s %s %s,%s 1 1 \n' "$esc_root" "$NEWROOT" "$rootfs" "$rflags" "$rootopts"  > /etc/fstab
+    printf '%s %s %s %s 1 1 \n' "$esc_root" "$NEWROOT" "$rootfs" "$rflags" >/etc/fstab
 
-    if [ -z "$fastboot" -a "$READONLY" != "yes" ] && ! strstr "${rflags},${rootopts}" _netdev; then
+    if [ -z "$fastboot" -a "$READONLY" != "yes" ] && ! strstr "${rflags}" _netdev; then
         fsck_single "${root#block:}" "$rootfs" "$fsckoptions"
         _ret=$?
         [ $_ret -ne 255 ] && echo $_ret >/run/initramfs/root-fsck
     fi
 
-    info "Remounting ${root#block:} with -o ${rflags},${rootopts}"
-    mount -t "$rootfs" -o "$rflags","$rootopts" \
-        "${root#block:}" "$NEWROOT" 2>&1 | vinfo
+    info "Remounting ${root#block:} with -o ${rflags}"
+    mount -t "$rootfs" -o "$rflags" "${root#block:}" "$NEWROOT" 2>&1 | vinfo
 
     [ -f "$NEWROOT"/forcefsck ] && rm -f "$NEWROOT"/forcefsck 2>/dev/null
     [ -f "$NEWROOT"/.autofsck ] && rm -f "$NEWROOT"/.autofsck 2>/dev/null
-- 
1.7.5.2
