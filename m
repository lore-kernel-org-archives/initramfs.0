From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC ONLY 4/5] netroot: move dracut syntax validation to root handlers
Date: Fri,  3 Jul 2009 17:40:04 -0400
Message-ID: <d1aed501ae771d769efcd370f47184f12b9800d6.1246656269.git.dave@thedillows.org>
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

This reduces the argument parsers in the cmdline hook to giving warnings
about usage and translating legacy syntaxes to dracut's syntax. The root
handlers themselves become responsible for validating the dracut syntax.
This simplifies the cmdline parsers and centralizes the syntax parsers,
which keeps them from multiplying as new functionality is added.

/sbin/netroot unfortunately grows a special case for root=dhcp to understand
that [ip:]:/path in the root-path option is handled by nfsroot.
---
 modules.d/40network/netroot          |   27 ++----
 modules.d/95iscsi/iscsiroot          |   30 ++++++-
 modules.d/95iscsi/parse-iscsiroot.sh |   21 +----
 modules.d/95nbd/nbdroot              |   19 ++++-
 modules.d/95nbd/parse-nbdroot.sh     |   34 ++------
 modules.d/95nfs/nfsroot              |  140 ++++++++++++++++++-------------
 modules.d/95nfs/parse-nfsroot.sh     |  155 +++++++++++++---------------------
 7 files changed, 203 insertions(+), 223 deletions(-)

diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
index c9ebf4c..2cf51fa 100755
--- a/modules.d/40network/netroot
+++ b/modules.d/40network/netroot
@@ -52,12 +52,7 @@ netif=$1
 [ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
 [ -z "$server_id" ] && server_id=$new_dhcp_server_identifier
 
-# Figure out the handler for root=dhcp by recalling all netroot cmdline 
-# handlers
 if [ "$netroot" = "dhcp" ] ; then
-    # Unset root so we can check later
-    unset root
-
     # If we have a specific bootdev with no dhcpoptions or empty root-path, 
     # we die. Otherwise we just warn
     if [ -z "$new_root_path" ] ; then
@@ -66,20 +61,13 @@ if [ "$netroot" = "dhcp" ] ; then
 	exit 1
     fi
 
-    # Set netroot to new_root_path, so cmdline parsers don't call
-    netroot=$new_root_path
-
-    for f in ./cmdline/90*.sh; do
-	[ -f "$f" ] && . "$f";
-    done
-else 
-    rootok="1"
+    case "$new_root_path" in
+	[0-9]*:/*|/*) netroot=nfs::: ;;
+	*:|*:*) netroot=$new_root_path ;;
+	*) die "DHCP root-path has no known root protocol" ;;
+    esac
 fi
 
-# Check: do we really know how to handle (net)root?
-[ -z "$root" ] && die "No or empty root= argument"
-[ -z "$rootok" ] && die "Don't know how to handle 'root=$root'"
-
 handler=${netroot%%:*}
 handler=${handler%%4}
 handler="/sbin/${handler}root"
@@ -87,6 +75,9 @@ if [ -z "$netroot" ] || [ ! -e "$handler" ] ; then
     die "No handler for netroot type '$netroot'"
 fi
 
+# Now that we have DHCP information, we can fully validate netroot
+$handler checkdhcp $netroot "$server_id" "$new_root_path" || exit 1
+
 # We're here, so we can assume that upping interfaces is now ok
 [ -z "$IFACES" ] && IFACES="$netif"
 for iface in $IFACES ; do
@@ -98,7 +89,7 @@ done
 [ -e /tmp/net.$netif.resolv.conf ] && cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
 
 # Run the handler to mount/login into the root device
-if $handler "$netroot" "$server_id" "$new_root_path" $NEWROOT; then
+if $handler mount "$netroot" "$server_id" "$new_root_path" $NEWROOT; then
     # Network rootfs mount successful
     for iface in $IFACES ; do
 	[ -f /tmp/dhclient.$iface.lease ] &&    cp /tmp/dhclient.$iface.lease    /tmp/net.$iface.lease
diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
index 923141c..d79b663 100755
--- a/modules.d/95iscsi/iscsiroot
+++ b/modules.d/95iscsi/iscsiroot
@@ -16,8 +16,18 @@ if getarg rdnetdebug; then
     set -x
 fi
 
-# root is in the form root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
-root="$1"
+case "$1" in
+    check|checkdhcp)	check_only=1 ;;
+    mount)		;;
+    *)			die "$0 called with invalid command '$1'" ;;
+esac
+
+# root is in the form
+# root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+root=$2
+server_id=$3
+root_path=$4
+NEWROOT=$5
 
 # read static conf settings
 for conf in conf/conf.d/*; do
@@ -27,10 +37,26 @@ done
 # If it's not iscsi we don't continue
 [ "${root%%:*}" = "iscsi" ] || exit 1
 
+# Check required arguments. there's only one, but it's at the end
+if ! getarg iscsi_firmware; then
+    case "${netroot##iscsi:*:*:*:*:}" in
+	"$netroot"|'') die "Argument targetname for iscsiroot is missing";;
+    esac
+fi
+
 # XXX modprobe crc32c should go in the cmdline parser, but I haven't yet
 # figured out a way how to check whether this is built-in or not
 modprobe crc32c
 
+# ISCSI actually supported?
+if [ ! -e /sys/devices/virtual/iscsi_transport ]; then
+    if ! modprobe iscsi_tcp; then
+	 die "iscsiroot requested but kernel/initrd does not support iscsi"
+    fi
+fi
+
+[ -n "$check_only" ] && exit 0
+
 if getarg iscsi_firmware ; then
 	iscsistart -b
 	exit 0
diff --git a/modules.d/95iscsi/parse-iscsiroot.sh b/modules.d/95iscsi/parse-iscsiroot.sh
index 1ba4277..1774c5e 100755
--- a/modules.d/95iscsi/parse-iscsiroot.sh
+++ b/modules.d/95iscsi/parse-iscsiroot.sh
@@ -55,21 +55,10 @@ if [ -n "$iscsi_firmware" ] ; then
     netroot=${netroot:-iscsi}
 fi
 
-# If it's not iscsi we don't continue
-[ "${netroot%%:*}" = "iscsi" ] || return
+if [ "${netroot%%:*}" = "iscsi" ]; then
+    /sbin/iscsiroot check $netroot || exit 1
 
-# Check required arguments. there's only one, but it's at the end
-if [ -z "$iscsi_firmware" ] ; then
-    case "${netroot##iscsi:*:*:*:*:}" in
-	$netroot|'') die "Argument targetname for iscsiroot is missing";;
-    esac
+    # All good, keep init from complaining
+    rootok=1
+    [ -z "$root" ] && root="iscsi"
 fi
-
-# ISCSI actually supported?
-[ -e /sys/devices/virtual/iscsi_transport ] || modprobe iscsi_tcp || die "iscsiroot requested but kernel/initrd does not support iscsi"
-
-# Done, all good!
-rootok=1
-
-# Shut up init error check
-[ -z "$root" ] && root="iscsi"
diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
index f76211c..55c1b88 100755
--- a/modules.d/95nbd/nbdroot
+++ b/modules.d/95nbd/nbdroot
@@ -10,9 +10,17 @@ if getarg rdnetdebug; then
     set -x
 fi
 
+case "$1" in
+    check|checkdhcp)	check_only=1 ;;
+    mount)		;;
+    *)			die "$0 called with invalid command '$1'" ;;
+esac
+
 # root is in the form root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
-root="$1"
-NEWROOT="$4"
+root=$2
+server_id=$3
+root_path=$4
+NEWROOT=$5
 
 # If it's not nbd we don't continue
 [ "${root%%:*}" = "nbd" ] || return
@@ -37,6 +45,13 @@ if [ -z "$nbdfstype" ]; then
     nbdfstype=auto
 fi
 
+incol2 /proc/devices nbd || modprobe nbd ||
+    die "NBD root requested but no kernel support for NBD client"
+
+[ -z "$nbdserver" ] && die "NBD root configuration missing server"
+[ -z "$nbdport" ] && die "NBD root configuration missing port"
+[ -n "$check_only" ] && exit 0
+
 # look through the NBD options and pull out the ones that need to
 # go before the host etc. Append a ',' so we know we terminate the loop
 nbdopts=${nbdopts},
diff --git a/modules.d/95nbd/parse-nbdroot.sh b/modules.d/95nbd/parse-nbdroot.sh
index 4e0302a..54085f5 100755
--- a/modules.d/95nbd/parse-nbdroot.sh
+++ b/modules.d/95nbd/parse-nbdroot.sh
@@ -9,19 +9,6 @@
 # root= takes precedence over netroot= if root=nbd[...]
 #
 
-# Sadly there's no easy way to split ':' separated lines into variables
-netroot_to_var() {
-    local v=${1}:
-    set --
-    while [ -n "$v" ]; do
-        set -- "$@" "${v%%:*}"
-        v=${v#*:}
-    done
-
-    unset server port 
-    server=$2; port=$3;
-}
-
 # Don't continue if root is ok
 [ -n "$rootok" ] && return
 
@@ -33,24 +20,15 @@ netroot_to_var() {
 if [ "${root%%:*}" = "nbd" ] ; then
     if [ -n "$netroot" ] ; then
 	warn "root takes precedence over netroot. Ignoring netroot"
-
     fi
     netroot=$root
 fi
 
-# If it's not nbd we don't continue
-[ "${netroot%%:*}" = "nbd" ] || return
-
 # Check required arguments
-netroot_to_var $netroot
-[ -z "$server" ] && die "Argument server for nbdroot is missing"
-[ -z "$port" ] && die "Argument port for nbdroot is missing"
+if [ "${netroot%%:*}" = "nbd" ]; then
+    /sbin/nbdroot check "$netroot" || exit 1
 
-# NBD actually supported?
-incol2 /proc/devices nbd || modprobe nbd || die "nbdroot requested but kernel/initrd does not support nbd"
-
-# Done, all good!
-rootok=1
-
-# Shut up init error check
-[ -z "$root" ] && root="nbd"
+    # Done, all good!
+    [ -z "$root" ] && root=netroot
+    rootok=1
+fi
diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index 847ec60..8cbfbb8 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -1,43 +1,5 @@
 #!/bin/sh
 
-# Copy from parse-nfsroot.sh
-root_to_var() {
-    local v=${1}:
-    set --
-    while [ -n "$v" ]; do
-	set -- "$@" "${v%%:*}"
-	v=${v#*:}
-    done
-
-    unset nfs server path options
-
-    # Ugly: Can't -z test $path after the case, since it might be allowed
-    # to be empty for root=nfs
-    nfs=$1
-    case $# in
-    0|1);;
-    2)	path=$2;;
-    3)
-    # This is ultra ugly. But we can't decide in which position path
-    # sits without checking if the string starts with '/'
-    case $2 in
-	/*) path=$2; options=$3;;
-	*) server=$2; path=$3;;
-    esac
-    ;;
-    *)	server=$2; path=$3; options=$4;
-    esac
-    
-    # Does it really start with '/'?
-    [ -n "${path%%/*}" ] && path="error";
-    
-    #Fix kernel legacy style separating path and options with ','
-    if [ "$path" != "${path#*,}" ] ; then
-	options=${path#*,}
-	path=${path%%,*}
-    fi
-}
-
 . /lib/dracut-lib.sh
 
 PATH=$PATH:/sbin:/usr/sbin
@@ -48,39 +10,99 @@ if getarg rdnetdebug ; then
     set -x
 fi
 
+case "$1" in
+    check)	basic_check=1 ;;
+    checkdhcp)	full_check=1 ;;
+    mount)	;;
+    *)		die "$0 called with invalid command '$1'" ;;
+esac
+
 # root is in the form root=nfs[4]:[server:]path[:options], either from
 # cmdline or dhcp root-path
-root="$1"
-server_id=$2
-root_path=$3
-NEWROOT="$4"
-
-# Continue if nfs prefix
-case "${root%%:*}" in
-    nfs|nfs4);;
-    *) return;;
-esac
+root=$2
+server_id=$3
+root_path=$4
+NEWROOT=$5
+
+# First, parse out fields from the [net]root= field
+nfs=${root%%:*}; root=${root#*:}
+server=${root%%:*}; root=${root#*:}
+path=${root%%:*}
+options=${root#*:}
+
+# Handle alternate syntax of path,options
+if [ "$options" = "$path" -a "${root#*,}" != "$root" ]; then
+    path=${root%%,*}
+    options=${root#*,}
+fi
 
-root_to_var $root
+# Catch the case when no additional flags are set
+[ "$path" = "$options" ] && unset options
+
+# Translate the DHCP root-path option to a standard form, removing the
+# nfs[4]: prefix.
+#
+# Order matters in this statement, put comma separated option matches up front
+# to avoid false matching when multiple mount options given
+case "$root_path" in
+    ''|nfs:*)			# empty or dracut nfs:... syntax
+	root_path=${root_path#*:} ;;
+    nfs4:*)			# nfs4:... syntax
+	root_path=${root_path#*:}
+	nfs=nfs4 ;;
+    *:/*,*)			# server:/path,options
+	root_path=${root_path%%,*}:${root_path#*,} ;;
+    *:/*|*:/*:*)		# server:/path or server:/path:options
+	root_path=$root_path ;;
+    /*,*)			# /path,options
+	root_path=:${root_path%%,*}:${root_path#*,} ;;
+    /*)				# /path or /path:options
+	root_path=:${root_path} ;;
+    *) die "Unsupported NFS format in DHCP root-path option" ;;
+esac
 
-#Empty path means try dhcp root-path, this is ok here since parse-nfsroot.sh
-#already takes care of nfs:... formatted root-path
-[ -z "$path" ] && root_to_var $nfs:$root_path
+dhcp_root_server=${root_path%%:*}; root_path=${root_path#*:}
+dhcp_path=${root_path%%:*}
+dhcp_options=${root_path#*:}
+
+# Catch the case when no additional flags are set
+[ "$dhcp_path" = "$dhcp_options" ] && unset dhcp_options
+
+# Now, merge the configurations, preferring the command line arguments first
+[ -z "$server" ] && server=$dhcp_root_server
+[ -z "$server" ] && server=$server_id
+[ -z "$path" ] && path=$dhcp_path
+[ -z "$options" ] && options=$dhcp_options
+[ -z "$nfs" ] && nfs=nfs
+
+# Make sure we have support for this
+if ! incol2 /proc/filesystems $nfs; then
+    modprobe nfs
+    if ! incol2 /proc/filesystems $nfs; then
+	die "NFS root requested, but no kernel support"
+    fi
+fi
 
 #Empty path defaults to "/tftpboot/%s" only in nfsroot.txt legacy mode
 [ -z "$path" ] && [ "$(getarg root=)" = "/dev/nfs" ] && path="/tftpboot/%s"
 
-if [ -z "$server" ] ; then
-    for var in $server_id $root_path '' ; do
-	[ -n "$var" ] && server=$var && break;
-    done
+# Check that path start with a /, if we have one
+[ -n "$path" -a "${path#/}" = "$path" ] &&
+	die "NFS path argument must start with /"
 
-    # XXX This blindly assumes that if new_root_path has to used that 
-    # XXX it really can be used as server
-    server=${server%%:*}
+# If we're only doing the basic checks, just see if we need a server
+# Everything else can be filled in later by DHCP, so we need to wait
+if [ -n "$basic_check" ]; then
+    [ -z "$server" ] && exit 127
+    exit 0
 fi
 
+# Check for required arguments
 [ -z "$server" ] && die "Required parameter 'server' is missing"
+[ -z "$path" ] && die "NFS root requires a path"
+
+# If we're just validating our options, we're done
+[ -n "$full_check" ] && exit 0
 
 # Kernel replaces first %s with host name, and falls back to the ip address
 # if it isn't set. Only the first %s is substituted.
diff --git a/modules.d/95nfs/parse-nfsroot.sh b/modules.d/95nfs/parse-nfsroot.sh
index 23fc3be..cf508c9 100755
--- a/modules.d/95nfs/parse-nfsroot.sh
+++ b/modules.d/95nfs/parse-nfsroot.sh
@@ -1,134 +1,93 @@
 #!/bin/sh
 #
-# Preferred format:
+# Dracut syntax:
 #	root=nfs[4]:[server:]path[:options]
+#	root=dhcp root=nfs[4]:[server:]path[:options]
 #
-# This syntax can come from DHCP root-path as well.
+# Legacy DHCP syntax:
+#	root=dhcp root-path=[server:]/path[(:|,)options]
 #
-# Legacy format:
+# Legacy mkinitrd syntax:
+#	root=server:/path
+#
+# Legacy kernel syntax:
 #	root=/dev/nfs nfsroot=[server:]path[,options]
 #
-# In Legacy root=/dev/nfs mode, if the 'nfsroot' parameter is not given
+# In legacy kernel syntax mode, if the 'nfsroot' parameter is not given
 # on the command line or is empty, the dhcp root-path is used as 
 # [server:]path[:options] or the default "/tftpboot/%s" will be used.
 #
 # If server is unspecified it will be pulled from one of the following
 # sources, in order:
 #	static ip= option on kernel command line
-#	DHCP next-server option
-#	DHCP server-id option
 #       DHCP root-path option
+#	DHCP server-id option
 #
 # NFSv4 is only used if explicitly requested with nfs4: prefix, otherwise
 # NFSv3 is used.
 #
 
-# Sadly there's no easy way to split ':' separated lines into variables
-netroot_to_var() {
-    local v=${1}:
-    set --
-    while [ -n "$v" ]; do
-	set -- "$@" "${v%%:*}"
-	v=${v#*:}
-    done
-
-    unset nfs server path options
-
-    nfs=$1
-    # Ugly: Can't -z test #path after the case, since it might be allowed
-    # to be empty for root=nfs
-    case $# in
-    0|1);;
-    2)	path=${2:-error};;
-    3)
-    # This is ultra ugly. But we can't decide in which position path
-    # sits without checking if the string starts with '/'
-    case $2 in
-	/*) path=$2; options=$3;;
-	*) server=$2; path=${3:-error};;
-    esac
-    ;;
-    *)	server=$2; path=${3:-error}; options=$4;
-    esac
-    
-    # Does it really start with '/'?
-    [ -n "${path%%/*}" ] && path="error";
-    
-    #Fix kernel legacy style separating path and options with ','
-    if [ "$path" != "${path#*,}" ] ; then
-	options=${path#*,}
-	path=${path%%,*}
-    fi
-}
-
 #Don't continue if root is ok
 [ -n "$rootok" ] && return
 
 # This script is sourced, so root should be set. But let's be paranoid
 [ -z "$root" ] && root=$(getarg root=)
 [ -z "$netroot" ] && netroot=$(getarg netroot=)
-[ -z "$nfsroot" ] && nfsroot=$(getarg nfsroot=)
-
-# netroot= cmdline argument must be ignored, but must be used if
-# we're inside netroot to parse dhcp root-path
-if [ -n "$netroot" ] ; then
-    if [ "$netroot" = "$(getarg netroot=)" ] ; then
-        warn "Ignoring netroot argument for NFS"
-        netroot=$root
-    fi
-else
-    netroot=$root;
-fi 
 
-# LEGACY: nfsroot= is valid only if root=/dev/nfs
-if [ -n "$nfsroot" ] ; then
-    # @deprecated
-    warn "Argument nfsroot is deprecated and might be removed in a future release. See http://apps.sourceforge.net/trac/dracut/wiki/commandline for more information."
-    if [ "$(getarg root=)" != "/dev/nfs"  ]; then
-	die "Argument nfsroot only accepted for legacy root=/dev/nfs"
-    fi
-    netroot=nfs:$nfsroot;
-fi
-
-case "$netroot" in
-    /dev/nfs) netroot=nfs;;
-    /dev/*) unset netroot; return;;
-# LEGACY: root=<server-ip>:/<path
-    [0-9]*:/*|[0-9]*\.[0-9]*\.[0-9]*[!:]|/*)
-       netroot=nfs:$netroot;;
+# Disallow netroot=nfs[4]:...
+case "${netroot%%:*}" in
+    nfs|nfs4) die "netroot=nfs[4].... not allowed, use root=nfs[4]...." ;;
 esac
 
-# Continue if nfs
-case "${netroot%%:*}" in
-    nfs|nfs4|/dev/nfs);;
-    *) unset netroot; return;;
+# Convert mkinitrd's root=ip:/path format for NFS to our syntax
+# FIXME need to warn about deprecation?
+case "$root" in
+    [0-9]*:/*) root=nfs:$root ;;
 esac
 
-# Check required arguments
-netroot_to_var $netroot
-[ "$path" = "error" ] && die "Argument nfsroot must contain a valid path!"
+# Enforce legacy nfsroot only with root=/dev/nfs
+if getarg nfsroot && [ "$root" != "/dev/nfs" ]; then
+    die "Legacy nfsroot= can only be combined with root=/dev/nfs"
+fi
 
-# Set fstype, might help somewhere
-fstype=${nfs#/dev/}
+# Convert root=/dev/nfs nfsroot=[[server:]/path[,options]] to our syntax
+if [ "$root" = "/dev/nfs" ]; then
+    # @deprecated
+    warn "root=/dev/nfs support is deprecated and may be removed in a future release. See http://apps.sourceforge.net/trac/dracut/wiki/commandline for more information."
 
-# NFS actually supported? Some more uglyness here: nfs3 or nfs4 might not
-# be in the module...
-if ! incol2 /proc/filesystems $fstype ; then
-    modprobe nfs
-    incol2 /proc/filesystems $fstype || die "nfsroot type $fstype requested but kernel/initrd does not support nfs"
-fi
+    nfsroot=$(getarg nfsroot=)
+    nfsroot_ip=${nfsroot%%:*}; nfsroot=${nfsroot#*:}
+    nfsroot_path=${nfsroot%%,*}
+    nfsroot_opts=${nfsroot#*,}
 
-# Rewrite root so we don't have to parse this uglyness later on again
-netroot="$fstype:$server:$path:$options"
+    [ "$nfsroot_opts" = "$nfsroot_path" ] && unset nfsroot_opts
+    [ "$nfsroot_ip" = "$nfsroot_path" ] && unset nfsroot_ip
 
-# If we don't have a server, we need dhcp
-if [ -z "$server" ] ; then
-    DHCPORSERVER="1"
-fi;
+    root=nfs:$nfsroot_ip:$nfsroot_path:$nfsroot_opts
+    unset nfsroot
+fi
 
-# Done, all good!
-rootok=1
+# Move root=nfs[4]:... to netroot= for handling
+if [ "${root%%:*}" = "nfs" -o "${root%%:*}" = "nfs4" ]; then
+    if [ -n "$netroot" ]; then
+	warn "root takes precedence over netroot. Ignoring netroot"
+    fi
+    netroot=$root
+fi
 
-# Shut up init error check or make sure that block parser wont get 
-# confused by having /dev/nfs[4]
-root="$fstype"
+# Validate our arguments
+case "${netroot%%:*}" in
+    nfs|nfs4)
+	/sbin/nfsroot check "$netroot"
+	case "$?" in
+	    127) DHCPORSERVER="1" ;;
+       	    0)   ;;
+       	    *)   exit 1 ;;
+	esac
+
+	# We're good. Keep the root check in init happy and avoid
+	# confusing the block parser with /dev/nfs
+	rootok=1
+	root=nfs
+	;;
+esac
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
