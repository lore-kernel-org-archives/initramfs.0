From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH 2/5] network/netroot
Date: Fri, 12 Jun 2009 17:18:36 +0200
Message-ID: <4A3271CC.9090608@bfh.ch>
References: <4A32703A.8080603@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A32703A.8080603-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

I'm terribly sorry (and embarrassed), I forgot git add...
Missing parts follow

---
 modules.d/40network/dhcp-root.sh     |   21 +++++
 modules.d/40network/net-genrules.sh  |   36 ++++++++
 modules.d/40network/parse-ip-opts.sh |  149 ++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+), 0 deletions(-)

diff --git a/modules.d/40network/dhcp-root.sh b/modules.d/40network/dhcp-root.sh
new file mode 100755
index 0000000..a6d5945
--- /dev/null
+++ b/modules.d/40network/dhcp-root.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+# Don't continue if root is ok
+[ -n "$rootok" ] && return
+
+# This script is sourced, so root should be set. But let's be paranoid
+[ -z "$root" ] && root=$(getarg root=)
+[ -z "$netroot" ] && netroot=$(getarg netroot=)
+
+if [ "$root" = "dhcp" ] || [ "$netroot" = "dhcp" ] ; then
+    # Tell ip= checker that we need dhcp
+    NEEDDHCP="1"
+
+    # Done, all good!
+    rootok=1
+    netroot=dhcp
+
+    # Shut up init error check
+    [ -z "$root" ] && root="dhcp"
+fi
+
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
new file mode 100755
index 0000000..adad18b
--- /dev/null
+++ b/modules.d/40network/net-genrules.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+#pxelinux provides macaddr '-' separated, but we need ':'
+fix_bootif() {
+    local macaddr=${1##??-}
+    local IFS='-'
+    macaddr=$(for i in ${macaddr} ; do echo -n $i:; done)
+    macaddr=${macaddr%:}
+    echo $macaddr
+}
+
+# Don't continue if we don't need network
+[ -z "$netroot" ] && return;
+
+# Write udev rules
+{
+    # BOOTIF says everything, use only that one
+    BOOTIF=$(getarg 'BOOTIF=')
+    if [ -n "$BOOTIF" ] ; then
+	BOOTIF=$(fix_bootif "$BOOTIF")
+	printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$BOOTIF"
+    # If we have to handle multiple interfaces, handle only them.
+    elif [ -n "$IFACES" ] ; then
+	for iface in $IFACES ; do
+	    printf 'ACTION=="add", SUBSYSTEM=="net", KERNEL="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$iface"
+	done
+
+    # Default: We don't know the interface to use, handle all
+    else 
+	printf 'ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"\n'
+    fi
+
+    # Udev event 'online' only gets fired from ifup/dhclient-script.
+    # No special rules required
+    printf 'ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/netroot $env{INTERFACE}"\n'
+} > /etc/udev/rules.d/60-net.rules
diff --git a/modules.d/40network/parse-ip-opts.sh b/modules.d/40network/parse-ip-opts.sh
new file mode 100755
index 0000000..5f2e671
--- /dev/null
+++ b/modules.d/40network/parse-ip-opts.sh
@@ -0,0 +1,149 @@
+#!/bin/sh
+#
+# Format:
+#	ip=[dhcp|on|any]
+#
+#	ip=<interface>:[dhcp|on|any]
+#
+#	ip=<client-IP-number>:<server-id>:<gateway-IP-number>:<netmask>:<client-hostname>:<interface>:[dhcp|on|any|none|off]
+#
+# When supplying more than only ip= line, <interface> is mandatory and
+# bootdev= must contain the name of the primary interface to use for
+# routing,dns,dhcp-options,etc.
+#
+
+# Sadly there's no easy way to split ':' separated lines into variables
+ip_to_var() {
+    local v=${1}:
+    set --
+    while [ -n "$v" ]; do
+	set -- "$@" "${v%%:*}"
+	v=${v#*:}
+    done
+
+    unset ip srv gw mask hostname dev autoconf
+    case $# in
+    0)	autoconf="error" ;;
+    1)	autoconf=$1 ;;
+    2)	dev=$1; autoconf=$2 ;;
+    *)	ip=$1; srv=$2; gw=$3; mask=$4; hostname=$5; dev=$6; autoconf=$7 ;;
+    esac
+}
+
+
+# Check if ip= lines should be used
+if getarg ip= >/dev/null ; then
+    if [ -z "$netroot" ] ; then
+	echo "Warning: No netboot configured, ignoring ip= lines"
+	return;
+    fi
+fi
+
+# Don't mix BOOTIF=macaddr from pxelinux and ip= lines
+getarg ip= >/dev/null && getarg BOOTIF= >/dev/null && \
+    die "Mixing BOOTIF and ip= lines is dangerous"
+
+# No more parsing stuff, BOOTIF says everything
+[ -n "$(getarg BOOTIF)" ] && return
+
+# Warn if defaulting to ip=dhcp
+if [ -n "$netroot" ] && [ -z "$(getarg ip=)" ] ; then
+    echo "Warning: No ip= argument(s) provided, defaulting to DHCP"
+    return;
+fi
+
+# Count ip= lines to decide whether we need bootdev= or not
+if [ -z "$NEEDBOOTDEV" ] ; then
+    [ "$CMDLINE" ] || read CMDLINE < /proc/cmdline
+    local count=0
+    for p in $CMDLINE; do
+	[ "${p%%=*}" = "ip" ] && count=$(( $count + 1 ))
+    done
+    [ $count -gt 1 ] && NEEDBOOTDEV=1
+fi
+
+# If needed, check if bootdev= contains anything usable
+if [ -n "$NEEDBOOTDEV" ] ; then
+    BOOTDEV=$(getarg bootdev=) || die "Please supply bootdev argument for multiple ip= lines"
+    [ -z "$BOOTDEV" ] && die "Bootdev argument is empty"
+fi
+
+# Check ip= lines
+# XXX Would be nice if we could errorcheck ip addresses here as well
+[ "$CMDLINE" ] || read CMDLINE < /proc/cmdline
+for p in $CMDLINE; do
+    [ -n "${p%ip=*}" ] && continue
+
+    ip_to_var ${p#ip=}
+
+    # We need to have an ip= line for the specified bootdev
+    [ -n "$NEEDBOOTDEV" ] && [ "$dev" = "$BOOTDEV" ] && BOOTDEVOK=1
+
+    # Empty autoconf defaults to 'dhcp'
+    if [ -z "$autoconf" ] ; then
+	echo "Warning: empty autoconf values default to dhcp"
+	autoconf="dhcp"
+    fi
+
+    # Error checking for autoconf in combination with other values
+    case $autoconf in
+	error) die "Error parsing option '$p'";;
+	bootp|rarp|both) die "Sorry, ip=$autoconf is currenty unsupported";;
+	none|off) \
+	    [ -z "$ip" ] && \
+		die "For argument '$p'\nValue '$autoconf' without static configuration does not make sense"
+	    [ -z "$mask" ] && \
+		die "Sorry, automatic calculation of netmask is not yet supported"
+	    ;;
+	dhcp|on|any) \
+	    [ -n "$NEEDBOOTDEV" ] && [ -z "$dev" ] && \
+	        die "Sorry, '$p' does not make sense for multiple interface configurations"
+	    [ -n "$ip" ] && \
+		die "For argument '$p'\nSorry, setting client-ip does not make sense for '$autoconf'"
+	    ;;
+	*) die "For argument '$p'\nSorry, unknown value '$autoconf'";;
+    esac
+
+    if [ -n "$dev" ] ; then
+        # We don't like duplicate device configs
+	if [ -n "$IFACES" ] ; then
+	    for i in $IFACES ; do
+		[ "$dev" = "$i" ] && die "For argument '$p'\nDuplication configurations for '$dev'"
+	    done
+	fi
+	# IFACES list for later use
+	IFACES="$IFACES $dev"
+    fi
+
+    # Small optimization for udev rules
+    [ -z "$NEEDBOOTDEV" ] && [ -n "$dev" ] && BOOTDEV=$dev
+
+    # Do we need to check for specific options?
+    if [ -n "$NEEDDHCP" ] || [ -n "$DHCPORSERVER" ] ; then
+	# Correct device? (Empty is ok as well)
+	[ "$dev" = "$BOOTDEV" ] || continue
+	# Server-ip is there?
+	[ -n "$DHCPORSERVER" ] && [ -n "$srv" ] && continue
+	# dhcp? (It's simpler to check for a set ip. Checks above ensure that if
+	# ip is there, we're static
+	[ -z "$ip" ] && continue
+	# Not good!
+	die "Server-ip or dhcp for netboot needed, but current arguments say otherwise"
+	
+    fi
+done
+
+# This ensures that BOOTDEV is always first in IFACES
+if [ -n "$BOOTDEV" ] && [ -n "$IFACES" ] ; then 
+    IFACES="${IFACES%$BOOTDEV*} ${IFACES#*$BOOTDEV}"
+    IFACES="$BOOTDEV $IFACES"
+fi
+
+# Store BOOTDEV and IFACES for later use
+[ -n "$BOOTDEV" ] && echo $BOOTDEV > /tmp/net.bootdev
+[ -n "$IFACES" ]  && echo $IFACES > /tmp/net.ifaces
+
+
+
+# We need a ip= line for the configured bootdev= 
+[ -n "$NEEDBOOTDEV" ] && [ -z "$BOOTDEVOK" ] && die "Bootdev Argument '$BOOTDEV' not found"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
