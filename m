From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC PATCH 9/9] Add NBD support
Date: Mon, 01 Jun 2009 06:55:22 -0400
Message-ID: <1243853722.3844.122.camel@obelisk.thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <2b117123ecd2d93cec8598593e966029dfb4777e.1243833882.git.dave@thedillows.org>
	 <1243849301.647.20.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243849301.647.20.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 04:41 -0500, Victor Lowther wrote:
> On Mon, 2009-06-01 at 00:59 -0400, David Dillow wrote:

> > +# XXX netroot expects to have the handler mount things, but we should
> > +# XXX allow LVM, LUKS, etc over nbd
> > +
> > +nbd-client $preopts "$nbdserver" "$nbdport" /dev/nbd0 $opts || exit 1
> 
> Ah, but we are not really a netroot in the sense that NFS is -- all we
> are doing is attaching a block device.  Once it is attached the usual
> root-on-block-device rules should kick in as soon as udev sees the block
> devices.

Exactly, hence the comment -- and one elsewhere about wanting to move
the mount to the network block devices via udev. Unfortunately, NBD does
all of its device adds at module load time, so we cannot trigger a mount
on those as there's nothing behind the device.

I was thinking about 'echo add /path/to/nbd0/uevent' here so we could
force another loop through udev.

> > +if ! mount -t $nbdfstype -o$fsopts /dev/nbd0 $NEWROOT; then
> > +    # Mount failed, clean up after ourselves so if we try a different
> > +    # interface it can succeed
> > +    nbd-client -d /dev/nbd0
> > +    exit 1
> > +fi
> 
> why not just poke udev with udevadm trigger if there is any doubt?

Not sure what you mean by that in this context -- do you mean the root
mount via udev as discussed above, or the cleanup right here? 

I'm not sure how to do the cleanup when mounting via udev; I'd need to
think. I'm not sure doing udevadm trigger or udevadm settle inside a
udev handler is a good thing...

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
