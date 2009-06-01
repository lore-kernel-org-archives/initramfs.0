From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC PATCH 1/9] nfsroot: move to same sort order as block
 methods
Date: Mon, 01 Jun 2009 06:56:05 -0400
Message-ID: <1243853765.3844.126.camel@obelisk.thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <145ca9e5b331c454ebe13005fdfaed3749ef50f5.1243833882.git.dave@thedillows.org>
	 <4A239D4B.2050009@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A239D4B.2050009-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 11:20 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> > +# load our modules explicitly, so we can fail fast in the future
> > +modprobe nfs || nfs_done
> 
> Hmmm... isn't that a bit dangerous? I mean what if nfs support is 
> compiled into the kernel?

Probably; we can either drop it or add a check for nfs
in /proc/filesystems before calling it.

> > +[ -n "$(pidof rpcbind)" ] || rpcbind
> 
> I see a potential conflict here: Debian based distros use portmap not 
> rpcbind.

Go to know; I'll think about how to handle that.

> > +[ -n "$(pidof rpc.statd)" ] || rpc.statd
> 
> Question: Do we really need statd?

Yes, if you want to use locks you need statd. We can avoid it on NFSv3
by using nolock, and it is not needed for NFSv4 to use locks, but mount
will not even try to mount the filesystem without it or -onolock
present.

> > +# XXX should I do rpc.idmapd here, or wait and start in the new root
> > +# XXX waiting assumes root can read everything it needs right up until
> > +# XXX we start it...
> 
> Dracut should only care about getting the root-fs. idmapd is really a 
> system configuration, don't start that.

Somewhat vestigial from my purpose of getting RedHat to boot with a read
only NFS root -- I wasn't sure if it needed to read files as a non-root
user.

It could probably go.

> > diff --git a/modules.d/95nfs/nfsroot-cleanup.sh b/modules.d/95nfs/nfsroot-cleanup.sh

> > +if grep -q rpc_pipefs /proc/mounts; then 
> > +    # try to create the destination directory
> > +    [ -d $NEWROOT/var/lib/nfs/rpc_pipefs ] || mkdir -p $NEWROOT/var/lib/nfs/rpc_pipefs 2>/dev/null
> > +
> > +    if [ -d $NEWROOT/var/lib/nfs/rpc_pipefs ]; then
> > +	mount --move /var/lib/nfs/rpc_pipefs $NEWROOT/var/lib/nfs/rpc_pipefs
> > +    else
> > +	umount /var/lib/nfs/rpc_pipefs
> > +    fi
> > +fi
> 
> Question: Do we really have to do that? I mean nfsroot worked until now 
> without considering rpc_pipefs.

If idmapd goes, I think this could go as well. The problem is that you
never get it mounted again, as it is usually handled on modprobe of
sunrpc, which happens inside the initramfs.

nfsroot worked without it, because as far as I've seen, it's always been
NFSv2/3 with nolock.

This can of course be fixed in the distros.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
