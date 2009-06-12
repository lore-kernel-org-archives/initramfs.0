From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [RFC PATCH 3/5] nfsroot
Date: Fri, 12 Jun 2009 17:11:59 +0200
Message-ID: <4A32703F.70208@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

---
 modules.d/95nfs/install          |   11 ++-
 modules.d/95nfs/nfs-netroot.sh   |   67 ---------------
 modules.d/95nfs/nfsroot          |  173 ++++++++++++++++++++++++++------------
 modules.d/95nfs/parse-nfsroot.sh |  160 +++++++++++++++++++++++++++--------
 4 files changed, 248 insertions(+), 163 deletions(-)

diff --git a/modules.d/95nfs/install b/modules.d/95nfs/install
index 12cc27d..afb0e41 100755
--- a/modules.d/95nfs/install
+++ b/modules.d/95nfs/install
@@ -1,7 +1,12 @@
 #!/bin/sh
-dracut_install rpcbind rpc.statd mount.nfs mount.nfs4 umount 
-dracut_install /etc/netconfig /etc/passwd /etc/services 
+
+which portmap >/dev/null 2>&1 && dracut_install portmap
+which rpcbind >/dev/null 2>&1 && dracut_install rpcbind
+
+dracut_install rpc.statd mount.nfs mount.nfs4 umount 
+dracut_install /etc/passwd /etc/services 
 dracut_install /etc/nsswitch.conf /etc/rpc /etc/protocols
+[ -f /etc/netconfig ] && dracut_install /etc/netconfig 
 dracut_install rpc.idmapd /etc/idmapd.conf
 if ldd $(which rpc.idmapd) |grep -q lib64; then
     LIBDIR="/lib64"
@@ -11,11 +16,9 @@ fi
 
 dracut_install $(ls {/usr,}$LIBDIR/libnfsidmap*.so* 2>/dev/null )
 dracut_install $(ls {/usr,}$LIBDIR/libnss*.so 2>/dev/null)
-dracut_install grep
 
 instmods nfs sunrpc ipv6
 inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
-inst_hook netroot 90 "$moddir/nfs-netroot.sh"
 inst_hook pre-pivot 70 "$moddir/nfsroot-cleanup.sh"
 inst "$moddir/nfsroot" "/sbin/nfsroot"
 mkdir -p "$initdir/var/lib/nfs/rpc_pipefs"
diff --git a/modules.d/95nfs/nfs-netroot.sh b/modules.d/95nfs/nfs-netroot.sh
deleted file mode 100755
index 71ab00d..0000000
--- a/modules.d/95nfs/nfs-netroot.sh
+++ /dev/null
@@ -1,67 +0,0 @@
-# If we're auto-detecting our root type from DHCP, see if this looks like
-# an NFS root option. As the variety of root-path formats is large, validate
-# that the number of colons match what we expect, and our glob didn't
-# inadvertently match a different handler's.
-#
-if [ "$netroot" = "dhcp" -o "$netroot" = "nfs" -o "$netroot" = "nfs4" ]; then
-    nfsver=nfs
-    if [ "$netroot" = "nfs4" ]; then
-	nfsver=nfs4
-    fi
-    case "$new_root_path" in
-    nfs:*|nfs4:*) netroot="$new_root_path" ;;
-    *:/*:*)
-	if check_occurances "$new_root_path" ':' 2; then
-	    netroot="$nfsver:$new_root_path"
-	fi ;;
-    *:/*,*)
-	if check_occurances "$new_root_path" ':' 1; then
-	    netroot="$nfsver:$new_root_path"
-	fi ;;
-    *:/*)
-	if check_occurances "$new_root_path" ':' 1; then
-	    netroot="$nfsver:$new_root_path:"
-	fi ;;
-    /*:*)
-	if check_occurances "$new_root_path" ':' 1; then
-	    netroot="$nfsver::$new_root_path"
-	fi ;;
-    /*,*)
-	if check_occurances "$new_root_path" ':' 0; then
-	    netroot="$nfsver::$new_root_path"
-	fi ;;
-    /*)
-	if check_occurances "$new_root_path" ':' 0; then
-	    netroot="$nfsver::$new_root_path:"
-	fi ;;
-    '') netroot="$nfsver:::" ;;
-    esac
-fi
-
-if [ -z "${netroot%%nfs:*}" -o -z "${netroot%%nfs4:*}" ]; then
-    # Fill in missing information from DHCP
-    nfsver=${netroot%%:*}; netroot=${netroot#*:}
-    nfsserver=${netroot%%:*}; netroot=${netroot#*:}
-    nfspath=${netroot%%:*}
-    nfsflags=${netroot#*:}
-
-    # XXX where does dhclient stash the next-server option? Do we care?
-    if [ -z "$nfsserver" -o "$nfsserver" = "$nfspath" ]; then
-	nfsserver=$new_dhcp_server_identifier
-    fi
-
-    # Handle alternate syntax of path,options
-    if [ "$nfsflags" = "$nfspath" -a "${netroot#*,}" != "$netroot" ]; then
-	nfspath=${netroot%%,*}
-	nfsflags=${netroot#*,}
-    fi
-
-    # Catch the case when no additional flags are set
-    if [ "$nfspath" = "$nfsflags" ]; then
-	unset nfsflags
-    fi
-
-    # XXX validate we have all the required info?
-    netroot="$nfsver:$nfsserver:$nfspath:$nfsflags"
-    handler=/sbin/nfsroot
-fi
diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index cd3bc7c..e051004 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -4,94 +4,157 @@
 
 PATH=$PATH:/sbin:/usr/sbin
 
-# XXX needs error handling like ifup/dhclient-script
-
 getarg rdnetdebug && {
     exec > /tmp/nfsroot.$1.$$.out
     exec 2>> /tmp/nfsroot.$1.$$.out
     set -x
 }
 
-# root is in the form root=nfs[4]:server:path:[options]
+# Copy from parse-nfsroot.sh
+root_to_var() {
+    local v=${1}:
+    set --
+    while [ -n "$v" ]; do
+	set -- "$@" "${v%%:*}"
+	v=${v#*:}
+    done
+
+    unset nfs server path options
+
+    # Ugly: Can't -z test $path after the case, since it might be allowed
+    # to be empty for root=nfs
+    nfs=$1
+    case $# in
+    0|1);;
+    2)	path=${2:-error};;
+    3)
+    # This is ultra ugly. But we can't decide in which position path
+    # sits without checking if the string starts with '/'
+    case $2 in
+	/*) path=$2; options=$3;;
+	*) server=$2; path=${3:-error};;
+    esac
+    ;;
+    *)	server=$2; path=${3:-error}; options=$4;
+    esac
+    
+    # Does it really start with '/'?
+    [ -n "${path%%/*}" ] && path="error";
+    
+    #Fix kernel legacy style separating path and options with ','
+    if [ "$path" != "${path#*,}" ] ; then
+	options=${path#*,}
+	path=${path%%,*}
+    fi
+}
+
+# Huh? Empty $1?
+[ -z "$1" ] && exit 1
+
+# Huh? Empty $2?
+[ -z "$2" ] && exit 1
+
+# Huh? Empty $3?
+[ -z "$3" ] && exit 1
+
+# root is in the form root=nfs[4]:[server:]path[:options], either from
+# cmdline or dhcp root-path
 netif="$1"
 root="$2"
+NEWROOT="$3"
+
+# If it's not nfs we don't continue
+case "${root%%:*}" in
+    nfs|nfs4);;
+    *) return;;
+esac
+
+# Ugly: root=nfs[4] requires dhcp root-path
+if [ "$root" = "nfs" ] || [ "$root" = "nfs4" ] ; then
+    # No need to check if the file exists. ip cmdline parser takes care of this
+    . /tmp/dhclient.$netif.dhcpopts
+    [ -z "$new_root_path" ] && die "Required dhcp option root-path not available"
+    root=$root:$new_root_path
+fi 
+
+root_to_var $root
+
+#Empty path defaults to "/tftpboot/%s"
+[ -z "$path" ] && path="/tftpboot/%s"
+
+if [ -z "$server" ] ; then
+    # No need to check if the file exists. ip cmdline parser takes care of this
+    . /tmp/dhclient.$netif.dhcpopts
+
+    # XXX new_dhcp_next_server is unconfirmed this is an assumption
+    for var in $new_dhcp_server_identifier $new_dhcp_next_server $new_root_path '' ; do
+	[ -n "$var" ] && server=$var && break;
+    done
+
+    # XXX This blindly assumes that if new_root_path has to used that 
+    # XXX it really can be used as server
+    server=${server%%:*}
+fi
 
-nfsver=${root%%:*}; root=${root#*:}
-nfsserver=${root%%:*}; root=${root#*:}
-nfspath=${root%%:*}
-flags=${root#*:}
-
-[ -z "$nfspath" ] && nfspath=/tftpboot/%s
+[ -z "$server" ] && die "Required parameter 'server' is missing"
 
 # Kernel replaces first %s with host name, and falls back to the ip address
 # if it isn't set. Only the first %s is substituted.
-#
-if [ "${nfspath#*%s}" != "$nfspath" ]; then
+if [ "${path#*%s}" != "$path" ]; then
     ip=$(ip -o -f inet addr show $netif)
     ip=${ip%%/*}
     ip=${ip##* }
     read node < /proc/sys/kernel/hostname
     [ "$node" = "(none)" ] && node=$ip
-    nfspath=${nfspath%%%s*}$node${nfspath#*%s}
+    path=${path%%%s*}$node${path#*%s}
 fi
 
-# look through the flags and see if any are overridden by the command line
-# Append a , so we know we terminate
-flags=${flags},
-while [ -n "$flags" ]; do
-    f=${flags%%,*}
-    flags=${flags#*,}
-    if [ -z "$f" ]; then
-	break
-    fi
-    if [ "$f" = "ro" -o "$f" = "rw" ]; then
-	nfsrw=$f
-	continue
-    fi
-    if [ "$f" = "lock" -o "$f" = "nolock" ]; then
-	nfslock=$f
-	continue
-    fi
-    nfsflags=${nfsflags+$nfsflags,}$f
+# Look through the options and remove rw/locking options
+OLDIFS=$IFS
+IFS=,
+for f in $options ; do
+    [ "$f" = "ro" -o "$f" = "rw" ] && nfsrw=$f && continue
+    [ "$f" = "lock" -o "$f" = "nolock" ] && nfslock=$f && continue
+    flags=${flags:+$flags,}$f
 done
+IFS=$OLDIFS
+options=$flags
 
+# Override rw/ro if set on cmdline
 getarg ro && nfsrw=ro
 getarg rw && nfsrw=rw
-nfsflags=${nfsflags+$nfsflags,}${nfsrw}
 
-# Load the modules so the filesystem type is there
-incol2 /proc/filesystems nfs  || modprobe nfs || exit 1
-incol2 /proc/filesystems nfs4 || modprobe nfs || exit 1
+# Default to ro if unset
+[ -z "$nfsrw" ] && nfsrw=ro
 
-# XXX don't forget to move /var/lib/nfs/rpc_pipefs to new /
+options=${options:+$options,}$nfsrw
 
-# Start rpcbind and rpc.statd as mount won't let us use locks on a NFSv4
-# filesystem without talking to them, even though they are unneeded
-# XXX occasionally saw 'rpcbind: fork failed: No such device' -- why?
-[ -n "$(pidof rpcbind)" ] || rpcbind
-[ -n "$(pidof rpc.statd)" ] || rpc.statd
 
-# XXX should I do rpc.idmapd here, or wait and start in the new root
-# XXX waiting assumes root can read everything it needs right up until
-# XXX we start it...
+# Start rpcbind or portmap
+# FIXME occasionally saw 'rpcbind: fork failed: No such device' -- why?
+[ -x /sbin/portmap ] && [ -z "$(pidof portmap)" ] && portmap
+[ -x /sbin/rpcbind ] && [ -z "$(pidof rpcbind)" ] && rpcbind
 
-# XXX really, want to retry in a loop I think, but not here...
+# XXX Should we loop here?
+if [ "$nfs" = "nfs4" ]; then
+    # Start rpc.statd as mount won't let us use locks on a NFSv4
+    # filesystem without talking to it. NFSv4 does locks internally,
+    # rpc.lockd isn't needed
+    [ -z "$(pidof rpc.statd)" ] && rpc.statd
 
-if [ "$nfsver" = "nfs4" ]; then
     # XXX really needed? Do we need non-root users before we start it in
     # XXX the real root image?
-    if [ -z "$(pidof rpc.idmapd)" ]; then
-	rpc.idmapd
-    fi
-
-    # NFSv4 does locks internally
-    exec mount -t nfs4 -o${nfsflags}${nfslock+,$nfslock} \
-			$nfsserver:$nfspath $NEWROOT
+    [ -z "$(pidof rpc.idmapd)" ] && rpc.idmapd
+    
+    mount -t nfs4 -o$options${nfslock+,$nfslock} \
+			$server:$path $NEWROOT
 fi
 
 # NFSv{2,3} doesn't support using locks as it requires a helper to transfer
 # the rpcbind state to the new root
 #
-[ -z "$nfslock" -o "$nfslock" = "lock" ] &&
-    echo "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
-exec mount -t nfs -onolock,$nfsflags $nfsserver:$nfspath $NEWROOT
+[ "$nfslock" = "lock" ] && \
+    echo "Warning: Locks unsupported on NFSv{2,3}, using nolock"
+
+# XXX Should we loop here?
+mount -t nfs -o$options${options:+,}nolock $server:$path $NEWROOT
diff --git a/modules.d/95nfs/parse-nfsroot.sh b/modules.d/95nfs/parse-nfsroot.sh
index 294ca28..26d1fd2 100755
--- a/modules.d/95nfs/parse-nfsroot.sh
+++ b/modules.d/95nfs/parse-nfsroot.sh
@@ -1,55 +1,141 @@
-# We're 90-nfs.sh to catch root=/dev/nfs
+#!/bin/sh
 #
 # Preferred format:
 #	root=nfs[4]:[server:]path[:options]
-#	netroot=nfs[4]:[server:]path[:options]
+#	[root=*] netroot=nfs[4]:[server:]path[:options]
+#
+# Legacy formats:
+#	[net]root=[[/dev/]nfs[4]] nfsroot=[server:]path[,options]
+#	[net]root=[[/dev/]nfs[4]] nfsroot=[server:]path[:options]
+#
+# If the 'nfsroot' parameter is not given on the command line or is empty,
+# the dhcp root-path is used as [server:]path[:options] or the default
+# "/tftpboot/%s" will be used.
 #
 # If server is unspecified it will be pulled from one of the following
 # sources, in order:
 #	static ip= option on kernel command line
 #	DHCP next-server option
 #	DHCP server-id option
+#       DHCP root-path option
 #
-# Legacy formats:
-#	root=nfs[4]
-#	root=/dev/nfs[4] nfsroot=[server:]path[,options]
+# NFSv4 is only used if explicitly requested; default is NFSv2 or NFSv3
+# depending on kernel configuration
 #
-# Plain "root=nfs" interprets DHCP root-path option as [ip:]path[:options]
-#
-# NFSv4 is only used if explicitly listed; default is NFSv3
+# root= takes precedence over netroot= if root=nfs[...]
 #
 
-case "$root" in
-    nfs|dhcp|'')
-	if getarg nfsroot= > /dev/null; then
-	    root=nfs:$(getarg nfsroot=)
-	fi
-	;;
-    nfs4)
-	if getarg nfsroot= > /dev/null; then
-	    root=nfs4:$(getarg nfsroot=)
-	fi
-	;;
-    /dev/nfs|/dev/nfs4)
-	if getarg nfsroot= > /dev/null; then
-	    root=${root#/dev/}:$(getarg nfsroot=)
-	else
-	    root=${root#/dev/}
-	fi
-	;;
+# Sadly there's no easy way to split ':' separated lines into variables
+netroot_to_var() {
+    local v=${1}:
+    set --
+    while [ -n "$v" ]; do
+	set -- "$@" "${v%%:*}"
+	v=${v#*:}
+    done
+
+    unset nfs server path options
+
+    nfs=$1
+    # Ugly: Can't -z test #path after the case, since it might be allowed
+    # to be empty for root=nfs
+    case $# in
+    0|1);;
+    2)	path=${2:-error};;
+    3)
+    # This is ultra ugly. But we can't decide in which position path
+    # sits without checking if the string starts with '/'
+    case $2 in
+	/*) path=$2; options=$3;;
+	*) server=$2; path=${3:-error};;
+    esac
+    ;;
+    *)	server=$2; path=${3:-error}; options=$4;
+    esac
+    
+    # Does it really start with '/'?
+    [ -n "${path%%/*}" ] && path="error";
+    
+    #Fix kernel legacy style separating path and options with ','
+    if [ "$path" != "${path#*,}" ] ; then
+	options=${path#*,}
+	path=${path%%,*}
+    fi
+}
+
+#Don't continue if root is ok
+[ -n "$rootok" ] && return
+
+# This script is sourced, so root should be set. But let's be paranoid
+[ -z "$root" ] && root=$(getarg root=)
+[ -z "$netroot" ] && netroot=$(getarg netroot=)
+[ -z "$nfsroot" ] && nfsroot=$(getarg nfsroot=)
+
+# Root takes precedence over netroot
+case "${root%%:*}" in
+    nfs|nfs4|/dev/nfs|/dev/nfs4)
+    if [ -n "$netroot" ] ; then
+	echo "Warning: root takes precedence over netroot. Ignoring netroot"
+
+    fi
+    netroot=$root
+    ;;
 esac
 
-if [ -z "$netroot" -a -n "$root" -a -z "${root%%nfs*}" ]; then
-    netroot="$root"
-    unset root
+# If it's not empty or nfs we don't continue
+case "${netroot%%:*}" in
+    ''|nfs|nfs4|/dev/nfs|/dev/nfs4);;
+    *) return;;
+esac
+
+if [ -n "$nfsroot" ] ; then
+    [ -z "$netroot" ]  && netroot=$root
+
+    # @deprecated
+    echo "Warning: Argument nfsroot is deprecated and might be removed in a future"
+    echo "release. See http://apps.sourceforge.net/trac/dracut/wiki/commandline for"
+    echo "more information."
+
+    case "$netroot" in
+	''|nfs|nfs4|/dev/nfs|/dev/nfs4) netroot=${netroot:-nfs}:$nfsroot;;
+	*) die "Argument nfsroot only accepted for empty root= or root=[/dev/]nfs[4]"
+    esac
 fi
 
-case "$netroot" in
-    nfs|nfs4|nfs:*|nfs4:*)
-    	rootok=1
-	if [ -n "$root" -a "$netroot" != "$root" ]; then
-	    echo "WARNING: root= and netroot= do not match, ignoring root="
-	fi
-	unset root
-    ;;
+# If it's not nfs we don't continue
+case "${netroot%%:*}" in
+    nfs|nfs4|/dev/nfs|/dev/nfs4);;
+    *) return;;
+esac
+
+# Check required arguments
+netroot_to_var $netroot
+[ "$path" = "error" ] && die "Argument nfsroot must contain a valid path!"
+
+# Set fstype, might help somewhere
+fstype=${nfs#/dev/}
+
+# NFS actually supported? Some more uglyness here: nfs3 or nfs4 might not
+# be in the module...
+if incol2 /proc/filesystems $fstype ; then
+    modprobe nfs
+    incol2 /proc/filesystems $fstype || die "nfsroot type $fstype requested but kernel/initrd does not support nfs"
+fi
+
+#Rewrite root so we don't have to parse this uglyness later on again
+netroot="${netroot%%:*}:$server:$path:$options"
+
+#Delegate ip= checking to the ip script if we need dhcp/server-ip
+if [ -z "$server" ] ; then
+    NEEDDHCP="1"
+    DHCPORSERVER="1"
+fi;
+
+# Done, all good!
+rootok=1
+
+# Shut up init error check or make sure that block parser wont get 
+# confused by having /dev/nfs[4]
+case "$root" in 
+    ''|/dev/nfs|/dev/nfs4) root="$fstype";;
 esac
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
