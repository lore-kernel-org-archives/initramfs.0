From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 18/42] Generate fallback mount unit for root filesystem
Date: Thu, 11 Dec 2014 15:46:09 +0100
Message-ID: <1418309193-11208-19-git-send-email-trenn@suse.de>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

From: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>

If kernel cmdline has no root= provided, *and* the initrd carries
a default value, create a systemd mount unit to have it available
in /sysroot

References: bnc#855258

Signed-off-by: Thorsten Behrens <tbehrens-IBi9RG/b67k@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/98systemd/rootfs-generator.sh | 34 ++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/modules.d/98systemd/rootfs-generator.sh b/modules.d/98systemd/rootfs-generator.sh
index 5b06137..f3c7d1f 100755
--- a/modules.d/98systemd/rootfs-generator.sh
+++ b/modules.d/98systemd/rootfs-generator.sh
@@ -35,6 +35,35 @@ generator_wait_for_dev()
     fi
 }
 
+generator_mount_rootfs()
+{
+    local _type=$2
+    local _flags=$3
+    local _name
+
+    [ -z "$1" ] && return 0
+
+    _name=$(dev_unit_name "$1")
+    [ -d /run/systemd/generator ] || mkdir -p /run/systemd/generator
+    if ! [ -f /run/systemd/generator/sysroot.mount ]; then
+        {
+            echo "[Unit]"
+            echo "Before=initrd-root-fs.target"
+            echo "RequiresOverridable=systemd-fsck@${_name}.service"
+            echo "After=systemd-fsck@${_name}.service"
+            echo "[Mount]"
+            echo "Where=/sysroot"
+            echo "What=$1"
+            echo "Options=${_flags}"
+            echo "Type=${_type}"
+        } > /run/systemd/generator/sysroot.mount
+    fi
+    if ! [ -L /run/systemd/generator/initrd-root-fs.target.requires/sysroot.mount ]; then
+        [ -d /run/systemd/generator/initrd-root-fs.target.requires ] || mkdir -p /run/systemd/generator/initrd-root-fs.target.requires
+        ln -s ../sysroot.mount /run/systemd/generator/initrd-root-fs.target.requires/sysroot.mount
+    fi
+}
+
 root=$(getarg root=)
 case "$root" in
     block:LABEL=*|LABEL=*)
@@ -61,6 +90,9 @@ case "$root" in
         rootok=1 ;;
 esac
 
-[ "${root%%:*}" = "block" ] && generator_wait_for_dev "${root#block:}" "$RDRETRY"
+if [ "${root%%:*}" = "block" ]; then
+   generator_wait_for_dev "${root#block:}" "$RDRETRY"
+   grep -q 'root=' /proc/cmdline || generator_mount_rootfs "${root#block:}" "$(getarg rootfstype=)" "$(getarg rootflags=)"
+fi
 
 exit 0
-- 
1.8.5.2
