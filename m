From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Fri, 19 Dec 2008 15:41:51 -0500
Message-ID: <8427F51F-59A4-4A26-9404-B2F13947C889@redhat.com>
References: <1229540094.28858.150.camel@aglarond.local>	 <20081217190700.GA15377@infradead.org>  <4949FD67.6040906@suse.de> <1229631131.13174.23.camel@aglarond.local> <494B5979.3080606@suse.de> <44C50A6A-0FDB-4BF0-8B8B-CD9DAC7B7ED4@redhat.com> <494BFE7E.8090301@bfh.ch>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <494BFE7E.8090301-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Dec 19, 2008, at 3:05 PM, Seewer Philippe wrote:
> Jeremy Katz wrote:
> [snip]
>>
>> And yes, everywhere is really more like everywhere(*) -- the stock  
>> config being "local block devices" but with the ability to expand  
>> out and support the more esoteric cases.
>
> Hmmm... if we are realle talking about integrating this _into_ the  
> kernel why not introduce something like <Mi> "Build as module,  
> integrate into initramfs?" into kernel config?

Mostly because we have to walk before we can run. :)

> [snip]
> On the other hand, "early-userspace" is necessary as stated. As a  
> further suggestion: Why not restrict initramfs really to the "only  
> mount-/" problem domain. On failures or errors, a fallback ram-image  
> could be used and switchroot'ed into normally like any other root  
> which would then do the job. I think this would solve the busybox/ 
> user-needs-shell problem as well, which could reside in the ram-image.

I've similarly thought that this could be a good way to take care of  
things like the kdump case which while they use an initramfs are  
really a more specialized install image that should be mounted as a  
rootfs.

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
