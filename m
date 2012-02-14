From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/9] port nfsroot to nfs-lib
Date: Tue, 14 Feb 2012 12:38:04 -0500
Message-ID: <1329241090-26908-4-git-send-email-wwoods@redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Rewrite nfsroot to use nfs-lib. The functionality should be unchanged.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/95nfs/nfsroot |   91 ++--------------------------------------------
 1 files changed, 4 insertions(+), 87 deletions(-)

diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index 764971b..589d4ed 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -3,17 +3,9 @@
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+. /lib/nfs-lib.sh
 
-PATH=/usr/sbin:/usr/bin:/sbin:/bin
-
-# Huh? Empty $1?
-[ -z "$1" ] && exit 1
-
-# Huh? Empty $2?
-[ -z "$2" ] && exit 1
-
-# Huh? Empty $3?
-[ -z "$3" ] && exit 1
+[ "$#" = 3 ] || exit 1
 
 # root is in the form root=nfs[4]:[server:]path[:options], either from
 # cmdline or dhcp root-path
@@ -21,85 +13,10 @@ netif="$1"
 root="$2"
 NEWROOT="$3"
 
-# Continue if nfs prefix
-case "${root%%:*}" in
-    nfs|nfs4);;
-    *) return;;
-esac
-
-nfsroot_to_var $root
-
-#Load other data that might provide info
-[ -f /tmp/net.$netif.override ] && . /tmp/net.$netif.override
-[ -f /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
-
-#Empty path means try dhcp root-path, this is ok here since parse-nfsroot.sh
-#already takes care of nfs:... formatted root-path
-[ -z "$path" ] && nfsroot_to_var $nfs:$new_root_path
-
-#Empty path defaults to "/tftpboot/%s" only in nfsroot.txt legacy mode
-[ -z "$path" ] && [ "$(getarg root=)" = "/dev/nfs" ] && path="/tftpboot/%s"
-
-if [ -z "$server" ] ; then
-    # XXX new_dhcp_next_server is unconfirmed this is an assumption
-    for var in $srv $new_dhcp_server_identifier $new_dhcp_next_server $new_root_path '' ; do
-        [ -n "$var" ] && server=$var && break;
-    done
-
-    # XXX This blindly assumes that if new_root_path has to used that
-    # XXX it really can be used as server
-    server=${server%%:*}
-fi
-
+nfs_to_var $root $netif
 [ -z "$server" ] && die "Required parameter 'server' is missing"
 
-# Kernel replaces first %s with host name, and falls back to the ip address
-# if it isn't set. Only the first %s is substituted.
-if [ "${path#*%s}" != "$path" ]; then
-    ip=$(ip -o -f inet addr show $netif)
-    ip=${ip%%/*}
-    ip=${ip##* }
-    read node < /proc/sys/kernel/hostname
-    [ "$node" = "(none)" ] && node=$ip
-    path=${path%%%s*}$node${path#*%s}
-fi
-
-# Look through the options and remove rw/locking options
-OLDIFS="$IFS"
-IFS=,
-for f in $options ; do
-    [ "$f" = "ro" -o "$f" = "rw" ] && nfsrw=$f && continue
-    [ "$f" = "lock" -o "$f" = "nolock" ] && nfslock=$f && continue
-    flags=${flags:+$flags,}$f
-done
-IFS="$OLDIFS"
-options=$flags
-
-# Override rw/ro if set on cmdline
-getarg ro && nfsrw=ro
-getarg rw && nfsrw=rw
-
-# Default to ro if unset
-[ -z "$nfsrw" ] && nfsrw=ro
-
-options=${options:+$options,}$nfsrw
-
-if [ "$nfs" = "nfs4" ]; then
-    # XXX Should we loop here?
-    mount -t nfs4 -o$options${nfslock+,$nfslock} \
-        $server:$path $NEWROOT \
-        && { [ -e /dev/root ] || >/dev/root ; }
-else
-    # NFSv{2,3} doesn't support using locks as it requires a helper to transfer
-    # the rpcbind state to the new root
-    [ "$nfslock" = "lock" ] && \
-        warn "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
-
-    # XXX Should we loop here?
-    { mount -t nfs -o$options${options:+,}nolock,nfsvers=3 $server:$path $NEWROOT || \
-        mount -t nfs -o$options${options:+,}nolock,nfsvers=2 $server:$path $NEWROOT ; } \
-        && { [ -e /dev/root ] || >/dev/root ; }
-fi
+mount_nfs $root $NEWROOT $netif && { [ -e /dev/root ] || >/dev/root ; }
 
 # inject new exit_if_exists
 echo 'settle_exit_if_exists="--exit-if-exists=/dev/root"; rm "$job"' > $hookdir/initqueue/nfs.sh
-- 
1.7.7.6
