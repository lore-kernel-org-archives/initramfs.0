From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Thoughts on mounting the rootfs from a udev rule
Date: Fri, 20 Mar 2009 10:15:50 +0100
Message-ID: <49C35EC6.2050405@bfh.ch>
References: <1237496785.5070.28.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1237496785.5070.28.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Victor Lowther wrote:
> It seems that there are two major use cases that make mounting the root
> file system directly from a udev rule an inadvisable design decision:
> 
> The first is when your root filesystem does not reside on a block
> device, as in the nfsroot case.  In this case, there is no backing
> device for the filesystem for udev to detect, so we would still need a
> non-udev method of mounting the root filesystem in order to handle any
> case where there is no backing device for the root filesystem.
> 
> The second is when we are asked to resume from hibernate.  In this case,
> we must not attempt to mount the root filesystem (or any other
> filesystem, for that matter) until we have either attempted to resume
> (and failed) or we have determined that resuming is impossible.  Udev
> does not make any guarantees about the order in which devices are
> discovered, which leads to all sorts of interesting potential failure
> modes when you have either or both of resume handling and rootfs
> handling in a udev rule.
> 
> Thoughts?

 From experience with other software projects, having an event driven
system which asks 'something happened, what should I do' is preferrable
to having to write all the glue code yourself. And one of dracut's goals
is to get rid of as much shell code as possible no?

Question is: Are the described cases exlusive? I mean if udev does
something does it make thawing impossible? Of so, can we prevent it? Or
maybe just postpone starting udev or restart udev at a later point.

Regards,
Philippe



--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
