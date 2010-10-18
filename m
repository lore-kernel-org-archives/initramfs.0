From: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Subject: [RFC] [PATCH] Bonding support for dracut
Date: Mon, 18 Oct 2010 15:04:55 +0300
Message-ID: <4CBC37E7.9010904@hoster-ok.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070701030106000507090102"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------070701030106000507090102
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

I attach patch for bonding support in dracut.
It is against 005 (developed on fedora 13 version).
No documentation yet.
(partially) Tested to work correctly with bond0 alone and bridge on top
of bond0.

Comments are welcome,

Best,
Vladislav

--------------070701030106000507090102
Content-Type: text/x-patch;
 name="dracut-005-bonding-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-005-bonding-support.patch"

diff -urNp dracut-005.orig/modules.d/40network/check dracut-005/modules.d/40network/check
--- dracut-005.orig/modules.d/40network/check	2010-03-19 17:35:47.000000000 +0100
+++ dracut-005/modules.d/40network/check	2010-10-14 16:39:39.547565242 +0200
@@ -9,7 +9,7 @@ for program in ip arping; do 
     exit 1
   fi
 done
-for program in dhclient brctl; do
+for program in dhclient brctl ifenslave tr; do
   which $program >/dev/null 2>&1
   if [ $? -ne 0 ]; then
     dwarning "Could not find program \"$program\" it might be required by network." 
diff -urNp dracut-005.orig/modules.d/40network/ifup dracut-005/modules.d/40network/ifup
--- dracut-005.orig/modules.d/40network/ifup	2010-03-19 17:35:47.000000000 +0100
+++ dracut-005/modules.d/40network/ifup	2010-10-13 22:13:32.632014012 +0200
@@ -92,11 +92,25 @@ fi
 # $netif reads easier than $1
 netif=$1
 
+# enslave this interface to bond?
+if [ -e /tmp/bond.info ]; then
+    . /tmp/bond.info
+    for slave in $bondslaves ; do
+        if [ "$netif" = "$slave" ] ; then
+            netif=$bondname
+        fi
+    done
+fi
+
 # bridge this interface?
 if [ -e /tmp/bridge.info ]; then
     . /tmp/bridge.info
     if [ "$netif" = "$ethname" ]; then
-        netif="$bridgename"
+        if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
+            : # We need to really setup bond (recursive call)
+        else
+            netif="$bridgename"
+        fi
     fi
 fi
 
@@ -115,11 +129,62 @@ if [ "$netif" = "lo" ] ; then
     exit 0
 fi
 
+# start bond if needed
+if [ -e /tmp/bond.info ]; then
+    . /tmp/bond.info
+
+    if [ "$netif" = "$bondname" ] && [ ! -e /tmp/net.$bondname.up ] ; then # We are master bond device
+        modprobe bonding
+        ip link set $netif down
+
+        # Stolen from ifup-eth
+        # add the bits to setup driver parameters here
+        for arg in $bondoptions ; do
+            key=${arg%%=*};
+            value=${arg##*=};
+            # %{value:0:1} is replaced with non-bash specific construct
+            if [ "${key}" = "arp_ip_target" -a "${#value}" != "0" -a "+${value%%+*}" != "+" ]; then
+                OLDIFS=$IFS;
+                IFS=',';
+                for arp_ip in $value; do
+                    echo +$arp_ip > /sys/class/net/${netif}/bonding/$key
+                done
+                IFS=$OLDIFS;
+            else
+                echo $value > /sys/class/net/${netif}/bonding/$key
+            fi
+        done
+
+        ip link set $netif up
+
+        for slave in $bondslaves ; do
+            ip link set $slave down
+            ifenslave $bondname $slave
+            ip link set $slave up
+            wait_for_if_up $slave
+        done
+
+        # add the bits to setup the needed post enslavement parameters
+        for arg in $BONDING_OPTS ; do
+            key=${arg%%=*};
+            value=${arg##*=};
+            if [ "${key}" = "primary" ]; then
+                echo $value > /sys/class/net/${DEVICE}/bonding/$key
+            fi
+        done
+    fi
+fi
+
+
 # XXX need error handling like dhclient-script
 
 # start bridge if necessary
 if [ "$netif" = "$bridgename" ] && [ ! -e /tmp/net.$bridgename.up ]; then
-    ip link set $ethname up
+    if [ "$ethname" = "$bondname" ] ; then
+        DO_BOND_SETUP=yes /sbin/ifup $bondname
+    else
+        ip link set $ethname up
+    fi
     wait_for_if_up $ethname
     # Create bridge and add eth to bridge
     brctl addbr $bridgename
diff -urNp dracut-005.orig/modules.d/40network/install dracut-005/modules.d/40network/install
--- dracut-005.orig/modules.d/40network/install	2010-03-19 17:35:47.000000000 +0100
+++ dracut-005/modules.d/40network/install	2010-10-13 14:50:21.307020174 +0200
@@ -1,5 +1,5 @@
 #!/bin/bash
-dracut_install ip dhclient brctl arping
+dracut_install ip dhclient brctl arping ifenslave tr
 inst "$moddir/ifup" "/sbin/ifup"
 inst "$moddir/netroot" "/sbin/netroot"
 inst "$moddir/dhclient-script" "/sbin/dhclient-script"
@@ -8,6 +8,7 @@ inst_hook pre-udev 50 "$moddir/ifname-ge
 inst_hook pre-udev 60 "$moddir/net-genrules.sh"
 inst_hook cmdline 91 "$moddir/dhcp-root.sh"
 inst_hook cmdline 99 "$moddir/parse-ip-opts.sh"
+inst_hook cmdline 97 "$moddir/parse-bond.sh"
 inst_hook cmdline 98 "$moddir/parse-bridge.sh"
 inst_hook cmdline 99 "$moddir/parse-ifname.sh"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
diff -urNp dracut-005.orig/modules.d/40network/installkernel dracut-005/modules.d/40network/installkernel
--- dracut-005.orig/modules.d/40network/installkernel	2010-03-19 17:35:47.000000000 +0100
+++ dracut-005/modules.d/40network/installkernel	2010-10-13 14:50:21.309019550 +0200
@@ -15,3 +15,5 @@ instmods ecb arc4
 # bridge modules
 instmods bridge stp llc
 instmods ipv6
+# bonding
+instmods bonding
diff -urNp dracut-005.orig/modules.d/40network/net-genrules.sh dracut-005/modules.d/40network/net-genrules.sh
--- dracut-005.orig/modules.d/40network/net-genrules.sh	2010-10-13 22:16:17.113266333 +0200
+++ dracut-005/modules.d/40network/net-genrules.sh	2010-10-13 22:08:40.000000000 +0200
@@ -20,6 +20,13 @@ fix_bootif() {
         IFACES=$ethname
     fi
 
+    # bond: attempt only the defined interface (override bridge defines)
+    if [ -e /tmp/bond.info ]; then
+        . /tmp/bond.info
+        # It is enough to fire up only one
+        IFACES=${bondslaves%% *}
+    fi
+
     # BOOTIF says everything, use only that one
     BOOTIF=$(getarg 'BOOTIF=')
     if [ -n "$BOOTIF" ] ; then
diff -urNp dracut-005.orig/modules.d/40network/parse-bond.sh dracut-005/modules.d/40network/parse-bond.sh
--- dracut-005.orig/modules.d/40network/parse-bond.sh	1970-01-01 01:00:00.000000000 +0100
+++ dracut-005/modules.d/40network/parse-bond.sh	2010-10-13 15:46:54.000000000 +0200
@@ -0,0 +1,64 @@
+#!/bin/sh
+#
+# Format:
+#	bond=<bondname>[:<bondslaves>:[:<options>]]
+#
+#	bondslaves is a comma-separated list of physical (ethernet) interfaces
+#	options is a comma-separated list on bonding options (modinfo bonding for details) in format compatible with initscripts
+#	if options include multi-valued arp_ip_target option, then its values should be separated by semicolon.
+#	
+#
+#	bond without parameters assumes bond=bond0:eth0,eth1:balance-rr
+#
+
+# return if bond already parsed
+[ -n "$bondname" ] && return
+
+# Check if bond parameter is valid 
+if getarg bond= >/dev/null ; then
+    if [ -z "$netroot" ] ; then
+	die "No netboot configured, bond is invalid"
+    fi
+fi
+
+# We translate list of slaves to space-separated here to mwke it easier to loop over them in ifup
+# Ditto for bonding options
+parsebond() {
+    local v=${1}:
+    set --
+    while [ -n "$v" ]; do
+        set -- "$@" "${v%%:*}"
+        v=${v#*:}
+    done
+
+    unset bondname bondslaves bondoptions
+    case $# in
+    0)  bondname=bond0; bondslaves="eth0 eth1" ;;
+    1)  bondname=$1; bondslaves="eth0 eth1" ;;
+    2)  bondname=$1; bondslaves=$(echo $2|tr "," " ") ;;
+    3)  bondname=$1; bondslaves=$(echo $2|tr "," " "); bondoptions=$(echo $3|tr "," " ") ;;
+    *)  die "bond= requires zero to four parameters" ;;
+    esac
+}
+
+unset bondname bondslaves bondoptions
+
+# Parse bond for bondname, bondslaves, bondmode and bondoptions
+if getarg bond >/dev/null; then
+    # Read bond= parameters if they exist
+    bond="$(getarg bond=)"
+    if [ ! "$bond" = "bond" ]; then 
+        parsebond "$(getarg bond=)"
+    fi
+    # Simple default bond
+    if [ -z "$bondname" ]; then
+        bondname=bond0
+        bondslaves="eth0 eth1"
+    fi
+    # Make it suitable for initscripts export
+    bondoptions=$(echo $bondoptions|tr ";" ",")
+    echo "bondname=$bondname" > /tmp/bond.info
+    echo "bondslaves=\"$bondslaves\"" >> /tmp/bond.info
+    echo "bondoptions=\"$bondoptions\"" >> /tmp/bond.info
+    return
+fi
diff -urNp dracut-005.orig/modules.d/40network/parse-bridge.sh dracut-005/modules.d/40network/parse-bridge.sh
--- dracut-005.orig/modules.d/40network/parse-bridge.sh	2010-03-19 17:35:47.000000000 +0100
+++ dracut-005/modules.d/40network/parse-bridge.sh	2010-10-13 14:50:21.312268720 +0200
@@ -4,6 +4,7 @@
 #	bridge=<bridgename>:<ethname>
 #
 #	bridge without parameters assumes bridge=br0:eth0
+#	if bonding is enabled, then $bondname will be used instead of 'eth0'
 #
 
 # return if bridge already parsed
@@ -26,7 +27,7 @@ parsebridge() {
 
     unset bridgename ethname
     case $# in
-    0)  bridgename=br0; ethname=eth0 ;;
+    0)  bridgename=br0; ethname=$iface ;;
     1)  die "bridge= requires two parameters" ;;
     2)  bridgename=$1; ethname=$2 ;;
     *)  die "bridge= requires two parameters" ;;
@@ -35,6 +36,14 @@ parsebridge() {
 
 unset bridgename ethname
 
+iface=eth0
+if [ -e /tmp/bond.info ]; then
+    . /tmp/bond.info
+    if [ -n "$bondname" ] ; then
+        iface=$bondname
+    fi
+fi
+
 # Parse bridge for bridgename and ethname
 if getarg bridge >/dev/null; then
     # Read bridge= parameters if they exist
@@ -45,7 +54,7 @@ if getarg bridge >/dev/null; then
     # Simple default bridge
     if [ -z "$bridgename" ]; then
         bridgename=br0
-        ethname=eth0
+        ethname=$iface
     fi
     echo "bridgename=$bridgename" > /tmp/bridge.info
     echo "ethname=$ethname" >> /tmp/bridge.info
diff -urNp dracut-005.orig/modules.d/45ifcfg/write-ifcfg.sh dracut-005/modules.d/45ifcfg/write-ifcfg.sh
--- dracut-005.orig/modules.d/45ifcfg/write-ifcfg.sh	2010-03-19 17:35:47.000000000 +0100
+++ dracut-005/modules.d/45ifcfg/write-ifcfg.sh	2010-10-14 16:12:26.490314021 +0200
@@ -7,12 +7,25 @@ udevadm settle --timeout=30
 
 read IFACES < /tmp/net.ifaces
 
+if [ -e /tmp/bond.info ]; then
+    . /tmp/bond.info
+fi
+
+if [ -e /tmp/bridge.info ]; then
+    . /tmp/bridge.info
+fi
+
+mkdir -p /tmp/ifcfg/
+
 for netif in $IFACES ; do
-    mkdir -p /tmp/ifcfg/
     # bridge?
     unset bridge
+    unset bond
     if [ "$netif" = "$bridgename" ]; then
         bridge=yes
+    elif [ "$netif" = "$bondname" ]; then
+    # $netif can't be bridge and bond at the same time
+        bond=yes
     fi
     cat /sys/class/net/$netif/address > /tmp/net.$netif.hwaddr
     {
@@ -35,29 +48,80 @@ for netif in $IFACES ; do
     } > /tmp/ifcfg/ifcfg-$netif
 
     # bridge needs different things written to ifcfg
-    if [ -z "$bridge" ]; then
+    if [ -z "$bridge" ] && if [ -z "$bond" ]; then
         # standard interface
-	{
+        {
             echo "HWADDR=$(cat /sys/class/net/$netif/address)"
             echo "TYPE=Ethernet"
             echo "NAME=\"Boot Disk\"" 
-	} >> /tmp/ifcfg/ifcfg-$netif
-    else
+        } >> /tmp/ifcfg/ifcfg-$netif
+    fi
+
+    if [ -n "$bond" ] ; then
+        # bond interface
+        {
+            # This variable is an indicator of a bond interface for initscripts
+            echo "BONDING_OPTS=\"$bondoptions\""
+            echo "NAME=\"Boot Disk\""
+        } >> /tmp/ifcfg/ifcfg-$netif
+
+        for slave in $bondslaves ; do
+            # write separate ifcfg file for the raw eth interface
+            {
+                echo "DEVICE=$slave"
+                echo "TYPE=Ethernet"
+                echo "ONBOOT=yes"
+                echo "NETBOOT=yes"
+                echo "HWADDR=$(cat /sys/class/net/$slave/address)"
+                echo "SLAVE=yes"
+                echo "MASTER=$netif"
+                echo "NAME=$slave"
+            } >> /tmp/ifcfg/ifcfg-$slave
+        done
+    fi
+
+    if [ -n "$bridge" ] ; then
         # bridge
 	{
 	    echo "TYPE=Bridge"
             echo "NAME=\"Boot Disk\"" 
 	} >> /tmp/ifcfg/ifcfg-$netif
-        # write separate ifcfg file for the raw eth interface
-	{
-            echo "DEVICE=$ethname"
-            echo "TYPE=Ethernet"
-            echo "ONBOOT=yes"
-            echo "NETBOOT=yes"
-            echo "HWADDR=$(cat /sys/class/net/$ethname/address)"
-            echo "BRIDGE=$netif"
-            echo "NAME=$ethname" 
-	} >> /tmp/ifcfg/ifcfg-$ethname
+        if [ "$ethname" = "$bondname" ] ; then
+            {
+                # This variable is an indicator of a bond interface for initscripts
+                echo "DEVICE=$bondname"
+                echo "ONBOOT=yes"
+                echo "NETBOOT=yes"
+                echo "BONDING_OPTS=\"$bondoptions\""
+                echo "BRIDGE=$netif"
+                echo "NAME=\"$bondname\"" 
+            } >> /tmp/ifcfg/ifcfg-$bondname
+            for slave in $bondslaves ; do
+                # write separate ifcfg file for the raw eth interface
+                # yes, duplicated code at this moment
+                {
+                    echo "DEVICE=$slave"
+                    echo "TYPE=Ethernet"
+                    echo "ONBOOT=yes"
+                    echo "NETBOOT=yes"
+                    echo "HWADDR=$(cat /sys/class/net/$slave/address)"
+                    echo "SLAVE=yes"
+                    echo "MASTER=$bondname"
+                    echo "NAME=$slave"
+                } >> /tmp/ifcfg/ifcfg-$slave
+            done
+        else
+            # write separate ifcfg file for the raw eth interface
+            {
+                echo "DEVICE=$ethname"
+                echo "TYPE=Ethernet"
+                echo "ONBOOT=yes"
+                echo "NETBOOT=yes"
+                echo "HWADDR=$(cat /sys/class/net/$ethname/address)"
+                echo "BRIDGE=$netif"
+                echo "NAME=$ethname" 
+            } >> /tmp/ifcfg/ifcfg-$ethname
+        fi
     fi
 done
 

--------------070701030106000507090102--
