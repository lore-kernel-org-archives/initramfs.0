From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] Add ifname= argument for persistent netdev names
Date: Mon, 14 Sep 2009 11:42:52 +0200
Message-ID: <1252921374-2798-1-git-send-email-hdegoede@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

ifname=<interface>:<MAC>
Assign network device name <interface> (ie eth0) to the NIC with MAC <MAC>.
Note that if you use this option you *must* specify an ifname= argument
for all interfaces used in ip= or fcoe= arguments
---
 dracut.8                               |    6 +++++
 modules.d/40network/ifname-genrules.sh |   21 ++++++++++++++++++
 modules.d/40network/install            |    2 +
 modules.d/40network/net-genrules.sh    |    2 +-
 modules.d/40network/parse-ifname.sh    |   37 ++++++++++++++++++++++++++++++++
 modules.d/95fcoe/fcoe-genrules.sh      |    2 +-
 modules.d/95fcoe/parse-fcoe.sh         |    2 +-
 7 files changed, 69 insertions(+), 3 deletions(-)
 create mode 100755 modules.d/40network/ifname-genrules.sh
 create mode 100755 modules.d/40network/parse-ifname.sh

diff --git a/dracut.8 b/dracut.8
index b0547d9..e9bd0d8 100644
--- a/dracut.8
+++ b/dracut.8
@@ -247,6 +247,12 @@ get ip from dhcp server on a specific interface
 .B ip=<client-IP-number>:[<server-id>]:<gateway-IP-number>:<netmask>:<client-hostname>:<interface>:{none|off}
 explicit network configuration
 
+.TP
+.B ifname=<interface>:<MAC>
+Assign network device name <interface> (ie eth0) to the NIC with MAC <MAC>.
+Note that if you use this option you \fBmust\fR specify an ifname= argument
+for all interfaces used in ip= or fcoe= arguments
+
 .SH Misc
 .TP
 .B rdblacklist=<drivername>
diff --git a/modules.d/40network/ifname-genrules.sh b/modules.d/40network/ifname-genrules.sh
new file mode 100755
index 0000000..547f230
--- /dev/null
+++ b/modules.d/40network/ifname-genrules.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+# if there are no ifname parameters, just use NAME=KERNEL
+if ! getarg ifname= >/dev/null ; then
+    echo 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="?*", ATTR{type}=="1", NAME="%k"' \
+        > /etc/udev/rules.d/50-ifname.rules
+    return
+fi
+
+{
+    for p in $(getargs ifname=); do
+        parse_ifname_opts $p
+	printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", ATTR{type}=="1", NAME="%s"\n' "$ifname_mac" "$ifname_if"
+    done
+
+    # Rename non named interfaces out of the way for named ones.
+    for p in $(getargs ifname=); do
+        parse_ifname_opts $p
+	printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="?*", ATTR{type}=="1", NAME!="?*", KERNEL=="%s", NAME="%%k-renamed"\n' "$ifname_if"
+    done
+} > /etc/udev/rules.d/50-ifname.rules
diff --git a/modules.d/40network/install b/modules.d/40network/install
index 34aed93..ded70da 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -4,10 +4,12 @@ inst "$moddir/ifup" "/sbin/ifup"
 inst "$moddir/netroot" "/sbin/netroot"
 inst "$moddir/dhclient-script" "/sbin/dhclient-script"
 inst "$moddir/dhclient.conf" "/etc/dhclient.conf" 
+inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
 inst_hook pre-udev 60 "$moddir/net-genrules.sh"
 inst_hook cmdline 91 "$moddir/dhcp-root.sh"
 inst_hook cmdline 99 "$moddir/parse-ip-opts.sh"
 inst_hook cmdline 98 "$moddir/parse-bridge.sh"
+inst_hook cmdline 99 "$moddir/parse-ifname.sh"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
 
 # TODO ifcfg config style is redhat specific, this should probably
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index 04e0528..ba369cc 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -29,7 +29,7 @@ fix_bootif() {
     # If we have to handle multiple interfaces, handle only them.
     elif [ -n "$IFACES" ] ; then
 	for iface in $IFACES ; do
-	    printf 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$iface"
+	    printf 'ACTION=="add", SUBSYSTEM=="net", NAME=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$iface"
 	done
 
     # Default: We don't know the interface to use, handle all
diff --git a/modules.d/40network/parse-ifname.sh b/modules.d/40network/parse-ifname.sh
new file mode 100755
index 0000000..aba8475
--- /dev/null
+++ b/modules.d/40network/parse-ifname.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Format:
+#	ifname=<interface>:<mac>
+#
+# Note letters in the macaddress must be lowercase!
+#
+# Examples:
+# ifname=eth0:4a:3f:4c:04:f8:d7
+#
+# Note when using ifname= to get persistent interface names, you must specify
+# an ifname= argument for each interface used in an ip= or fcoe= argument
+
+# check if there are any ifname parameters
+if ! getarg ifname= >/dev/null ; then
+    return
+fi
+
+parse_ifname_opts() {
+    local IFS=:
+    set $1
+
+    case $# in
+        7)
+            ifname_if=$1
+            ifname_mac=$2:$3:$4:$5:$6:$7
+            ;;
+        *)
+            die "Invalid arguments for ifname="
+            ;;
+    esac
+}
+
+# Check ifname= lines
+for p in $(getargs ifname=); do
+    parse_ifname_opts $p
+done
diff --git a/modules.d/95fcoe/fcoe-genrules.sh b/modules.d/95fcoe/fcoe-genrules.sh
index b5d6f07..e9d0157 100755
--- a/modules.d/95fcoe/fcoe-genrules.sh
+++ b/modules.d/95fcoe/fcoe-genrules.sh
@@ -9,6 +9,6 @@
     if [ -n "$fcoe_mac" ] ; then
 	printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="/sbin/fcoe-up $env{INTERFACE} %s"\n' "$fcoe_mac" "$fcoe_dcb"
     else
-	printf 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="%s", RUN+="/sbin/fcoe-up $env{INTERFACE} %s"\n' "$fcoe_interface" "$fcoe_dcb"
+	printf 'ACTION=="add", SUBSYSTEM=="net", NAME=="%s", RUN+="/sbin/fcoe-up $env{INTERFACE} %s"\n' "$fcoe_interface" "$fcoe_dcb"
     fi
 } > /etc/udev/rules.d/60-fcoe.rules
diff --git a/modules.d/95fcoe/parse-fcoe.sh b/modules.d/95fcoe/parse-fcoe.sh
index 81ec760..b35680f 100755
--- a/modules.d/95fcoe/parse-fcoe.sh
+++ b/modules.d/95fcoe/parse-fcoe.sh
@@ -11,7 +11,7 @@
 #
 # Examples:
 # fcoe=eth0:nodcb
-# fcoe=4A:3F:4C:04:F8:D7:nodcb
+# fcoe=4a:3f:4c:04:f8:d7:nodcb
 
 [ -z "$fcoe" ] && fcoe=$(getarg fcoe=)
 
-- 
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
