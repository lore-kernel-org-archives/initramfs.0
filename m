From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 2/5] dracut-lib.sh: Add det_fs() and wrap_fsck()
Date: Fri, 20 May 2011 17:09:24 +0200
Message-ID: <1305904167-14199-3-git-send-email-soltys@ziu.info>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305904167-14199-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Both functions will be used by rootfs-block and fstab-sys modules.

Both are based on code present in mount-root.sh, though few changes are
present.

det_fs:

will try to determine filesystem type for supplied device, even if it's
not auto. If fs cannot be detected, or if the detected one differs from
the supplied one - a warning is issued (so user can fix its stuff later)

wrap_fsck:

will call fsck for specific device with optionally additional
fsckoptions. The function returns fsck return value.

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 modules.d/99base/dracut-lib.sh |   47 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index e376495..10025bd 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -515,3 +515,50 @@ foreach_uuid_until() (
 
     return 1
 )
+
+# Wrap fsck call for device _dev with additional fsck options _fsckopts return
+# fsck's return code
+wrap_fsck() {
+    local _ret _out _dev="$1" _fsckopts="$2"
+
+    info "Checking filesystem."
+    info fsck -T $_fsckopts "$_dev"
+    _out=$(fsck -T $_fsckopts "$_dev") ; _ret=$?
+
+    # A return of 4 or higher means there were serious problems.
+    if [ $_ret -gt 3 ]; then
+        echo $_out|vwarn
+        warn "fsck returned with error code $_ret"
+        warn "*** An error occurred during the file system check."
+        warn "*** Dropping you to a shell; the system will try"
+        warn "*** to mount the filesystem, when you leave the shell."
+        emergency_shell -n "(Repair filesystem)"
+    else
+        echo $_out|vinfo
+        [ $_ret -gt 0 ] && warn "fsck returned with $_ret"
+    fi
+
+    return $_ret
+}
+
+# Verify supplied filesystem type, fix if it's invalid, warn user if
+# appropriate
+det_fs() {
+    local _dev="$1" _fs="${2:-auto}" _inf="$3" _orig
+
+    _orig="$_fs"
+    _fs=$(udevadm info --query=env --name="$_dev" | \
+    while read line; do
+        if str_starts $line "ID_FS_TYPE="; then
+            echo ${line#ID_FS_TYPE=}
+            break
+        fi
+    done)
+    _fs=${_fs:-auto}
+    if [ "$_fs" = "auto" ]; then
+        warn "Cannon detect filesystem type for device $_dev"
+    elif [ "$_orig" != "auto" -a "$_fs" != "$_orig" ]; then
+        warn "$_inf: detected filesystem '$_fs' instead of '$_orig' for device: $_dev"
+    fi
+    echo "$_fs"
+}
-- 
1.7.2.1
