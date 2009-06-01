From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 9/9] Add NBD support
Date: Mon, 01 Jun 2009 06:14:53 -0500
Message-ID: <1243854893.647.32.camel@sentry-no.fnordovax.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <2b117123ecd2d93cec8598593e966029dfb4777e.1243833882.git.dave@thedillows.org>
	 <1243849301.647.20.camel@sentry-no.fnordovax.org>
	 <1243853722.3844.122.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=bs/jZI/aSGQ43ERhB+xZ7Y8jlvn9/PEP88pyenz9ZDw=;
        b=Jjx1RbUGOzBlUZfskWppyVJAv6GF941Z5M3FK9lUMe9sWlUQ6/8MjjWquA/eLvrYmg
         s5R0saB03J79VtAa7oMqpziZmumW9xVZeDcGUOAlexZvSH9AMnDeq56pvvBCWiqfQlMJ
         dZKBYo1T/o9cyWWfgzefzu7j0Z7xDY9Su5bi0=
In-Reply-To: <1243853722.3844.122.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 06:55 -0400, David Dillow wrote:
> On Mon, 2009-06-01 at 04:41 -0500, Victor Lowther wrote:
> > On Mon, 2009-06-01 at 00:59 -0400, David Dillow wrote:
> 
> > > +# XXX netroot expects to have the handler mount things, but we should
> > > +# XXX allow LVM, LUKS, etc over nbd
> > > +
> > > +nbd-client $preopts "$nbdserver" "$nbdport" /dev/nbd0 $opts || exit 1
> > 
> > Ah, but we are not really a netroot in the sense that NFS is -- all we
> > are doing is attaching a block device.  Once it is attached the usual
> > root-on-block-device rules should kick in as soon as udev sees the block
> > devices.
> 
> Exactly, hence the comment -- and one elsewhere about wanting to move
> the mount to the network block devices via udev. Unfortunately, NBD does
> all of its device adds at module load time, so we cannot trigger a mount
> on those as there's nothing behind the device.

ew, narsty.  Sounds just as annoying as the loopback device.

> I was thinking about 'echo add /path/to/nbd0/uevent' here so we could
> force another loop through udev.
> 
> > > +if ! mount -t $nbdfstype -o$fsopts /dev/nbd0 $NEWROOT; then
> > > +    # Mount failed, clean up after ourselves so if we try a different
> > > +    # interface it can succeed
> > > +    nbd-client -d /dev/nbd0
> > > +    exit 1
> > > +fi
> > 
> > why not just poke udev with udevadm trigger if there is any doubt?
> 
> Not sure what you mean by that in this context -- do you mean the root
> mount via udev as discussed above, or the cleanup right here? 

The root mount.  

> I'm not sure how to do the cleanup when mounting via udev; I'd need to
> think.

Perhaps a mount-failed hook?

> 
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
