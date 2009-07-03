From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC ONLY 5/5] PROOF-OF-CONCEPT: wait for spanning tree timeout via arping
Date: Fri,  3 Jul 2009 17:40:05 -0400
Message-ID: <8cf3d034e4611fbe661d4585fbfd1a03a6fd094b.1246656269.git.dave@thedillows.org>
References: <cover.1246656269.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1246656269.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1246656269.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1246656269.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

When operating on a switch running a spanning tree, it can take up to
100 seconds for our port to start forwarding traffic after comming up.
Normally, this can be eaten by DHCP's request for an IP, but if we have
a static configuration or need to down the interface to change the MTU, we
will have to eat the timeout again.

Most of the network root protocols will timeout while waiting for traffic
to flow again in this case, so we use ARP pings to determine when the
link is available prior to trying the mount/disk login.
---
 modules.d/40network/dhclient-script |   11 ++++--
 modules.d/40network/ifup            |    8 +++-
 modules.d/40network/install         |    2 +-
 modules.d/40network/netroot         |   67 +++++++++++++++++++++++++++++------
 modules.d/95iscsi/iscsiroot         |   28 +++++++++-----
 modules.d/95nbd/nbdroot             |   12 +++++--
 modules.d/95nfs/nfsroot             |    9 +++--
 7 files changed, 104 insertions(+), 33 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 5b36a40..e440df9 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -13,15 +13,20 @@ setup_interface() {
 
     [ -f /tmp/net.$netif.override ] && . /tmp/net.$netif.override
 
+    echo mynet=$ip/$mask > /tmp/net.$netif.up
+
     if [ -n "$mtu" ] ; then
 	echo ip link set $netif down
 	echo ip link set $netif mtu $mtu
 	echo ip link set $netif up
-    fi > /tmp/net.$netif.up
+    fi >> /tmp/net.$netif.up
 
-    echo ip addr add $ip${mask:+/$mask} ${bcast:+broadcast $bcast} dev $netif >> /tmp/net.$netif.up
+    echo ip addr add $ip/$mask ${bcast:+broadcast $bcast} dev $netif >> /tmp/net.$netif.up
 
-    [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
+    if [ -n "$gw" ]; then
+	echo gw=$gw > /tmp/net.$netif.gw
+	echo ip route add default via $gw dev $netif >> /tmp/net.$netif.gw
+    fi
 
     [ -n "${search}${domain}" ] && echo search $search $domain > /tmp/net.$netif.resolv.conf
     if  [ -n "$namesrv" ] ; then
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 89017bb..404d6d8 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -32,13 +32,17 @@ do_dhcp() {
 
 # Handle static ip configuration
 do_static() {
-{
+    {
+	echo mynet=$ip/$mask
 	echo ip link set $netif up 
 	echo ip addr flush dev $netif
 	echo ip addr add $ip/$mask dev $netif
     } > /tmp/net.$netif.up
 
-    [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
+    if [ -n "$gw" ]; then
+	 echo gw=$gw > /tmp/net.$netif.gw
+	 echo ip route add default via $gw dev $netif >> /tmp/net.$netif.gw
+    fi
     [ -n "$hostname" ] && echo hostname $hostname > /tmp/net.$netif.hostname
 
     echo online > /sys/class/net/$netif/uevent
diff --git a/modules.d/40network/install b/modules.d/40network/install
index 0b76cbd..20e8963 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -1,5 +1,5 @@
 #!/bin/bash
-dracut_install ip dhclient hostname
+dracut_install ip dhclient hostname arping date
 # Include wired net drivers, excluding wireless
 for modname in $(find "/lib/modules/$kernel/kernel/drivers" -name '*.ko'); do
   if nm -uPA $modname | grep -q eth_type_trans; then
diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index 2cf51fa..58bbd2e 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -1,5 +1,29 @@
 #!/bin/sh
 
+apply_mask() {
+    local ip=$1
+    local mask=$2
+    local out i
+
+    for i in 1 2 3 4; do
+	out=$out.$(( ${ip%%.*} & ${mask%%.*} ))
+	ip=${ip#*.}
+	mask=${mask#*.}
+    done
+    echo ${out#.}
+}
+
+is_local() {
+    local server=$1
+    local mynet=$2
+    local mask net
+
+    mask=${mynet#*/}
+    mynet=$(apply_mask ${mynet%/*} $mask)
+    net=$(apply_mask $server $mask)
+    [ "$net" = "$mynet" ]
+}
+
 PATH=$PATH:/sbin:/usr/sbin
 
 . /lib/dracut-lib.sh
@@ -75,8 +99,10 @@ if [ -z "$netroot" ] || [ ! -e "$handler" ] ; then
     die "No handler for netroot type '$netroot'"
 fi
 
-# Now that we have DHCP information, we can fully validate netroot
-$handler checkdhcp $netroot "$server_id" "$new_root_path" || exit 1
+# Now that we have DHCP information, we can get our server
+$handler server $netroot "$server_id" "$new_root_path" || exit 1
+[ -s /tmp/server ] || die "Bug in $handler: did not create /tmp/server"
+read target < /tmp/server
 
 # We're here, so we can assume that upping interfaces is now ok
 [ -z "$IFACES" ] && IFACES="$netif"
@@ -88,8 +114,21 @@ done
 [ -e /tmp/net.$netif.hostname ]    && . /tmp/net.$netif.hostname
 [ -e /tmp/net.$netif.resolv.conf ] && cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
 
+# Wait for traffic to be passable before we continue
+is_local $target $mynet || target=$gw
+
+# FIXME make 120 configurable
+TIMEOUT=$(( $(date +%s) + 120 ))
+while [ -z "$proceed" -a $(date +%s) -lt $TIMEOUT ]; do
+    for iface in $IFACES; do
+	arping -q -f -c 1 -I $iface $target && proceed=1 && break
+    done
+done
+
 # Run the handler to mount/login into the root device
-if $handler mount "$netroot" "$server_id" "$new_root_path" $NEWROOT; then
+if [ -n "$proceed" ] &&
+	$handler mount "$netroot" "$server_id" "$new_root_path" $NEWROOT;
+then
     # Network rootfs mount successful
     for iface in $IFACES ; do
 	[ -f /tmp/dhclient.$iface.lease ] &&    cp /tmp/dhclient.$iface.lease    /tmp/net.$iface.lease
@@ -98,14 +137,20 @@ if $handler mount "$netroot" "$server_id" "$new_root_path" $NEWROOT; then
 
     # Save used netif for later use
     [ ! -f /tmp/net.ifaces ] && echo $netif > /tmp/net.ifaces
-else 
+    exit 0
+fi
+
+if [ -n "$proceed" ]; then
     warn "Mounting root via '$netif' failed"
-    # If we're trying with multiple interfaces, put that one down.
-    # ip down/flush ensures that routeing info goes away as well
-    if [ -z "$BOOTDEV" ] ; then
-	ip link set $netif down
-	ip addr flush dev $netif
-	echo "#empty" > /etc/resolv.conf
-    fi
+else
+    warn "Unable to ARP ping $target via $netif"
+fi
+
+# If we're trying with multiple interfaces, put that one down.
+# ip down/flush ensures that routeing info goes away as well
+if [ -z "$BOOTDEV" ] ; then
+    ip link set $netif down
+    ip addr flush dev $netif
+    echo "#empty" > /etc/resolv.conf
 fi
 exit 0
diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
index d79b663..7f2efa2 100755
--- a/modules.d/95iscsi/iscsiroot
+++ b/modules.d/95iscsi/iscsiroot
@@ -17,9 +17,10 @@ if getarg rdnetdebug; then
 fi
 
 case "$1" in
-    check|checkdhcp)	check_only=1 ;;
-    mount)		;;
-    *)			die "$0 called with invalid command '$1'" ;;
+    check)	check_only=1 ;;
+    server)	server_only=1 ;;
+    mount)	;;
+    *)		die "$0 called with invalid command '$1'" ;;
 esac
 
 # root is in the form
@@ -55,13 +56,6 @@ if [ ! -e /sys/devices/virtual/iscsi_transport ]; then
     fi
 fi
 
-[ -n "$check_only" ] && exit 0
-
-if getarg iscsi_firmware ; then
-	iscsistart -b
-	exit 0
-fi
-
 # override conf settings by command line options
 arg=$(getarg iscsi_initiator)
 [ -n "$arg" ] && iscsi_initiator=$arg
@@ -100,6 +94,20 @@ iscsi_lun=$1; shift
 iscsi_target_name=$*
 IFS="$OLDIFS"
 
+[ -n "$check_only" ] && exit 0
+
+# FIXME need support for service discovery if no server given, or
+# parsing the firmware tables for an IP if iscsi_firmware is in effect
+if [ -n "$server_only" ]; then
+    echo $iscsi_target_ip > /tmp/server
+    exit 0
+fi
+
+if getarg iscsi_firmware ; then
+	iscsistart -b
+	exit 0
+fi
+
 # XXX is this needed?
 getarg ro && iscsirw=ro
 getarg rw && iscsirw=rw
diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
index 55c1b88..9450b84 100755
--- a/modules.d/95nbd/nbdroot
+++ b/modules.d/95nbd/nbdroot
@@ -11,9 +11,10 @@ if getarg rdnetdebug; then
 fi
 
 case "$1" in
-    check|checkdhcp)	check_only=1 ;;
-    mount)		;;
-    *)			die "$0 called with invalid command '$1'" ;;
+    check)	check_only=1 ;;
+    server)	server_only=1 ;;
+    mount)	;;
+    *)		die "$0 called with invalid command '$1'" ;;
 esac
 
 # root is in the form root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
@@ -52,6 +53,11 @@ incol2 /proc/devices nbd || modprobe nbd ||
 [ -z "$nbdport" ] && die "NBD root configuration missing port"
 [ -n "$check_only" ] && exit 0
 
+if [ -n "$server_only" ]; then
+    echo $nbdserver > /tmp/server
+    exit 0
+fi
+
 # look through the NBD options and pull out the ones that need to
 # go before the host etc. Append a ',' so we know we terminate the loop
 nbdopts=${nbdopts},
diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index 8cbfbb8..acfd6b5 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -12,7 +12,7 @@ fi
 
 case "$1" in
     check)	basic_check=1 ;;
-    checkdhcp)	full_check=1 ;;
+    server)	server_only=1 ;;
     mount)	;;
     *)		die "$0 called with invalid command '$1'" ;;
 esac
@@ -101,8 +101,11 @@ fi
 [ -z "$server" ] && die "Required parameter 'server' is missing"
 [ -z "$path" ] && die "NFS root requires a path"
 
-# If we're just validating our options, we're done
-[ -n "$full_check" ] && exit 0
+# If we're just looking for the server...
+if [ -n "$server_only" ]; then
+    echo $server > /tmp/server
+    exit 0
+fi
 
 # Kernel replaces first %s with host name, and falls back to the ip address
 # if it isn't set. Only the first %s is substituted.
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
