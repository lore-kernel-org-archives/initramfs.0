From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, RHEL-6, updated. 0828d4c3574693ae80c217229e1bba6948dc9509
Date: Wed,  8 Dec 2010 12:09:18 +0000
Message-ID: <E1PQIpo-0008Do-RK@sfp-scmshell-1.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, RHEL-6 has been updated
       via  0828d4c3574693ae80c217229e1bba6948dc9509 (commit)
       via  70dfe537d2167ebc7a32a2f42fe03cea40afb05b (commit)
       via  810270eb0012683068cab8cc44db0268be0994c3 (commit)
       via  aee0e169948e6fef1e688c9db36e68c044d2c282 (commit)
       via  d084697710e8905c9ddc45ac6489b05c67844f60 (commit)
       via  1d942b8875eb5a4d4340628553555f9c45c4f7f9 (commit)
      from  f8dd8dcf14fa3992a90fb4e631c248069fe8ea20 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 0828d4c3574693ae80c217229e1bba6948dc9509
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Dec 8 12:25:12 2010 +0100

    network: add iBFT interface configuration

diff --git a/dracut.8 b/dracut.8
index 1139f75..ce39061 100644
--- a/dracut.8
+++ b/dracut.8
@@ -247,12 +247,17 @@ This parameter can be specified multiple times.
 
 .SS Network
 .TP
-.BR ip= {dhcp|on|any|dhcp6|auto6}
+.BR ip= {dhcp|on|any|dhcp6|auto6|ibft}
 dhcp|on|any: get ip from dhcp server from all interfaces. If root=dhcp, 
 loop sequentially through all interfaces (eth0, eth1, ...) and use the first 
 with a valid DHCP root-path.
+.sp
+\fBauto6\fR: IPv6 autoconfiguration
+.sp
+\fBdhcp6\fR: IPv6 DHCP
+.sp
+\fBibft\fR: iBFT autoconfiguration
 
-auto6: do IPv6 autoconfiguration
 .TP
 .BR ip= <interface>:{dhcp|on|any|dhcp6|auto6}
 dhcp|on|any|dhcp6: get ip from dhcp server on a specific interface
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 6ef1010..ebdaa3c 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -140,6 +140,8 @@ fi
 # looking for ip= lines
 for p in $(getargs ip=); do
     ip_to_var $p
+    # skip ibft
+    [ "$autoconf" = "ibft" ] && continue
 	
     # If this option isn't directed at our interface, skip it
     [ -n "$dev" ] && [ "$dev" != "$netif" ] && continue
diff --git a/modules.d/40network/install b/modules.d/40network/install
index 398d4e4..abfa7a5 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -7,8 +7,8 @@ inst "$moddir/dhclient.conf" "/etc/dhclient.conf"
 inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
 inst_hook pre-udev 60 "$moddir/net-genrules.sh"
 inst_hook cmdline 91 "$moddir/dhcp-root.sh"
-inst_hook cmdline 99 "$moddir/parse-ip-opts.sh"
-inst_hook cmdline 98 "$moddir/parse-bridge.sh"
+inst_hook cmdline 97 "$moddir/parse-bridge.sh"
+inst_hook cmdline 98 "$moddir/parse-ip-opts.sh"
 inst_hook cmdline 99 "$moddir/parse-ifname.sh"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
 
diff --git a/modules.d/40network/parse-ip-opts.sh b/modules.d/40network/parse-ip-opts.sh
index a3c9597..8ec94bf 100755
--- a/modules.d/40network/parse-ip-opts.sh
+++ b/modules.d/40network/parse-ip-opts.sh
@@ -49,11 +49,43 @@ if [ -n "$NEEDBOOTDEV" ] ; then
     [ -z "$BOOTDEV" ] && die "Bootdev argument is empty"
 fi
 
+if [ "ibft" = "$(getarg ip=)" ]; then
+    modprobe ibft
+    num=0
+    (   
+	for iface in /sys/firmware/ibft/ethernet*; do
+	    [ -e ${iface}/mac ] || continue
+            ifname_mac=$(read a < ${iface}/mac; echo $a)
+	    [ -z "$ifname_mac" ] || continue
+            ifname_if=ibft$num
+	    num=$(( $num + 1 ))
+	    echo "ifname=$ifname_if:$ifname_mac"
+	    dev=$ifname_if
+
+	    dhcp=$(read a < ${iface}/dhcp; echo $a)
+	    if [ -n "$dhcp" ]; then
+		echo "ip=$dev:dhcp"
+	    else
+		ip=$(read a < ${iface}/ip-addr; echo $a)
+		gw=$(read a < ${iface}/gateway; echo $a)
+		mask=$(read a < ${iface}/subnet-mask; echo $a)
+		hostname=$(read a < ${iface}/hostname; echo $a)
+		echo "ip=$ip::$gw:$mask:$hostname:$dev:none"
+	    fi
+	done
+    ) >> /etc/cmdline
+    # reread cmdline
+    unset CMDLINE
+fi
+
 # Check ip= lines
 # XXX Would be nice if we could errorcheck ip addresses here as well
 for p in $(getargs ip=); do
     ip_to_var $p
 
+    # skip ibft
+    [ "$autoconf" = "ibft" ] && continue
+
     # We need to have an ip= line for the specified bootdev
     [ -n "$NEEDBOOTDEV" ] && [ "$dev" = "$BOOTDEV" ] && BOOTDEVOK=1
 
commit 70dfe537d2167ebc7a32a2f42fe03cea40afb05b
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Dec 7 16:55:06 2010 +0100

    fcoe: add EDD parsing

diff --git a/dracut.8 b/dracut.8
index 45d3295..1139f75 100644
--- a/dracut.8
+++ b/dracut.8
@@ -358,10 +358,10 @@ will read the iscsi parameter from the BIOS firmware
 
 .SS FCoE
 .TP
-.BR netroot= fcoe:<interface|MAC>:<dcb|nodcb>
-Try to connect to a FCoE SAN through the NIC specified by <interface> or <MAC>,
-for the second argument, currently only nodcb is supported. Note letters in
-the MAC-address must be lowercase!
+.BR fcoe=<edd|interface|MAC>:<dcb|nodcb>
+Try to connect to a FCoE SAN through the NIC specified by <interface> or <MAC> or EDD settings.
+Note letters in the MAC-address must be lowercase!
+This parameter can be specified multiple times.
 
 .SS NBD
 .TP
diff --git a/modules.d/95fcoe/install b/modules.d/95fcoe/install
index db08a34..d022f6c 100755
--- a/modules.d/95fcoe/install
+++ b/modules.d/95fcoe/install
@@ -9,5 +9,5 @@ inst vconfig
 mkdir -p "$initdir/var/lib/lldpad"
 
 inst "$moddir/fcoe-up" "/sbin/fcoe-up"
-inst_hook pre-udev 60 "$moddir/fcoe-genrules.sh"
+inst "$moddir/fcoe-genrules.sh" "/sbin/fcoe-genrules.sh"
 inst_hook cmdline 99 "$moddir/parse-fcoe.sh"
diff --git a/modules.d/95fcoe/installkernel b/modules.d/95fcoe/installkernel
index 5ce7ca8..61c3607 100755
--- a/modules.d/95fcoe/installkernel
+++ b/modules.d/95fcoe/installkernel
@@ -1,2 +1,2 @@
 #!/bin/bash
-instmods fcoe 8021q
+instmods fcoe 8021q edd
diff --git a/modules.d/95fcoe/parse-fcoe.sh b/modules.d/95fcoe/parse-fcoe.sh
index 26a5a1a..52def0a 100755
--- a/modules.d/95fcoe/parse-fcoe.sh
+++ b/modules.d/95fcoe/parse-fcoe.sh
@@ -18,6 +18,9 @@
 # If it's not set we don't continue
 [ -z "$fcoe" ] && return
 
+# FCoE actually supported?
+[ -e /sys/module/fcoe/parameters/create ] || modprobe fcoe || die "FCoE requested but kernel/initrd does not support FCoE"
+
 parse_fcoe_opts() {
     local IFS=:
     set $fcoe
@@ -26,22 +29,51 @@ parse_fcoe_opts() {
         2)
             fcoe_interface=$1
             fcoe_dcb=$2
+            return 0
             ;;
         7)
             fcoe_mac=$1:$2:$3:$4:$5:$6
             fcoe_dcb=$7
+            return 0
             ;;
         *)
-            die "Invalid arguments for fcoe="
+            warn "Invalid arguments for fcoe=$fcoe"
+            return 1
             ;;
     esac
 }
 
 parse_fcoe_opts
 
-if [ "$fcoe_dcb" != "nodcb" -a "$fcoe_dcb" != "dcb" ] ; then
-    die "Invalid FCoE DCB option: $fcoe_dcb"
+if [ "$fcoe_interface" = "edd" ]; then
+    if [ "$fcoe_dcb" != "nodcb" -a "$fcoe_dcb" != "dcb" ] ; then
+        warn "Invalid FCoE DCB option: $fcoe_dcb"
+    fi
+    [ -d /sys/firmware/edd ] || modprobe edd
+    # parse edd interfaces
+    for disk in /sys/firmware/edd/int13_*; do
+        [ -d $disk ] || continue
+        for nic in ${disk}/pci_dev/net/*; do
+            [ -d $nic ] || continue
+            if [ -e ${nic}/address ]; then
+                unset fcoe_mac
+                unset fcoe_interface
+                fcoe_mac=$(cat ${nic}/address)
+                [ -n "$fcoe_mac" ] && source /sbin/fcoe-genrules.sh
+            fi
+        done
+    done
+else
+    for fcoe in $(getargs fcoe=); do
+        unset fcoe_mac
+        unset fcoe_interface
+        parse_fcoe_opts
+        if [ "$fcoe_dcb" != "nodcb" -a "$fcoe_dcb" != "dcb" ] ; then
+            warn "Invalid FCoE DCB option: $fcoe_dcb"
+        fi
+        source /sbin/fcoe-genrules.sh
+    done
+else
+    warn "Invalid arguments for fcoe=$fcoe"
 fi
 
-# FCoE actually supported?
-[ -e /sys/module/fcoe/parameters/create ] || modprobe fcoe || die "FCoE requested but kernel/initrd does not support FCoE"
commit 810270eb0012683068cab8cc44db0268be0994c3
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Jul 20 11:23:14 2010 +0200

    multipath: install by default, but run only if wwids are present

diff --git a/modules.d/90multipath/check b/modules.d/90multipath/check
index cae2052..b1834b5 100755
--- a/modules.d/90multipath/check
+++ b/modules.d/90multipath/check
@@ -14,10 +14,12 @@ is_mpath() {
     return 1
 }
 
-# Do mpath if we appear to be using it for /
-rootdev=$(find_root_block_device)
-if [[ $rootdev ]]; then
-    check_block_and_slaves is_mpath "$rootdev" && exit 0
+if [[ $1 = -h ]]; then
+    rootdev=$(find_root_block_device)
+    if [[ $rootdev ]]; then
+        check_block_and_slaves is_mpath "$rootdev" && exit 0
+    fi
+    exit 1
 fi
 
-exit 1
+exit 0
\ No newline at end of file
diff --git a/modules.d/90multipath/multipathd.sh b/modules.d/90multipath/multipathd.sh
index e26ab84..c9a2b3f 100755
--- a/modules.d/90multipath/multipathd.sh
+++ b/modules.d/90multipath/multipathd.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-if [ -e /etc/multipath.conf ]; then
+if [ -e /etc/multipath.conf -a -e /etc/multipath/wwids ]; then
     modprobe dm-multipath
     multipathd
 else
commit aee0e169948e6fef1e688c9db36e68c044d2c282
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Mon Dec 6 16:20:43 2010 +0100

    multipath/install: install the complete /etc/multipath directory
    
    Resolves: rhbz#630911

diff --git a/modules.d/90multipath/install b/modules.d/90multipath/install
index ed2d698..c7774e9 100755
--- a/modules.d/90multipath/install
+++ b/modules.d/90multipath/install
@@ -16,7 +16,7 @@ for f in  \
     /sbin/xdrgetprio \
     /etc/xdrdevices.conf \
     /etc/multipath.conf \
-    /etc/multipath/wwids \
+    /etc/multipath/* \
     $(ls $LIBDIR/libmultipath* $LIBDIR/multipath/* 2>/dev/null) \
     	;do
     [ -e "$f" ] && inst "$f"
commit d084697710e8905c9ddc45ac6489b05c67844f60
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Dec 7 15:35:08 2010 +0100

    mkinitrd-dracut.sh: add "--force"
    
    Resolves: rhbz#626389
    
    Conflicts:
    
    	mkinitrd-dracut.sh

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index dd745d7..b6b8a34 100644
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -68,7 +68,7 @@ while [ $# -gt 0 ]; do
         -v|--verbose)
             dracut_args="${dracut_args} -v"
             ;;
-        -f)
+        -f|--force)
             dracut_args="${dracut_args} -f"
             ;;
         --preload*)
commit 1d942b8875eb5a4d4340628553555f9c45c4f7f9
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Aug 10 15:54:03 2010 +0200

    dracut-functions: filter_kernel_modules() search in extra dirs
    
    search also in "extra" and "weak-updates" for kernel modules
    https://bugzilla.redhat.com/show_bug.cgi?id=622641

diff --git a/dracut-functions b/dracut-functions
index a9b763e..99e0c2e 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -463,7 +463,7 @@ for_each_kmod_dep() {
 # This function returns the full filenames of modules that match $1
 filter_kernel_modules () (
     if ! [[ $hostonly ]]; then
-        filtercmd='find "$srcmods/kernel/drivers" "$srcmods/extra" "$srcmods/weak-updates" -name "*.ko" -o -name "*.ko.gz" 2>/dev/null'
+        filtercmd='find "$srcmods/kernel/drivers" "$srcmods/updates" "$srcmods/extra" "$srcmods/weak-updates" -name "*.ko" -o -name "*.ko.gz" 2>/dev/null'
     else
 	filtercmd='cut -d " " -f 1 </proc/modules|xargs modinfo -F filename -k $kernel'
     fi
-----------------------------------------------------------------------

Summary of changes:
 dracut-functions                     |    2 +-
 dracut.8                             |   17 +++++++++-----
 mkinitrd-dracut.sh                   |    2 +-
 modules.d/40network/ifup             |    2 +
 modules.d/40network/install          |    4 +-
 modules.d/40network/parse-ip-opts.sh |   32 +++++++++++++++++++++++++
 modules.d/90multipath/check          |   12 +++++----
 modules.d/90multipath/install        |    2 +-
 modules.d/90multipath/multipathd.sh  |    2 +-
 modules.d/95fcoe/install             |    2 +-
 modules.d/95fcoe/installkernel       |    2 +-
 modules.d/95fcoe/parse-fcoe.sh       |   42 +++++++++++++++++++++++++++++----
 12 files changed, 97 insertions(+), 24 deletions(-)


-- 
dracut - Initramfs generator using udev
