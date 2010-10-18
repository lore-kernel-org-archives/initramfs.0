From: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Subject: Re: [RFC] [PATCH] Bonding support for dracut
Date: Mon, 18 Oct 2010 16:48:58 +0300
Message-ID: <4CBC504A.7020002@hoster-ok.com>
References: <4CBC37E7.9010904@hoster-ok.com> <4CBC4661.3020100@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010504040008040306030000"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CBC4661.3020100-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------010504040008040306030000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

18.10.2010 16:06, Harald Hoyer wrote:
> On 10/18/2010 02:04 PM, Vladislav Bogdanov wrote:
>> Hi all,
>>
>> I attach patch for bonding support in dracut.
>> It is against 005 (developed on fedora 13 version).
>> No documentation yet.
>> (partially) Tested to work correctly with bond0 alone and bridge on top
>> of bond0.
>>
>> Comments are welcome,
>>
>> Best,
>> Vladislav
> 
> Please patch against the git version...
> 
> $ git clone git://dracut.git.sourceforge.net/gitroot/dracut/dracut
> 
> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut

This should be it.

--------------010504040008040306030000
Content-Type: text/x-patch;
 name="dracut-bonding-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-bonding-support.patch"

diff --git a/modules.d/40network/check b/modules.d/40network/check
index 26b56b3..f575bd9 100755
--- a/modules.d/40network/check
+++ b/modules.d/40network/check
@@ -15,7 +15,7 @@ for program in ip arping; do
         exit 1
     fi
 done
-for program in dhclient brctl; do
+for program in dhclient brctl ifenslave tr; do
     if ! type -P $program >/dev/null; then
         dwarning "Could not find program \"$program\" it might be required by network." 
     fi
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 5cd6fc5..73e7984 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -92,11 +92,25 @@ exec >>/dev/initlog.pipe 2>>/dev/initlog.pipe
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
+                echo $value > /sys/class/net/${netif}/bonding/$key
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
diff --git a/modules.d/40network/install b/modules.d/40network/install
index a95ba2a..b22cc96 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -1,7 +1,7 @@
 #!/bin/bash
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
-dracut_install ip dhclient brctl arping
+dracut_install ip dhclient brctl arping ifenslave tr
 inst "$moddir/ifup" "/sbin/ifup"
 inst "$moddir/netroot" "/sbin/netroot"
 inst "$moddir/dhclient-script" "/sbin/dhclient-script"
@@ -10,6 +10,7 @@ inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
 inst_hook pre-udev 60 "$moddir/net-genrules.sh"
 inst_hook cmdline 91 "$moddir/dhcp-root.sh"
 inst_hook cmdline 99 "$moddir/parse-ip-opts.sh"
+inst_hook cmdline 97 "$moddir/parse-bond.sh"
 inst_hook cmdline 98 "$moddir/parse-bridge.sh"
 inst_hook cmdline 99 "$moddir/parse-ifname.sh"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
diff --git a/modules.d/40network/installkernel b/modules.d/40network/installkernel
index 1c9ce7d..c5944ab 100755
--- a/modules.d/40network/installkernel
+++ b/modules.d/40network/installkernel
@@ -18,3 +18,5 @@ instmods ecb arc4
 # bridge modules
 instmods bridge stp llc
 instmods ipv6
+# bonding
+instmods bonding
diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
index f8e6056..d24a865 100755
--- a/modules.d/40network/net-genrules.sh
+++ b/modules.d/40network/net-genrules.sh
@@ -24,6 +24,13 @@ fix_bootif() {
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
diff --git a/modules.d/40network/parse-bond.sh b/modules.d/40network/parse-bond.sh
new file mode 100755
index 0000000..5c21bb8
--- /dev/null
+++ b/modules.d/40network/parse-bond.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+#
+# Format:
+#       bond=<bondname>[:<bondslaves>:[:<options>]]
+#
+#       bondslaves is a comma-separated list of physical (ethernet) interfaces
+#       options is a comma-separated list on bonding options (modinfo bonding for details) in format compatible with initscripts
+#       if options include multi-valued arp_ip_target option, then its values should be separated by semicolon.
+#
+#       bond without parameters assumes bond=bond0:eth0,eth1:mode=balance-rr
+#
+
+# return if bond already parsed
+[ -n "$bondname" ] && return
+
+# Check if bond parameter is valid 
+if getarg bond= >/dev/null ; then
+    if [ -z "$netroot" ] ; then
+        die "No netboot configured, bond is invalid"
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
diff --git a/modules.d/40network/parse-bridge.sh b/modules.d/40network/parse-bridge.sh
index 984192f..92a6a33 100755
--- a/modules.d/40network/parse-bridge.sh
+++ b/modules.d/40network/parse-bridge.sh
@@ -28,7 +28,7 @@ parsebridge() {
 
     unset bridgename ethname
     case $# in
-        0)  bridgename=br0; ethname=eth0 ;;
+        0)  bridgename=br0; ethname=$iface ;;
         1)  die "bridge= requires two parameters" ;;
         2)  bridgename=$1; ethname=$2 ;;
         *)  die "bridge= requires two parameters" ;;
@@ -37,6 +37,14 @@ parsebridge() {
 
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
@@ -47,7 +55,7 @@ if getarg bridge >/dev/null; then
     # Simple default bridge
     if [ -z "$bridgename" ]; then
         bridgename=br0
-        ethname=eth0
+        ethname=$iface
     fi
     echo "bridgename=$bridgename" > /tmp/bridge.info
     echo "ethname=$ethname" >> /tmp/bridge.info
diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
index ac3bd90..968d9f0 100755
--- a/modules.d/45ifcfg/write-ifcfg.sh
+++ b/modules.d/45ifcfg/write-ifcfg.sh
@@ -9,12 +9,25 @@ udevadm settle --timeout=30
 
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
@@ -37,29 +50,84 @@ for netif in $IFACES ; do
     } > /tmp/ifcfg/ifcfg-$netif
 
     # bridge needs different things written to ifcfg
-    if [ -z "$bridge" ]; then
+    if [ -z "$bridge" ] && if [ -z "$bond" ]; then
         # standard interface
         {
             echo "HWADDR=$(cat /sys/class/net/$netif/address)"
             echo "TYPE=Ethernet"
             echo "NAME=\"Boot Disk\"" 
         } >> /tmp/ifcfg/ifcfg-$netif
-    else
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
+                echo "# Generated by dracut initrd"
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
-        {
-            echo "DEVICE=$ethname"
-            echo "TYPE=Ethernet"
-            echo "ONBOOT=yes"
-            echo "NETBOOT=yes"
-            echo "HWADDR=$(cat /sys/class/net/$ethname/address)"
-            echo "BRIDGE=$netif"
-            echo "NAME=$ethname" 
-        } >> /tmp/ifcfg/ifcfg-$ethname
+        if [ "$ethname" = "$bondname" ] ; then
+            {
+                # This variable is an indicator of a bond interface for initscripts
+                echo "# Generated by dracut initrd"
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
+                    echo "# Generated by dracut initrd"
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
+                echo "# Generated by dracut initrd"
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
 

--------------010504040008040306030000--
