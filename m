From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 3/5] 95fstab-sys: use det_fs and wrap_fsck
Date: Fri, 20 May 2011 17:09:25 +0200
Message-ID: <1305904167-14199-4-git-send-email-soltys@ziu.info>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305904167-14199-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch mainly adds fsck functionality to fstab-sys, with additional
sanity checks (checking for device existence, verifying fstype via
det_fs).

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/95fstab-sys/module-setup.sh |    2 ++
 modules.d/95fstab-sys/mount-sys.sh    |   23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/modules.d/95fstab-sys/module-setup.sh b/modules.d/95fstab-sys/module-setup.sh
index f46c037..1fbd55b 100755
--- a/modules.d/95fstab-sys/module-setup.sh
+++ b/modules.d/95fstab-sys/module-setup.sh
@@ -12,5 +12,7 @@ depends() {
 
 install() {
     dracut_install /etc/fstab.sys
+    dracut_install /sbin/fsck*
+    type -P e2fsck >/dev/null && dracut_install e2fsck
     inst_hook pre-pivot 00 "$moddir/mount-sys.sh"
 }
diff --git a/modules.d/95fstab-sys/mount-sys.sh b/modules.d/95fstab-sys/mount-sys.sh
index 266576e..b444071 100755
--- a/modules.d/95fstab-sys/mount-sys.sh
+++ b/modules.d/95fstab-sys/mount-sys.sh
@@ -2,14 +2,25 @@
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
-fstab_mount(){
-    local dev mp type opts rest
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+
+fstab_mount() {
+    local _dev _mp _fs _opts _dump _pass _rest
     test -e "$1" || return 1
     info "Mounting from $1"
-    while read dev mp type opts rest; do
-	[ -z "${dev%%#*}" ]&& continue # Skip comment lines
-	mount -v -t $type -o $opts $dev $NEWROOT/$mp
-    done < $1 | vinfo
+    while read _dev _mp _fs _opts _dump _pass _rest; do
+        [ -z "${_dev%%#*}" ] && continue # Skip comment lines
+        if [ ! -e "$_dev" ]; then
+            warn "Device $_dev doesn't exist, skipping mount."
+            continue
+        fi
+        if [ "$_pass" -gt 0 ] && ! strstr "$_opts" _netdev; then
+            wrap_fsck "$_dev"
+        fi
+        _fs=$(det_fs "$_dev" "$_fs" /etc/fstab.sys)
+        info "Mounting $_dev"
+        mount -v -t $_fs -o $_opts $_dev $NEWROOT/$_mp 2>&1 | vinfo
+    done < $1
     return 0
 }
 
-- 
1.7.2.1
