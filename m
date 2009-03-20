From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Thoughts on mounting the rootfs from a udev rule
Date: Fri, 20 Mar 2009 04:14:47 -0500
Message-ID: <1237540487.5070.54.camel@sentry-no.fnordovax.org>
References: <1237496785.5070.28.camel@sentry-no.fnordovax.org>
	 <49C3546C.8050505@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=aWY5+xxZ2c7U5UNbMflWPSG5kS5bRyYBD9T6IgVKu5Y=;
        b=GnQ/o9dbVFOj4mB14jJnBgktlkFTH67k/uKk7LsrNGBeoaUPvJJexJsttl7Vk6TwQm
         qKpsVYNC3tedYGrOlYPWcP9ZK+ht2+wotVj9N6DVy+vPQePmfXoMoF6mnCWkf13XolBd
         c+0TjPvplphoWAt69HfeGPp10uga5lq2hA3r8=
In-Reply-To: <49C3546C.8050505-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-03-20 at 09:31 +0100, Hannes Reinecke wrote:
> Victor Lowther wrote:
> > It seems that there are two major use cases that make mounting the root
> > file system directly from a udev rule an inadvisable design decision:
> > 
> > The first is when your root filesystem does not reside on a block
> > device, as in the nfsroot case.  In this case, there is no backing
> > device for the filesystem for udev to detect, so we would still need a
> > non-udev method of mounting the root filesystem in order to handle any
> > case where there is no backing device for the root filesystem.
> > 
> Hmm. There is no strict _need_ for a backing device for udev to work
> properly, we just need an event here.
> So for the nfsroot case it would be totally sufficient to have an event
> like 'network is up'. This could then trigger a nfsmount

In simple cases, maybe.  In the sort of cases Seewer has to deal with,
it gets a great deal more complicated.

Driving network configuration from udev is easy and usually the right
thing to do, but doesn't really help when you don't know beforehand
which interface will actually be able to talk to the nfs server.

> > The second is when we are asked to resume from hibernate.  In this case,
> > we must not attempt to mount the root filesystem (or any other
> > filesystem, for that matter) until we have either attempted to resume
> > (and failed) or we have determined that resuming is impossible.  Udev
> > does not make any guarantees about the order in which devices are
> > discovered, which leads to all sorts of interesting potential failure
> > modes when you have either or both of resume handling and rootfs
> > handling in a udev rule.
> > 
> Ah, that's ok. In these cases you'll have a 'resume=' argument in
> the kernel commandline, so you just need to write a rule using an
> event serializer/capture like 'collect':
> - Use three arguments to collect, root device, resume device, and
>   another one signifying 'resume_done'.
> - Add another rule which triggers resume on the resume device, sets
>   'resume_done' if resume returns, and triggers the collect rule again.
> - Then collect will return 1 and start the mount process.

How does that handle the case where we asked to resume but the resume
device is not found?

Will it be easier to maintain than just waiting for all the devices to
be found and configured before trying to resume or mount anything?

> No problem there. However, you're still facing the problem that you'd
> might want to run 'fsck' on the root device. And you might want to
> know when 'mount' has actually finished, as only then you can execute
> 'init'. Sadly the 'mount' events are gone from the kernel, otherwise
> it would've been quite handy here.

Indeed.

> Cheers,
> 
> Hannes
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
