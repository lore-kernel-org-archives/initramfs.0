From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [RFC PATCH 4/5] nbdroot
Date: Fri, 12 Jun 2009 17:12:07 +0200
Message-ID: <4A327047.7010402@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

---
 modules.d/95nbd/install          |    1 -
 modules.d/95nbd/nbd-netroot.sh   |    9 ---
 modules.d/95nbd/nbdroot          |   21 ++++++--
 modules.d/95nbd/parse-nbdroot.sh |  112 ++++++++++++++++++++++++--------------
 4 files changed, 89 insertions(+), 54 deletions(-)

diff --git a/modules.d/95nbd/install b/modules.d/95nbd/install
index 3a80da1..eca74e4 100755
--- a/modules.d/95nbd/install
+++ b/modules.d/95nbd/install
@@ -2,6 +2,5 @@
 
 inst nbd-client
 inst_hook cmdline 90 "$moddir/parse-nbdroot.sh"
-inst_hook netroot 90 "$moddir/nbd-netroot.sh"
 inst "$moddir/nbdroot" "/sbin/nbdroot"
 instmods nbd
diff --git a/modules.d/95nbd/nbd-netroot.sh b/modules.d/95nbd/nbd-netroot.sh
deleted file mode 100755
index 9513982..0000000
--- a/modules.d/95nbd/nbd-netroot.sh
+++ /dev/null
@@ -1,9 +0,0 @@
-if [ "$netroot" = "dhcp" ]; then
-    if [ -n "$new_root_path" -a -z "${new_root_path%%nbd:*}" ]; then
-	netroot="$new_root_path"
-    fi
-fi
-
-if [ -z "${netroot%nbd:*}" ]; then
-    handler=/sbin/nbdroot
-fi
diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
index b7f4cc4..5860eb5 100755
--- a/modules.d/95nbd/nbdroot
+++ b/modules.d/95nbd/nbdroot
@@ -12,9 +12,22 @@ if getarg rdnetdebug; then
     set -x
 fi
 
-# root is in the form root=nbd:server:port:fstype:fsopts:nbdopts
+# Huh? Empty $1?
+[ -z "$1" ] && exit 1
+
+# Huh? Empty $2?
+[ -z "$2" ] && exit 1
+
+# Huh? Empty $3?
+[ -z "$3" ] && exit 1
+
+# root is in the form root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
 netif="$1"
 root="$2"
+NEWROOT="$3"
+
+# If it's not nbd we don't continue
+[ "${root%%:*}" = "nbd" ] || return
 
 root=${root#nbd:}
 nbdserver=${root%%:*}; root=${root#*:}
@@ -71,8 +84,6 @@ getarg ro && nbdrw=ro
 getarg rw && nbdrw=rw
 fsopts=${fsopts+$fsopts,}${nbdrw}
 
-incol2 /proc/devices nbd || modprobe nbd || exit 1
-
 # XXX better way to wait for the device to be made?
 i=0
 while [ ! -b /dev/nbd0 ]; do
@@ -83,14 +94,16 @@ done
 
 # If we didn't get a root= on the command line, then we need to
 # add the udev rules for mounting the nbd0 device
+
 if [ ! -e /etc/udev/rules.d/99-mount.rules ]; then
     printf 'KERNEL=="%s", RUN+="/bin/mount -t %s -o %s %s %s"\n' \
 	nbd0 "$nbdfstype" "$fsopts" /dev/nbd0 "$NEWROOT" \
-		> /etc/udev/rules.d/99-mount.rules
+	> /etc/udev/rules.d/99-mount.rules
 fi
 
 nbd-client $preopts "$nbdserver" "$nbdport" /dev/nbd0 $opts || exit 1
 
 # NBD doesn't emit uevents when it gets connected, so kick it
 echo change > /sys/block/nbd0/uevent
+
 exit 0
diff --git a/modules.d/95nbd/parse-nbdroot.sh b/modules.d/95nbd/parse-nbdroot.sh
index 426d281..58a27aa 100755
--- a/modules.d/95nbd/parse-nbdroot.sh
+++ b/modules.d/95nbd/parse-nbdroot.sh
@@ -1,51 +1,83 @@
-# It'd be nice if this could share rules with 99-block.sh, but since
-# the kernel side adds nbd{1..16} when the module is loaded -- before
-# they are associated with a server -- we cannot use the udev add rule
-# to find it
-#
-# XXX actually we could, if we move to root=XXX and netroot=XXX, then
-# you could do root=LABEL=/ nbdroot=XXX, or netroot=nbd:XXX
-#
-# However, we need to be 90-nbd.sh to catch root=/dev/nbd*
+#!/bin/sh
 #
 # Preferred format:
 #	root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
+#	[root=*] netroot=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
 #
-# nbdopts is a comma seperated list of options to give to nbd-client
+# Legacy formats:
+#	[net]root=[nbd] nbdroot=srv,port
+#	[net]root=[nbd] nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
 #
+# nbdopts is a comma seperated list of options to give to nbd-client
 #
-# Legacy formats:
-#	nbdroot=srv,port
-#	nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
-#	root=dhcp nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
-#	root=nbd nbdroot=srv:port[:fstype[:rootflags[:nbdopts]]]
+# root= takes precedence over netroot= if root=nbd[...]
 #
 
-case "$root" in
-    nbd|dhcp|'')
-	if getarg nbdroot= > /dev/null; then
-	    root=nbd:$(getarg nbdroot=)
-	fi
-	;;
-esac
-
-# Convert the Debian style to our syntax, but avoid matches on fs arguments
-case "$root" in
-    nbd:*,*)
-	if check_occurances "$root" ',' 1 && check_occurances "$root" ':' 1;
-	then
-	    root=${root%,*}:${root#*,}
-	fi
-	;;
-esac
-
-if [ -z "$netroot" -a -n "$root" -a -z "${root%%nbd:*}" ]; then
-    netroot="$root"
-    unset root
+# Sadly there's no easy way to split ':' separated lines into variables
+netroot_to_var() {
+    local v=${1}:
+    set --
+    while [ -n "$v" ]; do
+        set -- "$@" "${v%%:*}"
+        v=${v#*:}
+    done
+
+    unset server port 
+    server=$2; port=$3;
+}
+
+# Don't continue if root is ok
+[ -n "$rootok" ] && return
+
+# This script is sourced, so root should be set. But let's be paranoid
+[ -z "$root" ] && root=$(getarg root=)
+[ -z "$netroot" ] && netroot=$(getarg netroot=)
+[ -z "$nbdroot" ] && nbdroot=$(getarg nbdroot=)
+
+# Root takes precedence over netroot
+if [ "${root%%:*}" = "nbd" ] ; then
+    if [ -n "$netroot" ] ; then
+	echo "Warning: root takes precedence over netroot. Ignoring netroot"
+
+    fi
+    netroot=$root
 fi
 
-if [ "${netroot%%:*}" = "nbd" ]; then
-    # XXX validate options here?
-    # XXX generate udev rules?
-    rootok=1
+# If it's not empty or nbd we don't continue
+[ -z "$netroot" ] || [ "${netroot%%:*}" = "nbd" ] || return
+
+if [ -n "$nbdroot" ] ; then
+    [ -z "$netroot" ]  && netroot=$root
+
+    # Debian legacy style contains no ':' Converting is easy
+    [ "$nbdroot" = "${nbdroot##*:}" ] && nbdroot=${nbdroot%,*}:${nbdroot#*,}
+
+    # @deprecated
+    echo "Warning: Argument nbdroot is deprecated and might be removed in a future"
+    echo "release. See http://apps.sourceforge.net/trac/dracut/wiki/commandline for"
+    echo "more information."
+
+    # Accept nbdroot argument?
+    [ -z "$netroot" ] || [ "$netroot" = "nbd" ] || \
+	die "Argument nbdroot only accepted for empty root= or [net]root=nbd"
+
+    # Override netroot with nbdroot content?
+    [ -z "$netroot" ] || [ "$netroot" = "nbd" ] && netroot=nbd:$nbdroot
 fi
+
+# If it's not nbd we don't continue
+[ "${netroot%%:*}" = "nbd" ] || return
+
+# Check required arguments
+netroot_to_var $netroot
+[ -z "$server" ] && die "Argument server for nbdroot is missing"
+[ -z "$port" ] && die "Argument port for nbdroot is missing"
+
+# NBD actually supported?
+incol2 /proc/devices nbd || modprobe nbd || die "nbdroot requested but kernel/initrd does not support nbd"
+
+# Done, all good!
+rootok=1
+
+# Shut up init error check
+[ -z "$root" ] && root="nbd"

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
