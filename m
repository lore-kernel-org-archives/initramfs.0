From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 7/8] ensure pre-mount (and resume) run before root fsck
Date: Fri, 26 Jun 2015 16:55:56 +0200
Message-ID: <1435330557-17685-8-git-send-email-trenn@suse.de>
References: <1435330557-17685-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435330557-17685-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

References:
https://bugzilla.suse.com/show_bug.cgi?id=906592
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/98dracut-systemd/rootfs-generator.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/modules.d/98dracut-systemd/rootfs-generator.sh b/modules.d/98dracut-systemd/rootfs-generator.sh
index 5910ce7..7eb0b1a 100755
--- a/modules.d/98dracut-systemd/rootfs-generator.sh
+++ b/modules.d/98dracut-systemd/rootfs-generator.sh
@@ -65,6 +65,23 @@ generator_mount_rootfs()
     fi
 }
 
+generator_fsck_after_pre_mount()
+{
+    local _name
+
+    [ -z "$1" ] && return 0
+
+    _name=$(dev_unit_name "$1")
+    [ -d /run/systemd/generator/systemd-fsck@${_name}.service.d ] || mkdir -p /run/systemd/generator/systemd-fsck@${_name}.service.d
+    if ! [ -f /run/systemd/generator/systemd-fsck@${_name}.service.d/after-pre-mount.conf ]; then
+        {
+            echo "[Unit]"
+            echo "After=dracut-pre-mount.service"
+        } > /run/systemd/generator/systemd-fsck@${_name}.service.d/after-pre-mount.conf
+    fi
+
+}
+
 root=$(getarg root=)
 case "$root" in
     block:LABEL=*|LABEL=*)
@@ -95,6 +112,7 @@ GENERATOR_DIR="$1"
 
 if [ "${root%%:*}" = "block" ]; then
    generator_wait_for_dev "${root#block:}" "$RDRETRY"
+   generator_fsck_after_pre_mount "${root#block:}"
    strstr "$(cat /proc/cmdline)" 'root=' || generator_mount_rootfs "${root#block:}" "$(getarg rootfstype=)" "$(getarg rootflags=)"
 fi
 
-- 
2.1.4
