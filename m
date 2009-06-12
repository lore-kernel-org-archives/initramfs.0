From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [RFC PATCH 2/5] network/netroot
Date: Fri, 12 Jun 2009 17:11:54 +0200
Message-ID: <4A32703A.8080603@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

---
 modules.d/40network/60-net.rules     |    2 -
 modules.d/40network/dhclient.conf    |    3 +++
 modules.d/40network/dhclient-script  |   91 ++++++++------------
 modules.d/40network/dhcp-fallback.sh |   20 ----
 modules.d/40network/ifup             |  158 +++++++++++++++-------------------
 modules.d/40network/install          |    7 +-
 modules.d/40network/netroot          |  156 +++++++++++++++++++++++-----------
 7 files changed, 218 insertions(+), 219 deletions(-)

diff --git a/modules.d/40network/60-net.rules b/modules.d/40network/60-net.rules
deleted file mode 100644
index 6c79508..0000000
--- a/modules.d/40network/60-net.rules
+++ /dev/null
@@ -1,2 +0,0 @@
-ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup $env{INTERFACE}"
-ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/netroot $env{INTERFACE}"
diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 3cc48c8..5d18bff 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -1,9 +1,5 @@
-#!/bin/sh -e
-# very simple dhclient-script.  All it cares about is bringing the interface
-# up, and it does not even try to do anything else.
+#!/bin/sh 
 
-LOG=/tmp/dhclient.$$.log
-ERR=/tmp/network.$$.err
 PATH=$PATH:/sbin:/usr/sbin
 
 . /lib/dracut-lib
@@ -14,73 +10,56 @@ getarg rdnetdebug && {
     set -x
 }
 
-log_err() {
-    # avoid the need for cat on the image
-    echo "On $netif, the following command:" > $ERR
-    echo "    " "$CMD" >> $ERR
-    echo "had errors:" >> $ERR
-    while read line; do echo "     $line"; done < $LOG >> $ERR
-}
-
-# Catch unlikely initial errors
-trap 'echo Errors preparing to configure $netif > $ERR; exit 0' EXIT
-
-netif=$interface
-ip=$new_ip_address
-mtu=$new_interface_mtu
-mask=$new_subnet_mask
-bcast=$new_broadcast_address
-gw=${new_routers%%,*}
-domain=$new_domain_name
-search=$new_domain_search
-namesrv=$new_domain_name_servers
-hostname=$new_host_name
+setup_interface() {
+    netif=$interface
+    ip=$new_ip_address
+    mtu=$new_interface_mtu
+    mask=$new_subnet_mask
+    bcast=$new_broadcast_address
+    gw=${new_routers%%,*}
+    domain=$new_domain_name
+    search=$new_domain_search
+    namesrv=$new_domain_name_servers
+    hostname=$new_host_name
+    
+    [ -f /tmp/net.$netif.override ] && . /tmp/net.$netif.override
 
-[ -f /tmp/dhclient.$interface.override ] && . /tmp/dhclient.$interface.override
+    if [ -n "$mtu" ] ; then
+	echo ip link set $netif down
+	echo ip link set $netif mtu $mtu
+	echo ip link set $netif up
+    fi > /tmp/net.$netif.up
 
-# save the offending command and let udev move on if we have an error
-trap 'log_err; exit 0' EXIT
+    echo ip addr add $ip${mask:+/$mask} ${bcast:+broadcast $bcast} dev $netif >> /tmp/net.$netif.up
 
-run() {
-    CMD="$@"
-    "$@" >> $LOG 2>&1
-}
+    [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
 
-setup_interface() {
-    [ -n "$mtu" ] && {
-	run ip link set $netif down
-	run ip link set $netif mtu $mtu
-	run ip link set $netif up
-    }
-
-    run ip addr add $ip${mask:+/$mask} ${bcast:+broadcast $bcast} dev $netif
-    [ -n "$gw" ] && run ip route add default via $gw
-    [ -n "${search}${domain}" -a -n "$namesrv" ] && {
-	echo search $search $domain > /etc/resolv.conf
+    [ -n "${search}${domain}" ] && echo search $search $domain > /tmp/net.$netif.resolv.conf
+    if  [ -n "$namesrv" ] ; then
 	for s in $namesrv; do
-	    echo nameserver $s >> /etc/resolv.conf
+	    echo nameserver $s 
 	done
-    }
-    [ -e /tmp/hostname.set ] || {
-	[ -n "$hostname" ] && mknod /tmp/hostname.set p && run hostname $hostname
-    }
-    :
+    fi >> /tmp/net.$netif.resolv.conf
+
+    [ -n "$hostname" ] && echo hostname $hostname > /tmp/net.$netif.hostname
 }
 
+# Huh? Interface configured?
+[ -f "/tmp/net.$netif.up" ] && exit 0
+
 case $reason in
     PREINIT)
-	run /sbin/ip link set $netif up
+        ip link set $netif up
 	;;
     BOUND)
 	setup_interface 
 	set | while read line; do
 	    [ "${line#new_}" = "$line" ] && continue
-	    echo "$line" >>/tmp/dhclient.$netif.dhcpopts
-	done
-	>/tmp/net.$netif.up
-	echo online > /sys/class/net/$netif/uevent ;;
+	    echo "$line" 
+	done > /tmp/dhclient.$netif.dhcpopts
+	echo online > /sys/class/net/$netif/uevent
+	;;
     *) ;;
 esac
 
-trap - EXIT
 exit 0
diff --git a/modules.d/40network/dhcp-fallback.sh b/modules.d/40network/dhcp-fallback.sh
deleted file mode 100755
index 484a121..0000000
--- a/modules.d/40network/dhcp-fallback.sh
+++ /dev/null
@@ -1,20 +0,0 @@
-# We should go last, and default the root if needed
-
-if [ -z "$root" -a -z "$netroot" ]; then
-    netroot=dhcp
-fi
-
-if [ "$root" = "dhcp" -a -z "$netroot" ]; then
-    rootok=1
-    netroot=dhcp
-    unset root
-fi
-
-# Cleanup any coversions from root->netroot if they are the same
-if [ "$netroot" = "$root" ]; then
-    unset root
-fi
-
-if [ "${netroot+set}" = "set" ]; then
-    eval "echo netroot='$netroot'" > /tmp/netroot.info
-fi
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 1f0587f..6dac73c 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -1,4 +1,45 @@
 #!/bin/sh
+#
+# We don't need to check for ip= errors here, that is handled by the
+# cmdline parser script
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
+# Fork off dhclient
+do_dhcp() {
+    dhclient -q -cf /etc/dhclient.conf -pf /tmp/dhclient.$netif.pid -lf /dev/.initramfs/dhclient.$netif.lease $netif
+}
+
+# Handle static ip lines
+do_static() {
+    {
+	echo ip link set $netif up 
+	echo ip addr flush dev $netif
+	echo ip addr add $ip/$mask dev $netif
+    } > /tmp/net.$netif.up
+
+    [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
+    [ -n "$hostname" ] && echo hostname $hostname > /tmp/net.$netif.hostname
+
+    echo online > /sys/class/net/$netif/uevent
+}
 
 PATH=$PATH:/sbin:/usr/sbin
 
@@ -10,111 +51,48 @@ getarg rdnetdebug && {
     set -x
 }
 
+# Huh? No $1?
+[ -z "$1" ] && exit 1
+
+# $netif reads easier than $1
 netif=$1
 
-# bail immediately if the interface is already up
-# or we don't need the network
+# Huh? Interface configured?
 [ -f "/tmp/net.$netif.up" ] && exit 0
-[ ! -f /tmp/netroot.info ] && exit 0
 
-# loopback is always handled the same way
-[ "$netif" = "lo" ] && {
+# All hail the great loopback
+if [ "$netif" = "lo" ] ; then
     ip link set lo up
     ip addr add 127.0.0.1/8 dev lo
     >/tmp/net.$netif.up
     exit 0
-}
-
-# XXX need error handling like dhclient-script
-
-die() {
-    echo $netif: "$@" 1>&2
-    exit 1
-}
+fi
 
-do_static() {
-    [ -n "$ip" ] || die "static: need IP address"
-    [ -n "$mask" ] || {
-	net=${ip%%.*}
-	mask=255.0.0.0
-	[ $net -ge 128 ] && mask=255.255.0.0
-	[ $net -ge 192 ] && mask=255.255.255.0
-    }
-    ip addr add $ip/$mask dev $netif || die "static: setting IP $ip/$mask"
-    [ -n "$gw" ] && {
-	ip route add default via $gw dev $netif ||
-	    die "static: setting default route via $gw"
-    }
-    ip link set $netif up 
-    [ -e /tmp/hostname.set ] || {
-	[ -n "$hostname" ] && mknod /tmp/hostname.set p 2>/dev/null &&
-	    hostname $hostname
-    }
-    [ -n "$srv" ] &&
-	echo "new_dhcp_server_identifier=$srv" > /tmp/dhclient.$netif.dhcpopts
+# Handle default
+ip=$(getarg ip)
+[ -z "$(getarg ip)" ] && do_dhcp;
 
-    >/tmp/net.$netif.up
-    echo online > /sys/class/net/$netif/uevent
-}
+# Specific configuration, spin through the kernel command line
+# looking for ip= lines
+[ "$CMDLINE" ] || read CMDLINE </proc/cmdline
+for p in $CMDLINE; do
+    [ -n "${p%ip=*}" ] && continue
 
-do_dhcp() {
-    reqs=subnet-mask,broadcast-address,routers,domain-name
-    reqs=${reqs},domain-name-servers,domain-search
-    reqs=${reqs},host-name,root-path,interface-mtu
+    ip_to_var ${p#ip=}
+	
+    # If option isn't directed at our interface, skip it
+    [ -n "$dev" ] && [ "$dev" != "$netif" ] && continue
 
+    # Store config for later use
     for i in ip srv gw mask hostname; do
 	eval '[ "$'$i'" ] && echo '$i'="$'$i'"'
-    done > /tmp/dhclient.$netif.override
-    [ -n "$ip" ] && echo bcast= >> /tmp/dhclient.$netif.override
-
-    # /sbin/dhclient-script will mark the netif up and generate the online
-    # event for nfsroot
-    # XXX add -V vendor class and option parsing per kernel
-    dhclient -1 -q -R ${reqs} -pf /tmp/dhclient.$netif.pid -lf /tmp/dhclient.$netif.lease $netif
-}
-
-ip_to_var() {
-    local v=${1}:
-    set --
-    while [ -n "$v" ]; do
-	set -- "$@" "${v%%:*}"
-	v=${v#*:}
-    done
+    done > /tmp/net.$netif.override
 
-    unset ip srv gw mask hostname dev autoconf
-    case $# in
-    0)	autoconf=off ;;
-    1)	autoconf=$1 ;;
-    2)	dev=$1; autoconf=$2 ;;
-    *)	ip=$1; srv=$2; gw=$3; mask=$4; hostname=$5; dev=$6; autoconf=$7
-	case $autoconf in
-	    ''|none|off) [ -n "$ip" ] && autoconf=static ;;
-	esac
+    case $autoconf in
+	dhcp|on|any)	 do_dhcp ;;
+    	*)		 do_static ;;
     esac
-    [ -n "$dev" ] || dev=$netif
-    [ -n "$autoconf" ] || autoconf=off
-}
+    break
+done
 
-ip=$(getarg ip)
-if [ -z "$ip" ]; then
-    do_dhcp;
-else
-    # spin through the kernel command line, looking for ip= lines
-    [ "$CMDLINE" ] || read CMDLINE </proc/cmdline;
-    for p in $CMDLINE; do
-	[ -n "${p%ip=*}" ] && continue
-	ip_to_var ${p#ip=}
-	
-        # If this option isn't directed at our interface, skip it
-	[ "$dev" = "$netif" ] || continue
-
-	case $autoconf in
-	    static)		 do_static ;;
-	    dhcp|on|any)	 do_dhcp ;;
-	    bootp|rarp|both) die "autoconfig type $autoconf is not supported" ;;
-	    ''|none|off)	 ;;
-	esac
-	break
-    done
-fi
 exit 0
diff --git a/modules.d/40network/install b/modules.d/40network/install
index 836c57f..95c68d8 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -13,8 +13,11 @@ done
 inst "$moddir/ifup" "/sbin/ifup"
 inst "$moddir/netroot" "/sbin/netroot"
 inst "$moddir/dhclient-script" "/sbin/dhclient-script"
+inst "$moddir/dhclient.conf" "/etc/dhclient.conf"
 instmods ecb arc4
-inst_rules "$moddir/60-net.rules"
-inst_hook cmdline 99 "$moddir/dhcp-fallback.sh"
+inst_hook pre-udev 60 "$moddir/net-genrules.sh"
+inst_hook cmdline 91 "$moddir/dhcp-root.sh"
+inst_hook cmdline 99 "$moddir/parse-ip-opts.sh"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
 mkdir -p "${initdir}/var/run"
+
diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index d874799..eaad4e7 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -8,66 +8,124 @@ getarg rdnetdebug && {
     set -x
 }
 
+# Huh? Empty $1?
+[ -z "$1" ] && exit 1
+
+# Huh? No interface config?
+[ ! -e /tmp/net.$1.up ] && exit 1
+
 # Only try to configure from one network interface at a time
-#
-[ "$NETROOT_LOCKED" ] || {
+if [ "$NETROOT_LOCKED" ] ; then
     NETROOT_LOCKED=true
     export NETROOT_LOCKED
     exec flock -xo /tmp/netroot.lock -c "$0 $*"
     exit 1
-}
+fi
 
+# There's no sense in doing something if no (net)root info is available
+# or root is already there
+[ -e /tmp/root.info ] || exit 1
+. /tmp/root.info
+[ -d $NEWROOT/proc ] && exit 0
+[ -z "$netroot" ] && exit 1
+
+# Let's see if we have to wait for other interfaces
+# Note: exit works just fine, since the last interface to be 
+#       online'd should see all files
+[ -e "/tmp/net.ifaces" ] && read IFACES < /tmp/net.ifaces
+for iface in $IFACES ; do
+    [ -e /tmp/net.$iface.up ] || exit 1
+done
+
+# Set or override primary interface 
 netif=$1
+[ -e "/tmp/net.bootdev" ] && read netif < /tmp/net.bootdev
 
-# If we've already found a root, or we don't have the info we need,
-# then no point in looking further
-#
-[ -e /tmp/netroot.done ] && exit 0
-[ -s /tmp/netroot.info -a -s /tmp/root.info ] || exit 0
+# Figure out the handler for root=dhcp by recalling all netroot cmdline 
+# handlers
+if [ "$netroot" = "dhcp" ] ; then
+    # Load dhcp options
+    [ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
 
-# Pick up our config from the command line; we may already know the
-# handler to run
-#
-. /tmp/root.info
-. /tmp/netroot.info
-[ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
-
-# Now, let the installed network root handlers figure this out
-#
-source_all netroot
-
-# If we didn't get a handler set, then we're done
-#
-if [ -z "$handler" ]; then
-    # XXX informative error message?
-    exit 0
+    # If we have a specific bootdev with no dhcpoptions or empty root-path, 
+    # we die. Otherwise we just warn
+    if [ -z "$new_root_path" ] ; then
+	[ -n "$BOOTDEV" ] && die "No dhcp root-path received for '$BOOTDEV'"
+	echo "Warning: No dhcp root-path received for '$BOOTDEV'"
+	echo "trying other interfaces if available"
+	exit 1
+    fi
+
+    # Split new_root_path into variables, so cmdline parsers don't call
+    # getarg
+    netroot=$new_root_path
+
+    for f in ./cmdline/90*.sh; do
+	[ -f "$f" ] && . "$f";
+    done
+else 
+    rootok="1"
 fi
 
-# Run the handler; don't store the root, it may change from device to device
-# XXX other variables to export?
-export NEWROOT
-if $handler $netif $netroot; then
-    # Network rootfs mount successful
-    [ -f /tmp/dhclient.$netif.lease ] &&    cp /tmp/dhclient.$netif.lease    /tmp/net.$netif.lease
-    [ -f /tmp/dhclient.$netif.dhcpopts ] && cp /tmp/dhclient.$netif.dhcpopts /tmp/net.$netif.dhcpopts
-    [ -f /tmp/dhclient.$netif.override ] && cp /tmp/dhclient.$netif.override /tmp/net.$netif.override
-    cat /sys/class/net/eth0/address > /tmp/net.$netif.hwaddr
-    echo "# Generated by dracut initrd" > /tmp/net.$netif.ifcfg
-    echo "DEVICE=$netif" >> /tmp/net.$netif.ifcfg
-    echo "HWADDR=$(cat /sys/class/net/eth0/address)" >> /tmp/net.$netif.ifcfg
-    echo "TYPE=Ethernet" >> /tmp/net.$netif.ifcfg
-    echo "ONBOOT=yes" >> /tmp/net.$netif.ifcfg
-    if [ -f /tmp/net.$netif.lease ]; then
-        echo "BOOTPROTO=dhcp" >> /tmp/net.$netif.ifcfg
-    else
-        echo "BOOTPROTO=none" >> /tmp/net.$netif.ifcfg
-        # Static: XXX Implement me!
-        #IPADDR=172.16.101.1
-        #NETMASK=255.255.255.0
-        #DNS1=1.2.3.4
-        #DNS2=1.2.3.5
-        #GATEWAY=172.16.101.254
-    fi
+# Check do we really know how to handle (net)root?
+[ -z "$root" ] && die "No or empty root= argument"
+[ -z "$rootok" ] && die "Don't know how to handle 'root=$root'"
+
+handler=${netroot%%:*}
+handler=${handler%%4}
+handler="/sbin/${handler}root"
+if [ -z "$netroot" ] || [ ! -e "$handler" ] ; then
+    die "No handler for netroot type '$netroot'"
+fi
+
+# We're here, so we can assume that upping interfaces is now ok
+[ -z "$IFACES" ] && IFACES="$netif"
+for iface in $IFACES ; do
+    . /tmp/net.$iface.up
+done
+
+[ -e /tmp/net.$netif.gw ]          && . /tmp/net.$netif.gw
+[ -e /tmp/net.$netif.hostname ]    && . /tmp/net.$netif.hostname
+[ -e /tmp/net.$netif.resolv.conf ] && cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
+	
+# Run the handler
+if $handler $netif $netroot $NEWROOT; then
+    # Network rootfs mount successful, store ifaces config
+    # XXX Shouldn't this go into a post-mount script, probably depending on 
+    # XXX rh-style or not?
+    for iface in $IFACES ; do
+	[ -f /tmp/dhclient.$iface.lease ] &&    cp /tmp/dhclient.$iface.lease    /tmp/net.$iface.lease
+	[ -f /tmp/dhclient.$iface.dhcpopts ] && cp /tmp/dhclient.$iface.dhcpopts /tmp/net.$iface.dhcpopts
+        # XXX Is this needed?
+	cat /sys/class/net/eth0/address > /tmp/net.$iface.hwaddr
+    
+	{
+	    echo "# Generated by dracut initrd" > /tmp/net.$iface.ifcfg
+	    echo "DEVICE=$iface" >> /tmp/net.$iface.ifcfg
+	    echo "HWADDR=$(cat /sys/class/net/$iface/address)" >> /tmp/net.$iface.ifcfg
+	    echo "TYPE=Ethernet" >> /tmp/net.$iface.ifcfg
+	    echo "ONBOOT=yes" >> /tmp/net.$iface.ifcfg
+	    if [ -f /tmp/net.$iface.lease ]; then
+		echo "BOOTPROTO=dhcp" >> /tmp/net.$iface.ifcfg
+	    else
+		echo "BOOTPROTO=none" >> /tmp/net.$iface.ifcfg
+		unset ip gw mask
+		. /tmp/net.$iface.override
+		echo "IPADDR=$ip"
+		echo "NETMASK=$mask"
+		[ -n "$gw" ] && echo "GATEWAY=$gw"
+	    fi
+	} > /tmp/net.$iface.ifcfg
+    done
     >/tmp/netroot.done
+else 
+    echo "Warning: Mounting root via '$netif' failed"
+    # If we're trying with multiple interfaces, put that one down
+    # ip down/flush ensures that routeing info goes away as well
+    if [ -z "$BOOTDEV" ] ; then
+	ip link set $netif down
+	ip addr flush dev $netif
+	echo "#empty" > /etc/resolf.conf
+    fi
 fi
 exit 0
diff --git a/modules.d/40network/dhclient.conf b/modules.d/40network/dhclient.conf
new file mode 100644
index 0000000..d6ede26
--- /dev/null
+++ b/modules.d/40network/dhclient.conf
@@ -0,0 +1,3 @@
+request subnet-mask, broadcast-address, time-offset, routers,
+        domain-name, domain-name-servers, domain-search, host-name,
+        root-path, interface-mtu; 
\ No newline at end of file
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
