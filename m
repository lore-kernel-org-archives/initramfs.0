From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Thoughts on mounting the rootfs from a udev rule
Date: Fri, 20 Mar 2009 04:51:42 -0500
Message-ID: <1237542702.5070.84.camel@sentry-no.fnordovax.org>
References: <1237496785.5070.28.camel@sentry-no.fnordovax.org>
	 <49C3546C.8050505@suse.de>
	 <1237540487.5070.54.camel@sentry-no.fnordovax.org>
	 <49C360B3.9020107@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=oA1NIKQ16kbcIixzSFgF+fA7sNop4tdnouQBb/83hAM=;
        b=GBs+8WgY+UYYUGDEz8wfQPAHGojHUseAMSwJSumK3+KDKVIM4KHKS65//lMej7ZHGn
         MjacfbnkAvdevUuqXPyMoGOYP/VlI2Ii03kVGSgbFUrIjVCl50asLVIk7T3BXm5IW1WI
         0Ppj104VWxq4ujRBOs+Xs5tKulG9bjy74C4Pk=
In-Reply-To: <49C360B3.9020107-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-03-20 at 10:24 +0100, Seewer Philippe wrote:
> Victor Lowther wrote:
> [snip]
> >> Hmm. There is no strict _need_ for a backing device for udev to work
> >> properly, we just need an event here.
> >> So for the nfsroot case it would be totally sufficient to have an event
> >> like 'network is up'. This could then trigger a nfsmount
> > 
> > In simple cases, maybe.  In the sort of cases Seewer has to deal with,
> > it gets a great deal more complicated.
> 
> Yes and no. The current implementation is sort of event-based. "Network 
> is up, please test" means theres something in the fifo and we can go and 
> try. The same could be done via udev, if we could tell it do so 
> something. Only problem I see would be synchronizing asynchronous events.

As far as I know, you cannot inject an event into udev from userspace.
It responds to messages from the kernel and that is it.

> > Driving network configuration from udev is easy and usually the right
> > thing to do, but doesn't really help when you don't know beforehand
> > which interface will actually be able to talk to the nfs server.
> 
> Or even worse, if you receive mount-data through dhcp options. But even 
> that could be handled somehow if we had to.

Actually, that part should not be that hard -- just separate the "saving
info from dhclient" and "configuring the interface" phases.

> >>> The second is when we are asked to resume from hibernate.  In this case,
> >>> we must not attempt to mount the root filesystem (or any other
> >>> filesystem, for that matter) until we have either attempted to resume
> >>> (and failed) or we have determined that resuming is impossible.  Udev
> >>> does not make any guarantees about the order in which devices are
> >>> discovered, which leads to all sorts of interesting potential failure
> >>> modes when you have either or both of resume handling and rootfs
> >>> handling in a udev rule.
> >>>
> >> Ah, that's ok. In these cases you'll have a 'resume=' argument in
> >> the kernel commandline, so you just need to write a rule using an
> >> event serializer/capture like 'collect':
> >> - Use three arguments to collect, root device, resume device, and
> >>   another one signifying 'resume_done'.
> >> - Add another rule which triggers resume on the resume device, sets
> >>   'resume_done' if resume returns, and triggers the collect rule again.
> >> - Then collect will return 1 and start the mount process.
> > 
> > How does that handle the case where we asked to resume but the resume
> > device is not found?
> 
> Question: If we know which device to resume from, why not have a 
> pre-udev rule specifying _if_ that device shows up try to thaw?

If it shows up after we have already started mounting the root
filesystem we are hosed.

If it never shows up at all, things get interesting depending on exactly
how we want to handle that case.

> > Will it be easier to maintain than just waiting for all the devices to
> > be found and configured before trying to resume or mount anything?
> 
> I guess that depends on personal taste (and documentation)
> 
> >> No problem there. However, you're still facing the problem that you'd
> >> might want to run 'fsck' on the root device. And you might want to
> >> know when 'mount' has actually finished, as only then you can execute
> >> 'init'. Sadly the 'mount' events are gone from the kernel, otherwise
> >> it would've been quite handy here.
> 
> Again, is it possible to send events to udev from Userspace?
> 
> Regards,
> Philippe
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
