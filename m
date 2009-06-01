From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 1/9] nfsroot: move to same sort order as block methods
Date: Sun, 31 May 2009 22:45:12 -0400
Message-ID: <145ca9e5b331c454ebe13005fdfaed3749ef50f5.1243833882.git.dave@thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

There is no reason for this to be a 40nfsroot rather than 95nfs
once other network root handlers are added. Go ahead and move it.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 modules.d/40nfsroot/60-nfsroot.rules   |    1 -
 modules.d/40nfsroot/check              |   11 ---
 modules.d/40nfsroot/install            |   27 -------
 modules.d/40nfsroot/nfsroot            |  125 --------------------------------
 modules.d/40nfsroot/nfsroot-cleanup.sh |   19 -----
 modules.d/95nfs/60-nfsroot.rules       |    1 +
 modules.d/95nfs/check                  |   11 +++
 modules.d/95nfs/install                |   27 +++++++
 modules.d/95nfs/nfsroot                |  125 ++++++++++++++++++++++++++++++++
 modules.d/95nfs/nfsroot-cleanup.sh     |   19 +++++
 10 files changed, 183 insertions(+), 183 deletions(-)
 delete mode 100644 modules.d/40nfsroot/60-nfsroot.rules
 delete mode 100755 modules.d/40nfsroot/check
 delete mode 100755 modules.d/40nfsroot/install
 delete mode 100755 modules.d/40nfsroot/nfsroot
 delete mode 100644 modules.d/40nfsroot/nfsroot-cleanup.sh
 create mode 100644 modules.d/95nfs/60-nfsroot.rules
 create mode 100755 modules.d/95nfs/check
 create mode 100755 modules.d/95nfs/install
 create mode 100755 modules.d/95nfs/nfsroot
 create mode 100644 modules.d/95nfs/nfsroot-cleanup.sh

diff --git a/modules.d/40nfsroot/60-nfsroot.rules b/modules.d/40nfsroot/60-nfsroot.rules
deleted file mode 100644
index 99a2acf..0000000
--- a/modules.d/40nfsroot/60-nfsroot.rules
+++ /dev/null
@@ -1 +0,0 @@
-ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/nfsroot $env{INTERFACE}"
diff --git a/modules.d/40nfsroot/check b/modules.d/40nfsroot/check
deleted file mode 100755
index 0625322..0000000
--- a/modules.d/40nfsroot/check
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-# We depend on network modules being loaded
-[ "$1" = "-d" ] && echo network
-
-# If hostonly was requested, fail the check if we are not actually
-# booting from root.
-[ "$1" = "-h" ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && exit 1
-
-# If our prerequisites are not met, fail anyways.
-which rpcbind rpc.statd mount.nfs mount.nfs4 umount >/dev/null 2>&1 || exit 1
-exit 0
diff --git a/modules.d/40nfsroot/install b/modules.d/40nfsroot/install
deleted file mode 100755
index 80b59a1..0000000
--- a/modules.d/40nfsroot/install
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-dracut_install rpcbind rpc.statd mount.nfs mount.nfs4 umount 
-dracut_install /etc/netconfig /etc/passwd /etc/services
-
-# XXX debug stuff
-dracut_install rpcinfo ping strace dmesg nc free df
-
-dracut_install rpc.idmapd /etc/idmapd.conf
-
-instmods nfs
-inst_rules "$moddir/60-nfsroot.rules"
-inst_hook pre-pivot 70 "$moddir/nfsroot-cleanup.sh"
-inst "$moddir/nfsroot" "/sbin/nfsroot"
-mkdir -p "$initdir/var/lib/nfs/rpc_pipefs"
-mkdir -p "$initdir/var/lib/rpcbind"
-mkdir -p "$initdir/var/lib/nfs/statd/sm"
-
-# XXX debug
-mkdir -p "$initdir/mnt"
-
-# Rather than copy the passwd file in, just set a user for rpcbind
-# We'll save the state and restart the daemon from the root anyway
-#echo "rpc:x:32:32:Rpcbind:/var/lib/rpcbind:/bin/false" >> "$initdir/etc/passwd"
-
-# rpc user needs to be able to write to this directory to save the warmstart
-# file
-chmod 777 "$initdir/var/lib/rpcbind"
diff --git a/modules.d/40nfsroot/nfsroot b/modules.d/40nfsroot/nfsroot
deleted file mode 100755
index b8858bc..0000000
--- a/modules.d/40nfsroot/nfsroot
+++ /dev/null
@@ -1,125 +0,0 @@
-#!/bin/sh
-
-. /lib/dracut-lib
-
-PATH=$PATH:/sbin:/usr/sbin
-
-# XXX needs error handling like ifup/dhclient-script
-
-# XXX need to lock our attempts if we're doing the mount here
-
-getarg rdnetdebug && {
-    exec > /tmp/nfsroot.$1.$$.out
-    exec 2>> /tmp/nfsroot.$1.$$.out
-    set -x
-}
-
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
-
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
-
-# look through the flags and see if any are overridden by the command line
-while [ -n "$flags" ]; do
-    f=${flags%%,*}; flags=${flags#*,}
-    [ "$f" = "nfs" -o "$f" = "nfs4" ] && {
-	[ "$type" = "auto" ] && type=$f
-	continue
-    }
-    [ "$f" = "ro" -o "$f" = "rw" ] && {
-	nfsrw=$f
-	continue
-    }
-    [ "$f" = "lock" -o "$f" = "nolock" ] && {
-	nfslock=$f
-	continue
-    }
-    nfsflags=${nfsflags+$nfsflags,}$f
-done
-
-getarg ro && nfsrw=ro
-getarg rw && nfsrw=rw
-nfsflags=${nfsflags+$nfsflags,}${nfsrw}
-
-# load our modules explicitly, so we can fail fast in the future
-modprobe nfs || nfs_done
-
-# XXX don't forget to move /var/lib/nfs/rpc_pipefs to new /
-# XXX need host name set before now?
-
-# Start rpcbind and rpc.statd as mount won't let us use locks on a NFSv4
-# filesystem without talking to them, even though they are unneeded
-# XXX occasionally saw 'rpcbind: fork failed: No such device' -- why?
-[ -n "$(pidof rpcbind)" ] || rpcbind
-[ -n "$(pidof rpc.statd)" ] || rpc.statd
-
-# XXX should I do rpc.idmapd here, or wait and start in the new root
-# XXX waiting assumes root can read everything it needs right up until
-# XXX we start it...
-
-# XXX really, want to retry in a loop I think, but not here...
-
-[ "$type" = "nfs4" -o "$type" = "auto" ] && {
-    # XXX really needed? Do we need non-root users before we start it in
-    # XXX the real root image?
-    [ -n "$(pidof rpc.idmapd)" ] || rpc.idmapd
-
-    # NFSv4 does locks internally
-    mount -t nfs4 -o${nfsflags}${nfslock+,$nfslock} \
-			$nfsserver:$nfspath /sysroot && nfs_done
-
-    # If we're specified to be NFSv4, then stop when we fail
-    # Don't mark us done, as this may be transient
-    [ "$type" = "nfs4" ] && exit 0
-}
-
-# we're NFSv{2,3} or auto and NFSv4 failed. We don't support using locks
-# on NFSv{2,3} because that requires a helper to transfer the rpcbind state
-# rpcbind to the new root
-[ -z "$nfslock" -o "$nfslock" = "lock" ] &&
-    echo "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
-mount -t nfs -onolock,$nfsflags $nfsserver:$nfspath /sysroot && nfs_done
-exit 0
diff --git a/modules.d/40nfsroot/nfsroot-cleanup.sh b/modules.d/40nfsroot/nfsroot-cleanup.sh
deleted file mode 100644
index b8f3a2f..0000000
--- a/modules.d/40nfsroot/nfsroot-cleanup.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/sh
-
-pid=$(pidof rpc.statd)
-[ -n "$pid" ] && kill $pid
-
-pid=$(pidof rpcbind)
-[ -n "$pid" ] && kill $pid
-
-if grep -q rpc_pipefs /proc/mounts; then 
-    # try to create the destination directory
-    [ -d $NEWROOT/var/lib/nfs/rpc_pipefs ] || mkdir -p $NEWROOT/var/lib/nfs/rpc_pipefs 2>/dev/null
-
-    if [ -d $NEWROOT/var/lib/nfs/rpc_pipefs ]; then
-	mount --move /var/lib/nfs/rpc_pipefs $NEWROOT/var/lib/nfs/rpc_pipefs
-    else
-	umount /var/lib/nfs/rpc_pipefs
-    fi
-fi
-
diff --git a/modules.d/95nfs/60-nfsroot.rules b/modules.d/95nfs/60-nfsroot.rules
new file mode 100644
index 0000000..99a2acf
--- /dev/null
+++ b/modules.d/95nfs/60-nfsroot.rules
@@ -0,0 +1 @@
+ACTION=="online", SUBSYSTEM=="net", RUN+="/sbin/nfsroot $env{INTERFACE}"
diff --git a/modules.d/95nfs/check b/modules.d/95nfs/check
new file mode 100755
index 0000000..0625322
--- /dev/null
+++ b/modules.d/95nfs/check
@@ -0,0 +1,11 @@
+#!/bin/sh
+# We depend on network modules being loaded
+[ "$1" = "-d" ] && echo network
+
+# If hostonly was requested, fail the check if we are not actually
+# booting from root.
+[ "$1" = "-h" ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && exit 1
+
+# If our prerequisites are not met, fail anyways.
+which rpcbind rpc.statd mount.nfs mount.nfs4 umount >/dev/null 2>&1 || exit 1
+exit 0
diff --git a/modules.d/95nfs/install b/modules.d/95nfs/install
new file mode 100755
index 0000000..80b59a1
--- /dev/null
+++ b/modules.d/95nfs/install
@@ -0,0 +1,27 @@
+#!/bin/sh
+dracut_install rpcbind rpc.statd mount.nfs mount.nfs4 umount 
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
diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
new file mode 100755
index 0000000..b8858bc
--- /dev/null
+++ b/modules.d/95nfs/nfsroot
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
+getarg rdnetdebug && {
+    exec > /tmp/nfsroot.$1.$$.out
+    exec 2>> /tmp/nfsroot.$1.$$.out
+    set -x
+}
+
+[ "$NFS_LOCKED" ] || {
+	NFS_LOCKED=true
+	export NFS_LOCKED
+	exec flock -xo /tmp/nfs.lock -c "$0 $*"
+	exit 1
+}
+
+[ -e /tmp/nfsdone ] && exit 0
+
+nfs_done() {
+    >/tmp/nfsdone
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
+[ -e /tmp/net.$1.dhcpopts ] && . /tmp/net.$1.dhcpopts
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
diff --git a/modules.d/95nfs/nfsroot-cleanup.sh b/modules.d/95nfs/nfsroot-cleanup.sh
new file mode 100644
index 0000000..b8f3a2f
--- /dev/null
+++ b/modules.d/95nfs/nfsroot-cleanup.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+pid=$(pidof rpc.statd)
+[ -n "$pid" ] && kill $pid
+
+pid=$(pidof rpcbind)
+[ -n "$pid" ] && kill $pid
+
+if grep -q rpc_pipefs /proc/mounts; then 
+    # try to create the destination directory
+    [ -d $NEWROOT/var/lib/nfs/rpc_pipefs ] || mkdir -p $NEWROOT/var/lib/nfs/rpc_pipefs 2>/dev/null
+
+    if [ -d $NEWROOT/var/lib/nfs/rpc_pipefs ]; then
+	mount --move /var/lib/nfs/rpc_pipefs $NEWROOT/var/lib/nfs/rpc_pipefs
+    else
+	umount /var/lib/nfs/rpc_pipefs
+    fi
+fi
+
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
