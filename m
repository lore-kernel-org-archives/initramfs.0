From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 07/13] Add zfcp scripts for SUSE
Date: Fri, 29 Nov 2013 13:13:48 +0100
Message-ID: <1385727234-5001-8-git-send-email-hare@suse.de>
References: <1385727234-5001-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385727234-5001-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

SuSE is storing the zfcp configuration in udev files, so we should
be including these.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/95zfcp_rules/module-setup.sh | 25 +++++++++++++
 modules.d/95zfcp_rules/parse-zfcp.sh   | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100755 modules.d/95zfcp_rules/module-setup.sh
 create mode 100755 modules.d/95zfcp_rules/parse-zfcp.sh

diff --git a/modules.d/95zfcp_rules/module-setup.sh b/modules.d/95zfcp_rules/module-setup.sh
new file mode 100755
index 0000000..9a1ab20
--- /dev/null
+++ b/modules.d/95zfcp_rules/module-setup.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+# called by dracut
+check() {
+    local _arch=$(uname -m)
+    [ -x /sbin/zfcp_disk_configure ] || return 1
+    [ "$_arch" = "s390" -o "$_arch" = "s390x" ] || return 1
+    return 0
+}
+
+# called by dracut
+depends() {
+    return 0
+}
+
+# called by dracut
+install() {
+    inst_multiple /usr/lib/udev/collect
+    inst_hook cmdline 30 "$moddir/parse-zfcp.sh"
+    if [[ $hostonly ]] ; then
+        inst_rules_wildcard 51-zfcp-*.rules
+    fi
+}
diff --git a/modules.d/95zfcp_rules/parse-zfcp.sh b/modules.d/95zfcp_rules/parse-zfcp.sh
new file mode 100755
index 0000000..24dbdd3
--- /dev/null
+++ b/modules.d/95zfcp_rules/parse-zfcp.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+create_udev_rule() {
+    local ccw=$1
+    local wwpn=$2
+    local lun=$3
+    local _rule=/etc/udev/rules.d/51-zfcp-${ccw}.rules
+
+    local _cu_type _dev_type
+    local _rule=/etc/udev/rules.d/51-zfcp-${ccw}.rules
+
+    if [ -e /sys/bus/ccw/devices/${ccw} ] ; then
+        read _cu_type < /sys/bus/ccw/devices/${ccw}/cutype
+        read _dev_type < /sys/bus/ccw/devices/${ccw}/devtype
+    fi
+    if [ "$_cu_type" != "1731/03" ] ; then
+        return 0;
+    fi
+    if [ "$_dev_type" != "1732/03" ] && [ "$_dev_type" != "1732/04" ] ; then
+        return 0;
+    fi
+
+    [ -e ${_rule} ] && return 0
+
+    if [ ! -f "$_rule" ] ; then
+        cat > $_rule <<EOF
+ACTION=="add", SUBSYSTEM=="ccw", KERNEL=="$ccw", IMPORT{program}="collect $ccw %k ${ccw} zfcp"
+ACTION=="add", SUBSYSTEM=="drivers", KERNEL=="zfcp", IMPORT{program}="collect $ccw %k ${ccw} zfcp"
+ACTION=="add", ENV{COLLECT_$ccw}=="0", ATTR{[ccw/$ccw]online}="1"
+EOF
+    fi
+    m=$(sed -n "/.*${wwpn}.*${lun}.*/p" $_rule)
+    if [ -z "$m" ] ; then
+        cat >> $_rule <<EOF
+ACTION=="add", KERNEL=="rport-*", ATTR{port_name}=="$wwpn", SUBSYSTEMS=="ccw", KERNELS=="$ccw", ATTR{[ccw/$ccw]$wwpn/unit_add}="$lun"
+EOF
+    fi
+}
+
+for zfcp_arg in $(getargs rd.zfcp); do
+    (
+        IFS=","
+        set $zfcp_arg
+        create_udev_rule $1 $2 $3
+    )
+done
+
+for zfcp_arg in $(getargs root=) $(getargs resume=); do
+    (
+        case $zfcp_arg in
+            /dev/disk/by-path/ccw-*)
+                ccw_arg=${zfcp_arg##*/}
+                break;
+        esac
+        if [ -n "$ccw_arg" ] ; then
+            IFS="-"
+            set -- $ccw_arg
+            wwpn=${4%:*}
+            lun=${4#*:}
+            create_udev_rule $2 $wwpn $lun
+        fi
+    )
+done
-- 
1.8.1.4
