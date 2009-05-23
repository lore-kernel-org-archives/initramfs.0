From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 4/5] network: prepare network configuration engine for udev-based nfsroot
Date: Fri, 22 May 2009 22:43:32 -0400
Message-ID: <2ee0215b0d79cd4f03ebd1c564141465e7dca566.1243053563.git.dave@thedillows.org>
References: <cover.1243053563.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243053563.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 

This changes the network config to run dhclient from within udev, and
allows multiple dhclients to run at once. It also sets the hostname and
adds a kernel command line option 'netdebug' to help debug network issues.

This an RFC patch, as I've not tested it since porting to the current
dracut (it worked in HEAD as of April, though).
---
 modules.d/40network/dhclient-script  |   98 ++++++++++++++++----
 modules.d/40network/ifup             |  124 +++++++++++++++++++++-----
 modules.d/40network/install          |    3 +-
 modules.d/40network/kill-dhclient.sh |    5 +-
 modules.d/40network/run-dhclient.sh  |    9 --
 5 files changed, 182 insertions(+), 57 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 895ed1b..7689e04 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -1,27 +1,85 @@
-#!/bin/sh
+#!/bin/sh -e
 # very simple dhclient-script.  All it cares about is bringing the interface
 # up, and it does not even try to do anything else.
 
-case $reason in
-    PREINIT) /sbin/ip link set "$interface" up ;;
-    BOUND) ipopts="$new_ip_address"
-     	[ "$new_interface_mtu" ] && ip link set $interface mtu $new_interface_mtu
-	[ "$new_subnet_mask" ] && ipopts="$ipopts/$new_subnet_mask"
-	[ "$new_broadcast_address" ] && ipopts="$ipopts broadcast $new_broadcast_address"
-	/sbin/ip addr add $ipopts dev $interface
-	[ "$new_routers" ] && /sbin/ip route add default via ${new_routers%%,*} dev $interface
-	[ "$new_domain_name" ] && echo "domain $new_domain_name" > /etc/resolv.conf
-	if [ "$new_domain_search" ]; then
-	    echo "search $new_domain_search" |sed 's/,//g' >> /etc/resolv.conf
-	elif [ "$new_domain_name" ]; then
-	    echo "search $new_domain_name" >> /etc/resolv.conf
-	fi
-	for s in $new_domain_name_servers; do
-	    echo "nameserver $s" >> /etc/resolv.conf
+LOG=/dhclient.$$.log
+ERR=/network.$$.err
+PATH=$PATH:/sbin:/usr/sbin
+
+. /lib/dracut-lib
+
+getarg netdebug && {
+    exec >/dhclient.$interface.$$.out
+    exec 2>>/dhclient.$interface.$$.out
+    set -x
+}
+
+log_err() {
+    # avoid the need for cat on the image
+    echo "On $netif, the following command:" > $ERR
+    echo "    " "$CMD" >> $ERR
+    echo "had errors:" >> $ERR
+    while read line; do echo "     $line"; done < $LOG >> $ERR
+}
+
+# Catch unlikely initial errors
+trap 'echo Errors preparing to configure $netif > $ERR; exit 0' EXIT
+
+netif=$interface
+ip=$new_ip_address
+mtu=$new_interface_mtu
+mask=$new_subnet_mask
+bcast=$new_broadcast_address
+gw=${new_routers%%,*}
+domain=$new_domain_name
+search=$new_domain_search
+namesrv=$new_domain_name_servers
+hostname=$new_host_name
+
+[ -f /net.$interface.override ] && . /net.$interface.override
+
+# save the offending command and let udev move on if we have an error
+trap 'log_err; exit 0' EXIT
+
+run() {
+    CMD="$@"
+    "$@" >> $LOG 2>&1
+}
+
+setup_interface() {
+    [ -n "$mtu" ] && {
+	run ip link set $netif down
+	run ip link set $netif mtu $mtu
+	run ip link set $netif up
+    }
+
+    run ip addr add $ip${mask:+/$mask} ${bcast:+broadcast $bcast} dev $netif
+    [ -n "$gw" ] && run ip route add default via $gw
+    [ -n "${search}${domain}" -a -n "$namesrv" ] && {
+	echo search $search $domain > /etc/resolv.conf
+	for s in $namesrv; do
+	    echo nameserver $s >> /etc/resolv.conf
 	done
-	set |grep -E '^new_[a-z_]+=' |while read line; do
-	    echo "${line%%=*}='${line#*=}'">>/net.$interface.dhcpopts
+    }
+    [ -e /hostname.set ] || {
+	[ -n "$hostname" ] && mknod /hostname.set p && run hostname $hostname
+    }
+}
+
+case $reason in
+    PREINIT)
+	run /sbin/ip link set $netif up
+	;;
+    BOUND)
+	setup_interface 
+	set | while read line; do
+	    [ "${line#new_}" = "$line" ] && continue
+	    echo "$line" >>/net.$netif.dhcpopts
 	done
-	>/net.$interface.up ;;
+	>/net.$netif.up
+	echo online > /sys/class/net/$netif/uevent ;;
     *) ;;
 esac
+
+trap - EXIT
+exit 0
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 744a2ae..284c9df 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -1,36 +1,112 @@
 #!/bin/sh
 
+PATH=$PATH:/sbin:/usr/sbin
+
+. /lib/dracut-lib
+
+getarg netdebug && {
+    exec >/ifup.$1.$$.out
+    exec 2>>/ifup.$1.$$.out
+    set -x
+}
+
+netif=$1
+
 # bail immediatly if the interface is already up
-[ -f "/net.$1.up" ] && exit 0
+[ -f "/net.$netif.up" ] && exit 0
 
 # loopback is always handled the same way
-[ "$1" = "lo" ] && {
-    /sbin/ip link set lo up
-    /sbin/ip addr add 127.0.0.1/8 dev lo
+[ "$netif" = "lo" ] && {
+    ip link set lo up
+    ip addr add 127.0.0.1/8 dev lo
+    >/net.$netif.up
     exit 0
 }
 
+# XXX need error handling like dhclient-script
+
+die() {
+    echo $netif: "$@" 1>&2
+    exit 1
+}
+
+do_static() {
+    [ -n "$ip" ] || die "static: need IP address"
+    [ -n "$mask" ] || {
+	net=${ip%%.*}
+	mask=255.0.0.0
+	[ $net -ge 128 ] && mask=255.255.0.0
+	[ $net -ge 192 ] && mask=255.255.255.0
+    }
+    ip addr add $ip/$mask dev $netif || die "static: setting IP $ip/$mask"
+    [ -n "$gw" ] && {
+	ip route add default via $gw dev $netif ||
+	    die "static: setting default route via $gw"
+    }
+    ip link set $netif up 
+    [ -e /hostname.set ] || {
+	[ -n "$hostname" ] && mknod /hostname.set p 2>/dev/null &&
+	    hostname $hostname
+    }
+    [ -n "$srv" ] &&
+	echo "new_dhcp_server_identifier=$srv" > /net.$netif.dhcpopts
+
+    >/net.$netif.up
+    echo online > /sys/class/net/$netif/uevent
+}
+
+do_dhcp() {
+    reqs=subnet-mask,broadcast-address,routers,domain-name
+    reqs=${reqs},domain-name-servers,domain-search
+    reqs=${reqs},host-name,root-path,interface-mtu
+
+    for i in ip srv gw mask hostname; do
+	eval '[ "$'$i'" ] && echo '$i'="$'$i'"'
+    done > /net.$netif.override
+    [ -n "$ip" ] && echo bcast= >> /net.$netif.override
+
+    # /sbin/dhclient-script will mark the netif up and generate the online
+    # event for nfsroot
+    # XXX add -V vendor class and option parsing per kernel
+    dhclient -1 -q -R ${reqs} -pf /dhclient.$netif.pid $netif
+}
+
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
+    0)	autoconf=off ;;
+    1)	autoconf=$1 ;;
+    2)	dev=$1; autoconf=$2 ;;
+    *)	ip=$1; srv=$2; gw=$3; mask=$4; hostname=$5; dev=$6; autoconf=$7
+	case $autoconf in
+	    ''|none|off) [ -n "$ip" ] && autoconf=static ;;
+	esac
+    esac
+    [ -n "$dev" ] || dev=$netif
+    [ -n "$autoconf" ] || autoconf=off
+}
+
 # spin through the kernel command line, looking for ip= lines
 for p in $(cat /proc/cmdline); do
-    [ "${p%%=*}" = "ip" ] || continue
-    ip=${p#ip=}
-    case $ip in
-	none|off) exit 0;; # we were told to not configure anything
-	dhcp|on|any) >/net.$1.dhcp; exit 0;; 
-	bootp|rarp|both) exit 0;; #dunno how to do this
-	*) echo ${ip} | \
-	    (IFS=':' read client server gw netmask hostname device autoconf
-		if [ -z "$device" -o "$device" = "$1"  ]; then
-		    case $autoconf in
-			dhcp|on|any) >/net.$1.dhcp ;;
-			none|off|'') # do some basic configuration
-			    /sbin/ip link set $1 up
-			    /sbin/ip addr add $client/$netmask dev $1
-			    [ "$gw" ] && /sbin/ip route add default via $gw dev $1
-			    >/net.$1.up ;;
-		    esac
-		fi
-		) ;;
-	*) continue;;
+    [ -n "${p%ip=*}" ] && continue
+    ip_to_var ${p#ip=}
+
+    # If this option isn't directed at our interface, skip it
+    [ "$dev" = "$netif" ] || continue
+
+    case $autoconf in
+	static)		 do_static ;;
+	dhcp|on|any)	 do_dhcp ;;
+	bootp|rarp|both) die "autoconfig type $autoconf is not supported" ;;
+	''|none|off)	 ;;
     esac
+    break
 done
+exit 0
diff --git a/modules.d/40network/install b/modules.d/40network/install
index c0c13fc..7a13348 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -1,10 +1,9 @@
 #!/bin/bash
-dracut_install ip dhclient grep
+dracut_install ip dhclient hostname
 instmods ${modules:-=net}
 inst "$moddir/ifup" "/sbin/ifup"
 inst "$moddir/dhclient-script" "/sbin/dhclient-script"
 instmods =networking ecb arc4
 inst_rules "$moddir/60-net.rules"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
-inst_hook pre-mount 70 "$moddir/run-dhclient.sh"
 mkdir -p "${initdir}/var/run"
diff --git a/modules.d/40network/kill-dhclient.sh b/modules.d/40network/kill-dhclient.sh
index 70deda6..d1d15f4 100755
--- a/modules.d/40network/kill-dhclient.sh
+++ b/modules.d/40network/kill-dhclient.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
 
-pid=$(pidof dhclient)
-[ -n "$pid" ] && kill $pid
+for f in /dhclient.*.pid; do
+    [ "$f" != "/dhclient.*.pid" ] && kill $(cat $f)
+done
diff --git a/modules.d/40network/run-dhclient.sh b/modules.d/40network/run-dhclient.sh
deleted file mode 100755
index bc32883..0000000
--- a/modules.d/40network/run-dhclient.sh
+++ /dev/null
@@ -1,9 +0,0 @@
-#!/bin/sh
-for i in /net.*.dhcp; do
-    [ "$i" = '/net.*.dhcp' ] && break
-    dev=${i#/net.}; dev=${dev%.dhcp}
-    [ -f "/net.$dev.up" ] && continue
-    dhclient  -R 'subnet-mask,broadcast-address,time-offset,routers,domain-name,domain-name-servers,host-name,nis-domain,nis-servers,ntp-servers,root-path' -1 -q $dev &
-done
-wait
-    
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
