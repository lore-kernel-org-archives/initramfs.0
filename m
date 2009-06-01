From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 7/9] netroot: add common handler for network root devices
Date: Mon, 1 Jun 2009 00:42:43 -0400
Message-ID: <7d7efa4a3d959a5f834cd1d5e73c1e15112aa77c.1243833882.git.dave@thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

/sbin/netroot is a jumping off point to allow various network
root devices to share infrastructure. It will loop over scriptlets
in the netroot handler, looking for a handler to run for this type
of netroot. Handlers can do choose to act based on command line
options to the kernel, or via DHCP options received on this interface.
They should massage root= into a form suitable for their handler.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 dracut                               |    2 +-
 modules.d/40network/60-net.rules     |    1 +
 modules.d/40network/dhcp-fallback.sh |   14 +++++++++
 modules.d/40network/ifup             |    8 ++--
 modules.d/40network/install          |    2 +
 modules.d/40network/netroot          |   52 ++++++++++++++++++++++++++++++++++
 modules.d/99base/init                |   11 ++++++-
 7 files changed, 84 insertions(+), 6 deletions(-)
 create mode 100755 modules.d/40network/dhcp-fallback.sh
 create mode 100755 modules.d/40network/netroot

diff --git a/dracut b/dracut
index 84c194e..e5e7ecd 100755
--- a/dracut
+++ b/dracut
@@ -96,7 +96,7 @@ if [[ -f $outfile && ! $force ]]; then
     exit 1
 fi
 
-hookdirs="cmdline pre-udev pre-mount pre-pivot mount emergency"
+hookdirs="cmdline pre-udev netroot pre-mount pre-pivot mount emergency"
 
 readonly initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
diff --git a/modules.d/40network/60-net.rules b/modules.d/40network/60-net.rules
index 4b030c3..6c79508 100644
--- a/modules.d/40network/60-net.rules
+++ b/modules.d/40network/60-net.rules
@@ -1 +1,2 @@
 ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"
+ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/netroot $env{INTERFACE}"
diff --git a/modules.d/40network/dhcp-fallback.sh b/modules.d/40network/dhcp-fallback.sh
new file mode 100755
index 0000000..1f4ec0c
--- /dev/null
+++ b/modules.d/40network/dhcp-fallback.sh
@@ -0,0 +1,14 @@
+# We should go last, and default the root if needed
+
+if [ -z "$root" ]; then
+    root=dhcp
+fi
+
+if [ "$root" = "dhcp" -a -z "$netroot" ]; then
+    rootok=1
+    netroot=dhcp
+fi
+
+if [ "${netroot+set}" = "set" ]; then
+    eval "echo netroot='$netroot'" > /tmp/netroot.info
+fi
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index ee4bc4a..981a207 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -12,8 +12,10 @@ getarg rdnetdebug && {
 
 netif=$1
 
-# bail immediatly if the interface is already up
+# bail immediately if the interface is already up
+# or we don't need the network
 [ -f "/tmp/net.$netif.up" ] && exit 0
+[ ! -f /tmp/netroot.info ] && exit 0
 
 # loopback is always handled the same way
 [ "$netif" = "lo" ] && {
@@ -93,10 +95,8 @@ ip_to_var() {
     [ -n "$autoconf" ] || autoconf=off
 }
 
-root=$(getarg root)
 ip=$(getarg ip)
-
-if [ "$root" = "dhcp" -a -z "$ip" ]; then
+if [ -z "$ip" ]; then
     do_dhcp;
 else
     # spin through the kernel command line, looking for ip= lines
diff --git a/modules.d/40network/install b/modules.d/40network/install
index d9ec7f0..3112494 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -2,8 +2,10 @@
 dracut_install ip dhclient hostname
 instmods =net
 inst "$moddir/ifup" "/sbin/ifup"
+inst "$moddir/netroot" "/sbin/netroot"
 inst "$moddir/dhclient-script" "/sbin/dhclient-script"
 instmods =networking ecb arc4
 inst_rules "$moddir/60-net.rules"
+inst_hook cmdline 99 "$moddir/dhcp-fallback.sh"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
 mkdir -p "${initdir}/var/run"
diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
new file mode 100755
index 0000000..3d03e72
--- /dev/null
+++ b/modules.d/40network/netroot
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+. /lib/dracut-lib
+
+getarg rdnetdebug && {
+    exec >/tmp/netroot.$1.$$.out
+    exec 2>>/tmp/netroot.$1.$$.out
+    set -x
+}
+
+# Only try to configure from one network interface at a time
+#
+[ "$NETROOT_LOCKED" ] || {
+    NETROOT_LOCKED=true
+    export NETROOT_LOCKED
+    exec flock -xo /tmp/netroot.lock -c "$0 $*"
+    exit 1
+}
+
+netif=$1
+
+# If we've already found a root, or we don't have the info we need,
+# then no point in looking further
+#
+[ -e /tmp/netroot.done ] && exit 0
+[ -s /tmp/netroot.info -a -s /tmp/root.info ] || exit 0
+
+# Pick up our config from the command line; we may already know the
+# handler to run
+#
+. /tmp/root.info
+. /tmp/netroot.info
+[ -e /tmp/net.$netif.dhcpopts ] && . /tmp/net.$netif.dhcpopts
+
+# Now, let the installed network root handlers figure this out
+#
+source_all netroot
+
+# If we didn't get a handler set, then we're done
+#
+if [ -z "$handler" ]; then
+    # XXX informative error message?
+    exit 0
+fi
+
+# Run the handler; don't store the root, it may change from device to device
+# XXX other variables to export?
+export NEWROOT
+if $handler $netif $root; then
+    >/tmp/netroot.done
+fi
+exit 0
diff --git a/modules.d/99base/init b/modules.d/99base/init
index 73e96fd..b4fce6a 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -47,12 +47,21 @@ fi
 
 if [ -z "${root%%error:*}" ]; then
     case "${root%%:*}" in
-       '') echo "FATAL: no root= option specified" ;;
+       '') echo "FATAL: no root= option specified, and no network support" ;;
        error) echo "FATAL: ${root#error:}" ;;
     esac
     emergency_shell
 fi
 
+# Network root scripts may need updated root= options,
+# so deposit them where they can see them (udev purges the env)
+{
+    echo "root='$root'"
+    echo "rflags='$rflags'"
+    echo "fstype='$fstype'"
+    echo "NEWROOT='$NEWROOT'"
+} > /tmp/root.info
+
 # pre-udev scripts run before udev starts, and are run only once.
 getarg 'rdbreak=pre-udev' && emergency_shell
 source_all pre-udev
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
