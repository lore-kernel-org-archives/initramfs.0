From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH 1/9] nfsroot: move to same sort order as block methods
Date: Mon, 1 Jun 2009 11:20:11 +0200
Message-ID: <4A239D4B.2050009@bfh.ch>
References: <cover.1243833882.git.dave@thedillows.org> <145ca9e5b331c454ebe13005fdfaed3749ef50f5.1243833882.git.dave@thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <145ca9e5b331c454ebe13005fdfaed3749ef50f5.1243833882.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

David Dillow wrote:
[snip]
> diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
> new file mode 100755
> index 0000000..b8858bc
> --- /dev/null
> +++ b/modules.d/95nfs/nfsroot
> @@ -0,0 +1,125 @@
> +#!/bin/sh
> +
> +. /lib/dracut-lib
> +
> +PATH=$PATH:/sbin:/usr/sbin
> +
> +# XXX needs error handling like ifup/dhclient-script
> +
> +# XXX need to lock our attempts if we're doing the mount here
> +
> +getarg rdnetdebug && {
> +    exec > /tmp/nfsroot.$1.$$.out
> +    exec 2>> /tmp/nfsroot.$1.$$.out
> +    set -x
> +}
> +
> +[ "$NFS_LOCKED" ] || {
> +	NFS_LOCKED=true
> +	export NFS_LOCKED
> +	exec flock -xo /tmp/nfs.lock -c "$0 $*"
> +	exit 1
> +}
> +
> +[ -e /tmp/nfsdone ] && exit 0
> +
> +nfs_done() {
> +    >/tmp/nfsdone
> +    exit 0
> +}
> +
> +root=$(getarg root)
> +case $root in
> +    nfs|/dev/nfs)	type=nfs  ;;
> +    nfs4|/dev/nfs4)	type=nfs4 ;;
> +    auto|'')		type=auto  ;;
> +esac
> +
> +rootfstype=$(getarg rootfstype)
> +case $rootfstype in
> +    nfs|nfs4|auto)	type=$rootfstype  ;;
> +esac
> +
> +# If we're not doing NFS at all, don't keep banging our head
> +[ -n "$type" ] || nfs_done
> +
> +[ -e /tmp/net.$1.dhcpopts ] && . /tmp/net.$1.dhcpopts
> +
> +nfsroot=$(getarg nfsroot)
> +[ -n "$nfsroot" ] || nfsroot="$new_root_path"
> +[ -n "$nfsroot" ] || nfs_done
> +
> +# check for IP address at front, if there is none, use
> +# new_dhcp_server_identifier
> +#
> +# XXX kernel nfsroot uses , to separate NFS options at end
> +#
> +nfsserver=${nfsroot%%:*}; nfsroot=${nfsroot#*:}
> +nfspath=${nfsroot%%:*}
> +flags=${nfsroot#*:}
> +[ "$nfsserver" = "$nfspath" ] && nfsserver=$new_dhcp_server_identifier
> +[ "$nfspath" = "$flags" ] && unset flags
> +
> +[ -n "$nfsserver" ] || no_nfs
> +
> +# look through the flags and see if any are overridden by the command line
> +while [ -n "$flags" ]; do
> +    f=${flags%%,*}; flags=${flags#*,}
> +    [ "$f" = "nfs" -o "$f" = "nfs4" ] && {
> +	[ "$type" = "auto" ] && type=$f
> +	continue
> +    }
> +    [ "$f" = "ro" -o "$f" = "rw" ] && {
> +	nfsrw=$f
> +	continue
> +    }
> +    [ "$f" = "lock" -o "$f" = "nolock" ] && {
> +	nfslock=$f
> +	continue
> +    }
> +    nfsflags=${nfsflags+$nfsflags,}$f
> +done
> +
> +getarg ro && nfsrw=ro
> +getarg rw && nfsrw=rw
> +nfsflags=${nfsflags+$nfsflags,}${nfsrw}
> +
> +# load our modules explicitly, so we can fail fast in the future
> +modprobe nfs || nfs_done

Hmmm... isn't that a bit dangerous? I mean what if nfs support is 
compiled into the kernel?

> +
> +# XXX don't forget to move /var/lib/nfs/rpc_pipefs to new /
> +# XXX need host name set before now?
> +
> +# Start rpcbind and rpc.statd as mount won't let us use locks on a NFSv4
> +# filesystem without talking to them, even though they are unneeded
> +# XXX occasionally saw 'rpcbind: fork failed: No such device' -- why?
> +[ -n "$(pidof rpcbind)" ] || rpcbind

I see a potential conflict here: Debian based distros use portmap not 
rpcbind.

> +[ -n "$(pidof rpc.statd)" ] || rpc.statd

Question: Do we really need statd?
> +
> +# XXX should I do rpc.idmapd here, or wait and start in the new root
> +# XXX waiting assumes root can read everything it needs right up until
> +# XXX we start it...

Dracut should only care about getting the root-fs. idmapd is really a 
system configuration, don't start that.

> +
> +# XXX really, want to retry in a loop I think, but not here...
> +
> +[ "$type" = "nfs4" -o "$type" = "auto" ] && {
> +    # XXX really needed? Do we need non-root users before we start it in
> +    # XXX the real root image?
> +    [ -n "$(pidof rpc.idmapd)" ] || rpc.idmapd
> +
> +    # NFSv4 does locks internally
> +    mount -t nfs4 -o${nfsflags}${nfslock+,$nfslock} \
> +			$nfsserver:$nfspath /sysroot && nfs_done
> +
> +    # If we're specified to be NFSv4, then stop when we fail
> +    # Don't mark us done, as this may be transient
> +    [ "$type" = "nfs4" ] && exit 0
> +}
> +
> +# we're NFSv{2,3} or auto and NFSv4 failed. We don't support using locks
> +# on NFSv{2,3} because that requires a helper to transfer the rpcbind state
> +# rpcbind to the new root
> +[ -z "$nfslock" -o "$nfslock" = "lock" ] &&
> +    echo "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
> +mount -t nfs -onolock,$nfsflags $nfsserver:$nfspath /sysroot && nfs_done
> +exit 0
> diff --git a/modules.d/95nfs/nfsroot-cleanup.sh b/modules.d/95nfs/nfsroot-cleanup.sh
> new file mode 100644
> index 0000000..b8f3a2f
> --- /dev/null
> +++ b/modules.d/95nfs/nfsroot-cleanup.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +
> +pid=$(pidof rpc.statd)
> +[ -n "$pid" ] && kill $pid
> +
> +pid=$(pidof rpcbind)
> +[ -n "$pid" ] && kill $pid
> +
> +if grep -q rpc_pipefs /proc/mounts; then 
> +    # try to create the destination directory
> +    [ -d $NEWROOT/var/lib/nfs/rpc_pipefs ] || mkdir -p $NEWROOT/var/lib/nfs/rpc_pipefs 2>/dev/null
> +
> +    if [ -d $NEWROOT/var/lib/nfs/rpc_pipefs ]; then
> +	mount --move /var/lib/nfs/rpc_pipefs $NEWROOT/var/lib/nfs/rpc_pipefs
> +    else
> +	umount /var/lib/nfs/rpc_pipefs
> +    fi
> +fi

Question: Do we really have to do that? I mean nfsroot worked until now 
without considering rpc_pipefs.

Regards,
Philippe

> +
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
