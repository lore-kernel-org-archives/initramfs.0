From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Thoughts on mounting the rootfs from a udev rule
Date: Fri, 20 Mar 2009 10:18:21 +0100
Message-ID: <49C35F5D.6010107@bfh.ch>
References: <1237496785.5070.28.camel@sentry-no.fnordovax.org> <49C3546C.8050505@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49C3546C.8050505-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hannes Reinecke wrote:
> Victor Lowther wrote:
>> It seems that there are two major use cases that make mounting the root
>> file system directly from a udev rule an inadvisable design decision:
>>
>> The first is when your root filesystem does not reside on a block
>> device, as in the nfsroot case.  In this case, there is no backing
>> device for the filesystem for udev to detect, so we would still need a
>> non-udev method of mounting the root filesystem in order to handle any
>> case where there is no backing device for the root filesystem.
>>
> Hmm. There is no strict _need_ for a backing device for udev to work
> properly, we just need an event here.
> So for the nfsroot case it would be totally sufficient to have an event
> like 'network is up'. This could then trigger a nfsmount

Hmmm... I haven't thought about that. Is it possible to send events to 
udev from Userspace?

Cheers,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
