From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 8/9] nfsroot: move to netroot framework
Date: Mon, 1 Jun 2009 00:53:52 -0400
Message-ID: <5103130352ae19f69c6357ebcf4b600e835bf7d7.1243833882.git.dave@thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Parse and convert commandline options in the cmdline hook, and
fill in the missing pieces in the netroot hook. This also allows
root=dhcp to work as expected.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 modules.d/95nfs/60-nfsroot.rules |    1 -
 modules.d/95nfs/install          |   10 +---
 modules.d/95nfs/nfs-netroot.sh   |   52 +++++++++++++++++++
 modules.d/95nfs/nfsroot          |  105 +++++++++++--------------------------
 modules.d/95nfs/parse-nfsroot.sh |   48 +++++++++++++++++
 modules.d/99base/dracut-lib      |   16 ++++++
 6 files changed, 149 insertions(+), 83 deletions(-)
 delete mode 100644 modules.d/95nfs/60-nfsroot.rules
 create mode 100755 modules.d/95nfs/nfs-netroot.sh
 create mode 100755 modules.d/95nfs/parse-nfsroot.sh

diff --git a/modules.d/95nfs/60-nfsroot.rules b/modules.d/95nfs/60-nfsroot.rules
deleted file mode 100644
index 99a2acf..0000000
--- a/modules.d/95nfs/60-nfsroot.rules
+++ /dev/null
@@ -1 +0,0 @@
-ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/nfsroot $env{INTERFACE}"
diff --git a/modules.d/95nfs/install b/modules.d/95nfs/install
index 80b59a1..8d7366f 100755
--- a/modules.d/95nfs/install
+++ b/modules.d/95nfs/install
@@ -1,23 +1,17 @@
 #!/bin/sh
 dracut_install rpcbind rpc.statd mount.nfs mount.nfs4 umount 
 dracut_install /etc/netconfig /etc/passwd /etc/services
-
-# XXX debug stuff
-dracut_install rpcinfo ping strace dmesg nc free df
-
 dracut_install rpc.idmapd /etc/idmapd.conf
 
 instmods nfs
-inst_rules "$moddir/60-nfsroot.rules"
+inst_hook cmdline 90 "$moddir/parse-nfsroot.sh"
+inst_hook netroot 90 "$moddir/nfs-netroot.sh"
 inst_hook pre-pivot 70 "$moddir/nfsroot-cleanup.sh"
 inst "$moddir/nfsroot" "/sbin/nfsroot"
 mkdir -p "$initdir/var/lib/nfs/rpc_pipefs"
 mkdir -p "$initdir/var/lib/rpcbind"
 mkdir -p "$initdir/var/lib/nfs/statd/sm"
 
-# XXX debug
-mkdir -p "$initdir/mnt"
-
 # Rather than copy the passwd file in, just set a user for rpcbind
 # We'll save the state and restart the daemon from the root anyway
 #echo "rpc:x:32:32:Rpcbind:/var/lib/rpcbind:/bin/false" >> "$initdir/etc/passwd"
diff --git a/modules.d/95nfs/nfs-netroot.sh b/modules.d/95nfs/nfs-netroot.sh
new file mode 100755
index 0000000..ac72163
--- /dev/null
+++ b/modules.d/95nfs/nfs-netroot.sh
@@ -0,0 +1,52 @@
+#!/bin/sh # for highlighting
+
+# If we're auto-detecting our root type from DHCP, see if this looks like
+# an NFS root option. As the variety of root-path formats is large, validate
+# that the number of colons match what we expect, and our glob didn't
+# inadvertently match a different handler's.
+#
+if [ "$root" = "dhcp" -o "$root" = "nfs" -o "$root" = "nfs4" ]; then
+    nfsver=nfs
+    if [ "$root" = "nfs4" ]; then
+	nfsver=nfs4
+    fi
+    case "$new_root_path" in
+    nfs:*|nfs4:*) root="$new_root_path" ;;
+    *:/*:*)
+	if check_occurances "$new_root_path" ':' 2; then
+	    root="$nfsver:$new_root_path"
+	fi ;;
+    *:/*)
+	if check_occurances "$new_root_path" ':' 1; then
+	    root="$nfsver:$new_root_path:"
+	fi ;;
+    /*:*)
+	if check_occurances "$new_root_path" ':' 1; then
+	    root="$nfsver::$new_root_path"
+	fi ;;
+    /*)
+	if check_occurances "$new_root_path" ':' 0; then
+	    root="$nfsver::$new_root_path:"
+	fi ;;
+    esac
+fi
+
+if [ -z "${root%%nfs:*}" -o -z "${root%%nfs4:*}" ]; then
+    # Fill in missing information from DHCP
+    nfsver=${root%%:*}; root=${root#*:}
+    nfsserver=${root%%:*}; root=${root#*:}
+    nfspath=${root%%:*}
+    nfsflags=${root#*:}
+
+    # XXX where does dhclient stash the next-server option? Do we care?
+    if [ -z "$nfsserver" -o "$nfsserver" = "$nfspath" ]; then
+	nfsserver=$new_dhcp_server_identifier
+    fi
+    if [ "$nfspath" = "$nfsflags" ]; then
+	unset nfsflags
+    fi
+
+    # XXX validate we have all the required info?
+    root="$nfsver:$nfsserver:$nfspath:$nfsflags"
+    handler=/sbin/nfsroot
+fi
diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index b8858bc..18e1300 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -6,77 +6,38 @@ PATH=$PATH:/sbin:/usr/sbin
 
 # XXX needs error handling like ifup/dhclient-script
 
-# XXX need to lock our attempts if we're doing the mount here
-
 getarg rdnetdebug && {
     exec > /tmp/nfsroot.$1.$$.out
     exec 2>> /tmp/nfsroot.$1.$$.out
     set -x
 }
 
-[ "$NFS_LOCKED" ] || {
-	NFS_LOCKED=true
-	export NFS_LOCKED
-	exec flock -xo /tmp/nfs.lock -c "$0 $*"
-	exit 1
-}
-
-[ -e /tmp/nfsdone ] && exit 0
-
-nfs_done() {
-    >/tmp/nfsdone
-    exit 0
-}
-
-root=$(getarg root)
-case $root in
-    nfs|/dev/nfs)	type=nfs  ;;
-    nfs4|/dev/nfs4)	type=nfs4 ;;
-    auto|'')		type=auto  ;;
-esac
-
-rootfstype=$(getarg rootfstype)
-case $rootfstype in
-    nfs|nfs4|auto)	type=$rootfstype  ;;
-esac
-
-# If we're not doing NFS at all, don't keep banging our head
-[ -n "$type" ] || nfs_done
-
-[ -e /tmp/net.$1.dhcpopts ] && . /tmp/net.$1.dhcpopts
+# root is in the form root=nfs[4]:server:path:[options]
+netif="$1"
+root="$2"
 
-nfsroot=$(getarg nfsroot)
-[ -n "$nfsroot" ] || nfsroot="$new_root_path"
-[ -n "$nfsroot" ] || nfs_done
-
-# check for IP address at front, if there is none, use
-# new_dhcp_server_identifier
-#
-# XXX kernel nfsroot uses , to separate NFS options at end
-#
-nfsserver=${nfsroot%%:*}; nfsroot=${nfsroot#*:}
-nfspath=${nfsroot%%:*}
-flags=${nfsroot#*:}
-[ "$nfsserver" = "$nfspath" ] && nfsserver=$new_dhcp_server_identifier
-[ "$nfspath" = "$flags" ] && unset flags
-
-[ -n "$nfsserver" ] || no_nfs
+nfsver=${root%%:*}; root=${root#*:}
+nfsserver=${root%%:*}; root=${root#*:}
+nfspath=${root%%:*}
+flags=${root#*:}
 
 # look through the flags and see if any are overridden by the command line
+# Append a , so we know we terminate
+flags=${flags},
 while [ -n "$flags" ]; do
-    f=${flags%%,*}; flags=${flags#*,}
-    [ "$f" = "nfs" -o "$f" = "nfs4" ] && {
-	[ "$type" = "auto" ] && type=$f
-	continue
-    }
-    [ "$f" = "ro" -o "$f" = "rw" ] && {
+    f=${flags%%,*}
+    flags=${flags#*,}
+    if [ -z "$f" ]; then
+	break
+    fi
+    if [ "$f" = "ro" -o "$f" = "rw" ]; then
 	nfsrw=$f
 	continue
-    }
-    [ "$f" = "lock" -o "$f" = "nolock" ] && {
+    fi
+    if [ "$f" = "lock" -o "$f" = "nolock" ]; then
 	nfslock=$f
 	continue
-    }
+    fi
     nfsflags=${nfsflags+$nfsflags,}$f
 done
 
@@ -84,11 +45,10 @@ getarg ro && nfsrw=ro
 getarg rw && nfsrw=rw
 nfsflags=${nfsflags+$nfsflags,}${nfsrw}
 
-# load our modules explicitly, so we can fail fast in the future
-modprobe nfs || nfs_done
+# Load the modules so the filesystem type is there
+modprobe nfs || exit 1
 
 # XXX don't forget to move /var/lib/nfs/rpc_pipefs to new /
-# XXX need host name set before now?
 
 # Start rpcbind and rpc.statd as mount won't let us use locks on a NFSv4
 # filesystem without talking to them, even though they are unneeded
@@ -102,24 +62,21 @@ modprobe nfs || nfs_done
 
 # XXX really, want to retry in a loop I think, but not here...
 
-[ "$type" = "nfs4" -o "$type" = "auto" ] && {
+if [ "$nfsver" = "nfs4" ]; then
     # XXX really needed? Do we need non-root users before we start it in
     # XXX the real root image?
-    [ -n "$(pidof rpc.idmapd)" ] || rpc.idmapd
+    if [ -z "$(pidof rpc.idmapd)" ]; then
+	rpc.idmapd
+    fi
 
     # NFSv4 does locks internally
-    mount -t nfs4 -o${nfsflags}${nfslock+,$nfslock} \
-			$nfsserver:$nfspath /sysroot && nfs_done
-
-    # If we're specified to be NFSv4, then stop when we fail
-    # Don't mark us done, as this may be transient
-    [ "$type" = "nfs4" ] && exit 0
-}
+    exec mount -t nfs4 -o${nfsflags}${nfslock+,$nfslock} \
+			$nfsserver:$nfspath $NEWROOT
+fi
 
-# we're NFSv{2,3} or auto and NFSv4 failed. We don't support using locks
-# on NFSv{2,3} because that requires a helper to transfer the rpcbind state
-# rpcbind to the new root
+# NFSv{2,3} doesn't support using locks as it requires a helper to transfer
+# the rpcbind state to the new root
+#
 [ -z "$nfslock" -o "$nfslock" = "lock" ] &&
     echo "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
-mount -t nfs -onolock,$nfsflags $nfsserver:$nfspath /sysroot && nfs_done
-exit 0
+exec mount -t nfs -onolock,$nfsflags $nfsserver:$nfspath $NEWROOT
diff --git a/modules.d/95nfs/parse-nfsroot.sh b/modules.d/95nfs/parse-nfsroot.sh
new file mode 100755
index 0000000..5201e4b
--- /dev/null
+++ b/modules.d/95nfs/parse-nfsroot.sh
@@ -0,0 +1,48 @@
+#!/bin/bash
+
+# We're 90-nfs.sh to catch root=/dev/nfs
+#
+# Preferred format:
+#	root=nfs[4]:[server:]path[:options]
+#
+# If server is unspecified it will be pulled from one of the following
+# sources, in order:
+#	static ip= option on kernel command line
+#	DHCP next-server option
+#	DHCP server-id option
+#
+# Legacy formats:
+#	root=nfs[4]
+#	root=/dev/nfs[4] nfsroot=[server:]path[,options]
+#
+# Plain "root=nfs" interprets DHCP root-path option as [ip:]path[:options]
+#
+# NFSv4 is only used if explicitly listed; default is NFSv3
+#
+
+case "$root" in
+    nfs|dhcp|'')
+	if getarg nfsroot= > /dev/null; then
+	    root=nfs:$(getarg nfsroot=)
+	fi
+	;;
+    nfs4)
+	if getarg nfsroot= > /dev/null; then
+	    root=nfs4:$(getarg nfsroot=)
+	fi
+	;;
+    /dev/nfs|/dev/nfs4)
+	if getarg nfsroot= > /dev/null; then
+	    root=${root#/dev/}:$(getarg nfsroot=)
+	else
+	    root=${root#/dev/}
+	fi
+	;;
+esac
+
+case "$root" in
+    nfs|nfs4|nfs:*|nfs4:*)
+    	rootok=1
+    	netroot=nfs
+    ;;
+esac
diff --git a/modules.d/99base/dracut-lib b/modules.d/99base/dracut-lib
index 7078827..e3f4794 100644
--- a/modules.d/99base/dracut-lib
+++ b/modules.d/99base/dracut-lib
@@ -20,3 +20,19 @@ source_all() {
     [ "$1" ] && [  -d "/$1" ] || return
     for f in "/$1"/*.sh; do [ -f "$f" ] && . "$f"; done
 }
+
+check_occurances() {
+    # Count the number of times the character $ch occurs in $str
+    # Return 0 if the count matches the expected number, 1 otherwise
+    local str="$1"
+    local ch="$2"
+    local expected="$3"
+    local count=0
+
+    while [ "${str#*$ch}" != "${str}" ]; do
+	str="${str#*$ch}"
+	count=$(( $count + 1 ))
+    done
+
+    [ $count -eq $expected ]
+}
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
