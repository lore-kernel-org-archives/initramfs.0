From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Add fcoe booting support
Date: Tue, 25 Aug 2009 21:58:18 +0200
Message-ID: <1251230298-3267-1-git-send-email-hdegoede@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Supported cmdline formats:
fcoe=<networkdevice>:<dcb|nodcb>
fcoe=<macaddress>:<dcb|nodcb>

Note currently only nodcb is supported, the dcb option is reserved for
future use.

Note letters in the macaddress must be lowercase!

Examples:
fcoe=eth0:nodcb
fcoe=4A:3F:4C:04:F8:D7:nodcb
---
 modules.d/95fcoe/check            |   11 ++++++++
 modules.d/95fcoe/fcoe-genrules.sh |   14 ++++++++++
 modules.d/95fcoe/fcoe-up          |   16 ++++++++++++
 modules.d/95fcoe/install          |    7 +++++
 modules.d/95fcoe/installkernel    |    2 +
 modules.d/95fcoe/parse-fcoe.sh    |   48 +++++++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/95fcoe/check
 create mode 100755 modules.d/95fcoe/fcoe-genrules.sh
 create mode 100755 modules.d/95fcoe/fcoe-up
 create mode 100755 modules.d/95fcoe/install
 create mode 100755 modules.d/95fcoe/installkernel
 create mode 100755 modules.d/95fcoe/parse-fcoe.sh

diff --git a/modules.d/95fcoe/check b/modules.d/95fcoe/check
new file mode 100755
index 0000000..95c1aa1
--- /dev/null
+++ b/modules.d/95fcoe/check
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+# We depend on network modules being loaded
+[ "$1" = "-d" ] && echo network
+
+# FIXME
+# If hostonly was requested, fail the check if we are not actually
+# booting from root.
+#[ "$1" = "-h" ] && ! egrep -q '/ /dev/nbd[0-9]*' /proc/mounts && exit 1
+
+exit 0
diff --git a/modules.d/95fcoe/fcoe-genrules.sh b/modules.d/95fcoe/fcoe-genrules.sh
new file mode 100755
index 0000000..b5d6f07
--- /dev/null
+++ b/modules.d/95fcoe/fcoe-genrules.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+# We use (fcoe_interface or fcoe_mac) and fcoe_dcb as set by parse-fcoe.sh
+# If neither mac nor interface are set we don't continue
+[ -z "$fcoe_interface" -a -z "$fcoe_mac" ] && return
+
+# Write udev rules
+{
+    if [ -n "$fcoe_mac" ] ; then
+	printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="/sbin/fcoe-up $env{INTERFACE} %s"\n' "$fcoe_mac" "$fcoe_dcb"
+    else
+	printf 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="%s", RUN+="/sbin/fcoe-up $env{INTERFACE} %s"\n' "$fcoe_interface" "$fcoe_dcb"
+    fi
+} > /etc/udev/rules.d/60-fcoe.rules
diff --git a/modules.d/95fcoe/fcoe-up b/modules.d/95fcoe/fcoe-up
new file mode 100755
index 0000000..8a70a62
--- /dev/null
+++ b/modules.d/95fcoe/fcoe-up
@@ -0,0 +1,16 @@
+#!/bin/sh
+#
+# We get called like this:
+# /sbin/fcoe-up <network-device> <dcb|nodcb>
+#
+# Note currently only nodcb is supported, the dcb option is reserved for
+# future use.
+
+# Huh? Missing arguments ??
+[ -z "$1" -o -z "$2" ] && exit 1
+
+netif=$1
+dcb=$2
+
+/sbin/ip link set "$netif" up
+echo -n "$netif" > /sys/module/fcoe/parameters/create
diff --git a/modules.d/95fcoe/install b/modules.d/95fcoe/install
new file mode 100755
index 0000000..0bd9ed4
--- /dev/null
+++ b/modules.d/95fcoe/install
@@ -0,0 +1,7 @@
+#!/bin/bash
+
+dracut_install ip
+
+inst "$moddir/fcoe-up" "/sbin/fcoe-up"
+inst_hook pre-udev 60 "$moddir/fcoe-genrules.sh"
+inst_hook cmdline 99 "$moddir/parse-fcoe.sh"
diff --git a/modules.d/95fcoe/installkernel b/modules.d/95fcoe/installkernel
new file mode 100755
index 0000000..f3409b3
--- /dev/null
+++ b/modules.d/95fcoe/installkernel
@@ -0,0 +1,2 @@
+#!/bin/bash
+instmods fcoe
diff --git a/modules.d/95fcoe/parse-fcoe.sh b/modules.d/95fcoe/parse-fcoe.sh
new file mode 100755
index 0000000..81ec760
--- /dev/null
+++ b/modules.d/95fcoe/parse-fcoe.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+#
+# Supported formats:
+# fcoe=<networkdevice>:<dcb|nodcb>
+# fcoe=<macaddress>:<dcb|nodcb>
+#
+# Note currently only nodcb is supported, the dcb option is reserved for
+# future use.
+#
+# Note letters in the macaddress must be lowercase!
+#
+# Examples:
+# fcoe=eth0:nodcb
+# fcoe=4A:3F:4C:04:F8:D7:nodcb
+
+[ -z "$fcoe" ] && fcoe=$(getarg fcoe=)
+
+# If it's not set we don't continue
+[ -z "$fcoe" ] && return
+
+parse_fcoe_opts() {
+    local IFS=:
+    set $fcoe
+
+    case $# in
+        2)
+            fcoe_interface=$1
+            fcoe_dcb=$2
+            ;;
+        7)
+            fcoe_mac=$1:$2:$3:$4:$5:$6
+            fcoe_dcb=$7
+            ;;
+        *)
+            die "Invalid arguments for fcoe="
+            ;;
+    esac
+}
+
+parse_fcoe_opts
+
+# currently only nodcb is supported
+if [ "$fcoe_dcb" != "nodcb" ] ; then
+    die "Invalid FCoE DCB option: $fcoe_dcb"
+fi
+
+# FCoE actually supported?
+[ -e /sys/module/fcoe/parameters/create ] || modprobe fcoe || die "FCoE requested but kernel/initrd does not support FCoE"
-- 
1.6.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
