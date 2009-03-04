From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Dracut on different distros?
Date: Wed, 4 Mar 2009 17:44:15 +0100
Message-ID: <49AEAFDF.6010405@bfh.ch>
References: <49AE99D2.1000501@bfh.ch>	 <0227279C-8C23-4501-B163-04470D0C0F35@gmail.com> <82ecf08e0903040820t42775dd8s56e32d9d5dd53c36@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <82ecf08e0903040820t42775dd8s56e32d9d5dd53c36-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



Thiago Galesi wrote:
>>> Certainly stupid me can't think of a way to be sure we "really really"
>>> have all block drivers without including every single .ko. Leave it to the
>>> user to specifically set drivers or the Distro to tell Dracut which drivers
>>> to include.
>> Indeed.
>>
> 
> Isn't this two different things?
> 
> I mean, it's one thing to have a "generic" initrd for, I dunno, live
> CDs, etc and another thing to generate for a specific
> computer/installation. And even installation triggers run mkinitrd (or
> similar), no?

It entirely depends on your point of view. The contents of the actually 
generated initrd might be very different. At least the contained modules 
could differ, the rest of the initrd could actually be the same.

And how we generate those images might not differ from use-case to the 
next at all.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
