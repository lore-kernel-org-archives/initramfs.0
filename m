From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Fri, 19 Dec 2008 21:05:18 +0100
Message-ID: <494BFE7E.8090301@bfh.ch>
References: <1229540094.28858.150.camel@aglarond.local>	 <20081217190700.GA15377@infradead.org>  <4949FD67.6040906@suse.de> <1229631131.13174.23.camel@aglarond.local> <494B5979.3080606@suse.de> <44C50A6A-0FDB-4BF0-8B8B-CD9DAC7B7ED4@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <44C50A6A-0FDB-4BF0-8B8B-CD9DAC7B7ED4-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Jeremy Katz wrote:
[snip]
> Well, you don't need _all_.  I've yet to come up with a convincing 
> reason to want the sound drivers for example :)
Error messages read aloud? I've always wanted to hear 'kernel panic!' 
instead of just reading it :-)

> And yes, everywhere is really more like everywhere(*) -- the stock 
> config being "local block devices" but with the ability to expand out 
> and support the more esoteric cases.

Hmmm... if we are realle talking about integrating this _into_ the 
kernel why not introduce something like <Mi> "Build as module, integrate 
into initramfs?" into kernel config?

[snip]
>> No, I favour a completely different approach: Link the required
>> modules into the kernel. When we run the mkinitrd prg (or whatever 
>> it's called) to create
>> the initrd, we will be detecting the modules which are required
>> to boot the kernel and mount the rootfs.
>> If it were now possible to link these modules into the kernel
>> directly via some 'ld' magic, we could get away with loading
>> just one kernel image without any initramfs. No modprobe,
>> nothing. That would be _fast_. And we would be having the
>> advantage that we could kexec into the 'normal' boot image
>> with initramfs if this 'single shot' approach doesn't work.
> 
> You still have to have an initramfs as you aren't going to have the 
> logic for LVM activation in the kernel.  Or to handle resume from 
> hibernate.  Or dm-crypt.  Etc.  So an initramfs is really something akin 
> to a requirement for non-trivial systems.  And the speed really isn't a 
> fundamental factor of dealing with an initramfs.  I was actually quite 
> surprised by how fast I was able to boot with a dracut-generated initramfs

To be honest I'd really like some magic to tie a module back into the 
kernel for really fast bootup.

On the other hand, "early-userspace" is necessary as stated. As a 
further suggestion: Why not restrict initramfs really to the "only 
mount-/" problem domain. On failures or errors, a fallback ram-image 
could be used and switchroot'ed into normally like any other root which 
would then do the job. I think this would solve the 
busybox/user-needs-shell problem as well, which could reside in the 
ram-image.


Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
