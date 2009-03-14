From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 1/2] network configuration
Date: Sat, 14 Mar 2009 13:53:05 +0100
Message-ID: <49BBA8B1.6060000@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Add udev based, asynchronous network configuration. 

Before udevd starts, ip= and BOOTIF= are checked, parsed and if
necessary the current udev networking rule overwriten to fire events
only for the selected device.

Actual network configurations from ip= or dhcp are written to tempfiles 
instead of directly applied to the interface. These tempfiles are 
executed later by mininm.sh after reading the interface-name through the
fifo. This way we can sequentially test wich interface works for 
mounting the root-fs, without going through all interfaces when we do 
dhcp.

---
 dracut                               |    2 +-
 modules.d/40network/check            |    5 ++
 modules.d/40network/dhclient-script  |   33 ++++++--------
 modules.d/40network/ifup             |   76 ++++++++++++++++++++++------------
 modules.d/40network/initnet.sh       |   37 ++++++++++++++++
 modules.d/40network/install          |    8 ++-
 modules.d/40network/kill-dhclient.sh |    5 ++-
 modules.d/40network/mininm.sh        |   21 +++++++++
 modules.d/40network/run-dhclient.sh  |    8 ----
 9 files changed, 136 insertions(+), 59 deletions(-)

diff --git a/dracut b/dracut
index eb3ff24..fd09628 100755
--- a/dracut
+++ b/dracut
@@ -63,7 +63,7 @@ trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 export initdir hookdirs dsrc dracutmodules modules
 
 # Create some directory structure first
-for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do 
+for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts tmp; do 
     mkdir -p "$initdir/$d"; 
 done
 
diff --git a/modules.d/40network/check b/modules.d/40network/check
new file mode 100755
index 0000000..b7378c3
--- /dev/null
+++ b/modules.d/40network/check
@@ -0,0 +1,5 @@
+#!/bin/sh
+#
+# This is not a module that should be selected when we try to
+# autoconfigure the initrd 
+exit 1
diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 103e5f0..5dd1201 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -1,27 +1,22 @@
 #!/bin/sh
-# very simple dhclient-script.  All it cares about is bringing the interface
-# up, and it does not even try to do anything else.
+#
+# Does not actually configure the interface. Instead we just write the
+# the necessary steps into an up-script, telling mininm.sh through the
+# FIFO that the interface can be used.
 
 case $reason in
-    PREINIT) /sbin/ip link set "$interface" up ;;
+    PREINIT) ip link set "$interface" up ;;
     BOUND) ipopts="$new_ip_address"
-     	[ "$new_interface_mtu" ] && ip link set $interface mtu $new_interface_mtu
+     	[ "$new_interface_mtu" ] && echo ip link set $interface mtu $new_interface_mtu > /tmp/net.$interface.up
 	[ "$new_subnet_mask" ] && ipopts="$ipopts/$new_subnet_mask"
 	[ "$new_broadcast_address" ] && ipopts="$ipopts broadcast $new_broadcast_address"
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
-	done
-	set |grep -e '^new_[a-z_]=' |while read line; do
-	    echo "${line%%=*}=\'${line#*=}\'">>/net.$interface.dhcpopts
-	done
-	>/net.$interface.up ;;
+
+	echo ip addr add $ipopts dev $interface >> /tmp/net.$interface.up
+
+	[ "$new_routers" ] && echo ip route add default via ${new_routers%%,*} dev $interface >> /tmp/net.$interface.up
+
+	exec 3<>/tmp/iface.fifo
+	echo $interface > /tmp/iface.fifo
+	;;
     *) ;;
 esac
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 067bdf5..a8a6055 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -1,36 +1,58 @@
 #!/bin/sh
+#
+# Simple ifup script called through udev when a new network interface
+# is discovered. Either forks away dhclient or writes the necessary
+# up-script for mininm.sh later on. We can do dhcp asynchronously
+# because the necessary event and configuration for mininm.sh are
+# generated inside dhclient-script. This is a speedup optimization.
+# We assume here that if there's network drivers inside  the initrd,
+# the user wants something. So a missing ip= option is treated as
+# ip=dhcp.
+# Warning: Implementations bootp and arp do not exist yet.
 
-# bail immediatly if the interface is already up
-[ -f "/net.$1.up" ] && exit 0
+ifup_static() {
+    local IFS=':'
+    read client server gw netmask hostname device autoconf
+
+    [ -z "$device" ] || [ "$device" = "$1" ] || return 0;
+
+    [ "$client" ] || return 0;
+    [ "$netmask" ] && client="$client/$netmask"
+
+    echo ip link set $1 up > /tmp/net.$1.up
+    echo ip addr add $client dev $1 >> /tmp/net.$1.up
+
+    [ "$gw" ] && echo ip route add default via $gw dev $1 >> /tmp/net.$1.up
+
+    exec 3<>/tmp/iface.fifo
+    echo $1 > /tmp/iface.fifo
+}
+
+# bail immediatly if the interface is already configured
+[ -f "/tmp/net.$1.up" ] && exit 0
 
 # loopback is always handled the same way
 [ "$1" = "lo" ] && {
-    /sbin/ip link set lo up
-    /sbin/ip addr add 127.0.0.1/8 dev lo
+    ip link set lo up
+    ip addr add 127.0.0.1/8 dev lo
     exit 0
 }
 
-# spin through the kernel command line, looking for ip= lines
-for p in $(cat /proc/cmdline); do
-    [ "${p%ip=*}" ] || continue
-    p=${p#ip=}
-    case $p in
-	none|off) exit 0;; # we were told to not configure anything
-	dhcp|on|any) >/net.$1.dhcp; exit 0;; 
-	bootp|rarp|both) exit 0;; #dunno how to do this
-	*) echo ${ip#ip=} | \
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
-    esac
+# get ip= option
+for p in $(cat /tmp/cmdline); do
+    [ "${p%%=*}" = "ip" ] || continue
+    IP=${p#*=} 
+    break;
 done
+
+
+# set autoconf to dhcp if empty, or no ip= is provided
+autoconf=${IP##*:*:*:*:*:*:}
+[ "$autoconf" ] || autoconf="dhcp"
+
+# Let's do something
+case $autoconf in 
+    bootp|rarp|both) exit 0;;
+    on|any|dhcp) dhclient -q $1 &;;
+    *) echo $IP | ifup_static $1 ;;
+esac
diff --git a/modules.d/40network/initnet.sh b/modules.d/40network/initnet.sh
new file mode 100755
index 0000000..1bbbe0e
--- /dev/null
+++ b/modules.d/40network/initnet.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Makes sure the network fifo is there and creates special udev rules
+# to fire only for network devices we need or want. This is an
+# optimization, it is not strictly necessary.
+
+fix_bootif() {
+    local macaddr=${1##??-}
+    local IFS='-'
+    macaddr=$(for i in ${macaddr} ; do echo -n $i:; done)
+    macaddr=${macaddr%:}
+    echo $macaddr
+}
+
+dst="/lib/udev/rules.d"
+[ -d /etc/udev/rules.d ] && dst="/etc/udev/rules.d"
+
+#Assume the user knows what he's doing when providing a devicename
+BOOTDEV=$(getarg 'ip=')
+[ "$BOOTDEV" ] && [ ! "$BOOTDEV" = "${BOOTDEV#*:}" ] && {
+echo $BOOTDEV
+    BOOTDEV=${BOOTDEV#*:*:*:*:}
+    BOOTDEV=${BOOTDEV%:*}
+
+    [ "$BOOTDEV" ] && printf 'ACTION=="add", SUBSYSTEM=="net", INTERFACE_NAME=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$BOOTDEV" > $dst/60-net.rules
+}
+
+#Prefer mac-address to bootdev, overwrite if provided
+BOOTIF=$(getarg 'BOOTIF=')
+[ "$BOOTIF" ] && {
+    BOOTIF=$(fix_bootif "$BOOTIF")
+
+    printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="/sbin/ifup $env{INTERFACE}"\n' "$BOOTIF" > $dst/60-net.rules
+}
+
+#Syncronization FIFO for mininm.sh
+mkfifo /tmp/iface.fifo
diff --git a/modules.d/40network/install b/modules.d/40network/install
index 3152f0d..ecb5e6c 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -1,8 +1,10 @@
 #!/bin/bash
-dracut_install ip dhclient
+dracut_install ip dhclient mkfifo
 inst "$moddir/ifup" "/sbin/ifup"
 inst "$moddir/dhclient-script" "/sbin/dhclient-script"
-instmods =networking ecb arc4
+instmods =net ecb arc4 af_packet
 inst_rules "$moddir/60-net.rules"
+
+inst_hook pre-udev 10 "$moddir/initnet.sh"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
-inst_hook pre-mount 70 "$moddir/run-dhclient.sh"
+inst_hook mount 40 "$moddir/mininm.sh"
diff --git a/modules.d/40network/kill-dhclient.sh b/modules.d/40network/kill-dhclient.sh
index d519013..ea9b7af 100755
--- a/modules.d/40network/kill-dhclient.sh
+++ b/modules.d/40network/kill-dhclient.sh
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# Dracut initrd should be free of side effects. Kill any runaway
+# dhclients.
 
 pid=$(pidof dhclient)
-[[ $pid ]] && kill $pid
+[[ $pid ]] && kill $pid
\ No newline at end of file
diff --git a/modules.d/40network/mininm.sh b/modules.d/40network/mininm.sh
new file mode 100755
index 0000000..c878982
--- /dev/null
+++ b/modules.d/40network/mininm.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+#
+# Mini network manager: Should be called before trying to mount
+# something. Receives names of ready interfaces through a blocking
+# FIFO, configures that interface and hopes mount will
+# succeed. Otherwise we return here from the init loop and try the
+# next interface. 
+
+#No Netboot? bail out
+[ $NETBOOT ] || continue;
+
+#Deconfigure running interface. Means we've tried one and
+#failed. Ensures that the default route is cleared as well.
+[ $NETIF ] && ip link set $NETIF down
+
+#Read or wait for next ready interface
+read NETIF < /tmp/iface.fifo;
+
+#Configure interface
+[ -e /tmp/net.$NETIF.up ] && . /tmp/net.$NETIF.up
+
diff --git a/modules.d/40network/run-dhclient.sh b/modules.d/40network/run-dhclient.sh
deleted file mode 100755
index afab037..0000000
--- a/modules.d/40network/run-dhclient.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-for i in /net.*.dhcp; do
-    dev=${i#net.}; dev=${i%.dhcp}
-    [ -f "/net.$dev.up" ] && continue
-    dhclient -1 -q $dev &
-done
-wait
-    
\ No newline at end of file


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
