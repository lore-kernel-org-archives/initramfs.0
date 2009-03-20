From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Thoughts on mounting the rootfs from a udev rule
Date: Fri, 20 Mar 2009 04:29:25 -0500
Message-ID: <1237541365.5070.64.camel@sentry-no.fnordovax.org>
References: <1237496785.5070.28.camel@sentry-no.fnordovax.org>
	 <49C35EC6.2050405@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=dZp+reyaaomXrh7taIa4+ytZzrJmY5daywJ/COOXoSY=;
        b=XatB3vqW78I9uEgmNTttnHFoVWgFwwX8LIZppgk626lKe4/7I7NXmHz3LsP7DgukHd
         /OyXmH31JPW7wUqw67zoRm4mXB8qvdJn5VEzOWyn2NmBXZJxFlNQiUzGuULqMSYxAUXC
         Pvmy7gm/1SeUEGbdkuH4mEk84DQDRoOhwtXPM=
In-Reply-To: <49C35EC6.2050405-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-03-20 at 10:15 +0100, Seewer Philippe wrote:
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
> > The second is when we are asked to resume from hibernate.  In this case,
> > we must not attempt to mount the root filesystem (or any other
> > filesystem, for that matter) until we have either attempted to resume
> > (and failed) or we have determined that resuming is impossible.  Udev
> > does not make any guarantees about the order in which devices are
> > discovered, which leads to all sorts of interesting potential failure
> > modes when you have either or both of resume handling and rootfs
> > handling in a udev rule.
> > 
> > Thoughts?
> 
>  From experience with other software projects, having an event driven
> system which asks 'something happened, what should I do' is preferrable
> to having to write all the glue code yourself. And one of dracut's goals
> is to get rid of as much shell code as possible no?

It is a tradeoff -- I have little doubt that we could force nearly
everything to happen as a direct result of a udev rule firing, but would
that result be more or less maintainable and understandable than a
hybrid solution?

> Question is: Are the described cases exlusive? I mean if udev does
> something does it make thawing impossible? Of so, can we prevent it? Or
> maybe just postpone starting udev or restart udev at a later point.

If you mount an ext3 filesystem it replays the journal whether or not
you mount it read-only.  If you do that when you were hibernated then
the filesystem will be dirty.  If at any point after journal replay has
started udev discovers the resume device an initiates a resume you have
just silently corrupted your root filesystem.  If you are lucky you
might be able to recover from it.

> Regards,
> Philippe
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
