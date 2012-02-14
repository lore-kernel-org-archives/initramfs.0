From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/9] 95nfs: add nfs-lib.sh
Date: Tue, 14 Feb 2012 12:38:03 -0500
Message-ID: <1329241090-26908-3-git-send-email-wwoods@redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

nfs-lib.sh contains a bunch of functions used to parse NFS "url"s of
various types, pull nfs information out of dhcp info, and actually
perform nfs mounts sanely.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95nfs/module-setup.sh |    1 +
 modules.d/95nfs/nfs-lib.sh      |  139 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/95nfs/nfs-lib.sh

diff --git a/modules.d/95nfs/module-setup.sh b/modules.d/95nfs/module-setup.sh
index 0e921ff..19d618c 100755
--- a/modules.d/95nfs/module-setup.sh
+++ b/modules.d/95nfs/module-setup.sh
@@ -60,6 +60,7 @@ install() {
     inst_hook pre-udev 99 "$moddir/nfs-start-rpc.sh"
     inst_hook pre-pivot 99 "$moddir/nfsroot-cleanup.sh"
     inst "$moddir/nfsroot" "/sbin/nfsroot"
+    inst "$moddir/nfs-lib.sh" "/lib/nfs-lib.sh"
     mkdir -m 0755 -p "$initdir/var/lib/nfs/rpc_pipefs"
     mkdir -m 0755 -p "$initdir/var/lib/rpcbind"
     mkdir -m 0755 -p "$initdir/var/lib/nfs/statd/sm"
diff --git a/modules.d/95nfs/nfs-lib.sh b/modules.d/95nfs/nfs-lib.sh
new file mode 100755
index 0000000..4f3d184
--- /dev/null
+++ b/modules.d/95nfs/nfs-lib.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+. /lib/net-lib.sh
+
+# TODO: make these things not pollute the calling namespace
+
+# nfs_to_var NFSROOT [NETIF]
+# use NFSROOT to set $nfs, $server, $path, and $options.
+# NFSROOT is something like: nfs[4]:<server>:/<path>[:<options>|,<options>]
+# NETIF is used to get information from DHCP options, if needed.
+nfs_to_var() {
+    # Unfortunately, there's multiple styles of nfs "URL" in use, so we need
+    # extra functions to parse them into $nfs, $server, $path, and $options.
+    # FIXME: local netif=${2:-$netif}?
+    case "$1" in
+        nfs://*) rfc2224_nfs_to_var "$1" ;;
+        nfs:*:*:/*) anaconda_nfs_to_var "$1" ;;
+        *) nfsroot_to_var "$1" ;;
+    esac
+    # if anything's missing, try to fill it in from DHCP options
+    if [ -z "$server" ] || [ -z "$path" ]; then nfsroot_from_dhcp $2; fi
+    # if there's a "%s" in the path, replace it with the hostname/IP
+    if strstr "$path" "%s"; then
+        local node=""
+        read node < /proc/sys/kernel/hostname
+        [ "$node" = "(none)" ] && node=$(get_ip $2)
+        path=${path%%%s*}$node${path#*%s} # replace only the first %s
+    fi
+}
+
+# root=nfs:[<server-ip>:]<root-dir>[:<nfs-options>]
+# root=nfs4:[<server-ip>:]<root-dir>[:<nfs-options>]
+nfsroot_to_var() {
+    # strip nfs[4]:
+    local arg="$@:"
+    nfs="${arg%%:*}"
+    arg="${arg##$nfs:}"
+
+    # check if we have a server
+    if strstr "$arg" ':/*' ; then
+        server="${arg%%:/*}"
+        arg="/${arg##*:/}"
+    fi
+
+    path="${arg%%:*}"
+
+    # rest are options
+    options="${arg##$path}"
+    # strip leading ":"
+    options="${options##:}"
+    # strip  ":"
+    options="${options%%:}"
+
+    # Does it really start with '/'?
+    [ -n "${path%%/*}" ] && path="error";
+
+    #Fix kernel legacy style separating path and options with ','
+    if [ "$path" != "${path#*,}" ] ; then
+        options=${path#*,}
+        path=${path%%,*}
+    fi
+}
+
+# RFC2224: nfs://<server>[:<port>]/<path>
+rfc2224_nfs_to_var() {
+    nfs="nfs"
+    server="${1#nfs://}"
+    path="/${server#*/}"
+    server="${server%%/*}"
+    server="${server%%:}" # anaconda compat (nfs://<server>:/<path>)
+    local port="${server##*:}"
+    [ "$port" != "$server" ] && options="port=$port"
+}
+
+# Anaconda-style path with options: nfs:<options>:<server>:/<path>
+# (without mount options, anaconda is the same as dracut)
+anaconda_nfs_to_var() {
+    nfs="nfs"
+    options="${1#nfs:}"
+    server="${options#*:}"
+    server="${server%:/*}"
+    options="${options%%:*}"
+    path="/${1##*:/}"
+}
+
+# nfsroot_from_dhcp NETIF
+# fill in missing server/path from DHCP options.
+nfsroot_from_dhcp() {
+    local f
+    for f in /tmp/net.$1.override /tmp/dhclient.$1.dhcpopts; do
+        [ -f $f ] && . $f || return
+    done
+    [ -n "$new_root_path" ] && nfsroot_to_var "$nfs:$new_root_path"
+    [ -z "$path" ] && [ "$(getarg root=)" == "/dev/nfs" ] && path=/tftpboot/%s
+    [ -z "$server" ] && server=$new_dhcp_server_identifier
+    [ -z "$server" ] && server=$new_dhcp_next_server
+    [ -z "$server" ] && server=${new_root_path%%:*}
+}
+
+# Look through $options, fix "rw"/"ro", move "lock"/"nolock" to $nfslock
+munge_nfs_options() {
+    local f="" flags="" nfsrw="ro" OLDIFS="$IFS"
+    IFS=,
+    for f in $options; do
+        case $f in
+            ro|rw) nfsrw=$f ;;
+            lock|nolock) nfslock=$f ;;
+            *) flags=${flags:+$flags,}$f ;;
+        esac
+    done
+    IFS="$OLDIFS"
+
+    # Override rw/ro if set on cmdline
+    getarg ro >/dev/null && nfsrw=ro
+    getarg rw >/dev/null && nfsrw=rw
+
+    options=$nfsrw${flags:+,$flags}
+}
+
+# mount_nfs NFSROOT MNTDIR [NETIF]
+mount_nfs() {
+    local nfsroot="$1" mntdir="$2" netif="$3"
+    local nfs="" server="" path="" options=""
+    nfs_to_var $nfsroot $netif
+    munge_nfs_options
+    if [ "$nfs" = "nfs4" ]; then
+        options=$options${nfslock+,$nfslock}
+    else
+        # NFSv{2,3} doesn't support using locks as it requires a helper to
+        # transfer the rpcbind state to the new root
+        [ "$nfslock" = "lock" ] \
+            && warn "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
+        options=$options,nolock
+    fi
+    mount -t $nfs -o$options $server:$path $mntdir
+}
-- 
1.7.7.6
