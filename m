From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 5/5] nfsroot: mount NFS root from udev rules
Date: Fri, 22 May 2009 22:53:10 -0400
Message-ID: <913fe81cc929e3126bccf147d6bc66ddf6e2b149.1243053563.git.dave@thedillows.org>
References: <cover.1243053563.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243053563.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 

Work-in-progress to mount NFS root from udev, using the DHCP options and
allowing an override from the kernel command line. Supports NFSv4 w/locking
and NFSv2/v3 with nolock.

This is just an RFC patch, you'll note all the XXX markings where I've been
thinking about how to best do things. In addition, we really want to retry
DHCP and NFS mounting in a loop, in case the servers are down or overloaded
like when booting a full diskless cluster.
---
 dracut                                 |    5 +-
 modules.d/40nfsroot/60-nfsroot.rules   |    1 +
 modules.d/40nfsroot/check              |    5 +
 modules.d/40nfsroot/install            |   27 +++++
 modules.d/40nfsroot/nfsroot            |  125 ++++++++++++++++++++++++
 modules.d/40nfsroot/nfsroot-cleanup.sh |    9 ++
 6 files changed, 171 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 0cf00c6..4c06588 100755
--- a/dracut
+++ b/dracut
@@ -99,10 +99,13 @@ hookdirs="pre-udev pre-mount pre-pivot mount emergency"
 readonly initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 
+# Need to be able to have non-root users read stuff (rpcbind etc)
+chmod 755 "$initdir"
+
 export initdir hookdirs dsrc dracutmodules modules debug beverbose
 
 # Create some directory structure first
-for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do 
+for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts var/run; do 
     mkdir -p "$initdir/$d"; 
 done
 
diff --git a/modules.d/40nfsroot/60-nfsroot.rules b/modules.d/40nfsroot/60-nfsroot.rules
new file mode 100644
index 0000000..99a2acf
--- /dev/null
+++ b/modules.d/40nfsroot/60-nfsroot.rules
@@ -0,0 +1 @@
+ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/nfsroot $env{INTERFACE}"
diff --git a/modules.d/40nfsroot/check b/modules.d/40nfsroot/check
new file mode 100755
index 0000000..b7378c3
--- /dev/null
+++ b/modules.d/40nfsroot/check
@@ -0,0 +1,5 @@
+#!/bin/sh
+#
+# This is not a module that should be selected when we try to
+# autoconfigure the initrd 
+exit 1
diff --git a/modules.d/40nfsroot/install b/modules.d/40nfsroot/install
new file mode 100755
index 0000000..965c63c
--- /dev/null
+++ b/modules.d/40nfsroot/install
@@ -0,0 +1,27 @@
+#!/bin/sh
+dracut_install rpcbind rpc.statd mount.nfs mount.nfs4
+dracut_install /etc/netconfig /etc/passwd /etc/services
+
+# XXX debug stuff
+dracut_install rpcinfo ping strace dmesg nc free df
+
+dracut_install rpc.idmapd /etc/idmapd.conf
+
+instmods nfs
+inst_rules "$moddir/60-nfsroot.rules"
+inst_hook pre-pivot 70 "$moddir/nfsroot-cleanup.sh"
+inst "$moddir/nfsroot" "/sbin/nfsroot"
+mkdir -p "$initdir/var/lib/nfs/rpc_pipefs"
+mkdir -p "$initdir/var/lib/rpcbind"
+mkdir -p "$initdir/var/lib/nfs/statd/sm"
+
+# XXX debug
+mkdir -p "$initdir/mnt"
+
+# Rather than copy the passwd file in, just set a user for rpcbind
+# We'll save the state and restart the daemon from the root anyway
+#echo "rpc:x:32:32:Rpcbind:/var/lib/rpcbind:/bin/false" >> "$initdir/etc/passwd"
+
+# rpc user needs to be able to write to this directory to save the warmstart
+# file
+chmod 777 "$initdir/var/lib/rpcbind"
diff --git a/modules.d/40nfsroot/nfsroot b/modules.d/40nfsroot/nfsroot
new file mode 100755
index 0000000..f5b6ec1
--- /dev/null
+++ b/modules.d/40nfsroot/nfsroot
@@ -0,0 +1,125 @@
+#!/bin/sh
+
+. /lib/dracut-lib
+
+PATH=$PATH:/sbin:/usr/sbin
+
+# XXX needs error handling like ifup/dhclient-script
+
+# XXX need to lock our attempts if we're doing the mount here
+
+getarg netdebug && {
+    exec > /nfsroot.$1.$$.out
+    exec 2>> /nfsroot.$1.$$.out
+    set -x
+}
+
+[ "$NFS_LOCKED" ] || {
+	NFS_LOCKED=true
+	export NFS_LOCKED
+	exec flock -xo /nfs.lock -c "$0 $*"
+	exit 1
+}
+
+[ -e /nfsdone ] && exit 0
+
+nfs_done() {
+    >/nfsdone
+    exit 0
+}
+
+root=$(getarg root)
+case $root in
+    nfs|/dev/nfs)	type=nfs  ;;
+    nfs4|/dev/nfs4)	type=nfs4 ;;
+    auto|'')		type=auto  ;;
+esac
+
+rootfstype=$(getarg rootfstype)
+case $rootfstype in
+    nfs|nfs4|auto)	type=$rootfstype  ;;
+esac
+
+# If we're not doing NFS at all, don't keep banging our head
+[ -n "$type" ] || nfs_done
+
+[ -e /net.$1.dhcpopts ] && . /net.$1.dhcpopts
+
+nfsroot=$(getarg nfsroot)
+[ -n "$nfsroot" ] || nfsroot="$new_root_path"
+[ -n "$nfsroot" ] || nfs_done
+
+# check for IP address at front, if there is none, use
+# new_dhcp_server_identifier
+#
+# XXX kernel nfsroot uses , to separate NFS options at end
+#
+nfsserver=${nfsroot%%:*}; nfsroot=${nfsroot#*:}
+nfspath=${nfsroot%%:*}
+flags=${nfsroot#*:}
+[ "$nfsserver" = "$nfspath" ] && nfsserver=$new_dhcp_server_identifier
+[ "$nfspath" = "$flags" ] && unset flags
+
+[ -n "$nfsserver" ] || no_nfs
+
+# look through the flags and see if any are overridden by the command line
+while [ -n "$flags" ]; do
+    f=${flags%%,*}; flags=${flags#*,}
+    [ "$f" = "nfs" -o "$f" = "nfs4" ] && {
+	[ "$type" = "auto" ] && type=$f
+	continue
+    }
+    [ "$f" = "ro" -o "$f" = "rw" ] && {
+	nfsrw=$f
+	continue
+    }
+    [ "$f" = "lock" -o "$f" = "nolock" ] && {
+	nfslock=$f
+	continue
+    }
+    nfsflags=${nfsflags+$nfsflags,}$f
+done
+
+getarg ro && nfsrw=ro
+getarg rw && nfsrw=rw
+nfsflags=${nfsflags+$nfsflags,}${nfsrw}
+
+# load our modules explicitly, so we can fail fast in the future
+modprobe nfs || nfs_done
+
+# XXX don't forget to move /var/lib/nfs/rpc_pipefs to new /
+# XXX need host name set before now?
+
+# Start rpcbind and rpc.statd as mount won't let us use locks on a NFSv4
+# filesystem without talking to them, even though they are unneeded
+# XXX occasionally saw 'rpcbind: fork failed: No such device' -- why?
+[ -n "$(pidof rpcbind)" ] || rpcbind
+[ -n "$(pidof rpc.statd)" ] || rpc.statd
+
+# XXX should I do rpc.idmapd here, or wait and start in the new root
+# XXX waiting assumes root can read everything it needs right up until
+# XXX we start it...
+
+# XXX really, want to retry in a loop I think, but not here...
+
+[ "$type" = "nfs4" -o "$type" = "auto" ] && {
+    # XXX really needed? Do we need non-root users before we start it in
+    # XXX the real root image?
+    [ -n "$(pidof rpc.idmapd)" ] || rpc.idmapd
+
+    # NFSv4 does locks internally
+    mount -t nfs4 -o${nfsflags}${nfslock+,$nfslock} \
+			$nfsserver:$nfspath /sysroot && nfs_done
+
+    # If we're specified to be NFSv4, then stop when we fail
+    # Don't mark us done, as this may be transient
+    [ "$type" = "nfs4" ] && exit 0
+}
+
+# we're NFSv{2,3} or auto and NFSv4 failed. We don't support using locks
+# on NFSv{2,3} because that requires a helper to transfer the rpcbind state
+# rpcbind to the new root
+[ -z "$nfslock" -o "$nfslock" = "lock" ] &&
+    echo "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
+mount -t nfs -onolock,$nfsflags $nfsserver:$nfspath /sysroot && nfs_done
+exit 0
diff --git a/modules.d/40nfsroot/nfsroot-cleanup.sh b/modules.d/40nfsroot/nfsroot-cleanup.sh
new file mode 100755
index 0000000..7bdec0a
--- /dev/null
+++ b/modules.d/40nfsroot/nfsroot-cleanup.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+pid=$(pidof rpc.statd)
+[ -n "$pid" ] && kill $pid
+
+pid=$(pidof rpcbind)
+[ -n "$pid" ] && kill $pid
+
+mount --move /var/lib/nfs/rpc_pipefs $NEWROOT/var/lib/nfs/rpc_pipefs
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
