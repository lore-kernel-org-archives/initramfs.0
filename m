From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: The (unnecessary) overhead of initramfs
Date: Wed, 29 Jul 2009 12:19:53 -0400
Message-ID: <4A7076A9.2000608@redhat.com>
References: <1248871245.23840.46.camel@quest> <20090729161655.GG20210@shadowen.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090729161655.GG20210-26w3C0LaAnFg9hUCZPvPmw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/29/2009 12:16 PM, Andy Whitcroft wrote:
> On Wed, Jul 29, 2009 at 01:40:45PM +0100, Scott James Remnant wrote:
>
>> The initramfs scripts spend a lot of wasted time and effort doing things
>> that really don't need to be done:
>>
>> In the "framebuffer" init-top script:
>>
>>    modprobe -q intel_agp
>>    modprobe -q i915
>>    modprobe -q ${FB} ${OPTS}
>
> These may be the source of an issue we are seeing with radeon drivers.
> That when using a pure AMD system you get the i915 driver loaded for
> no apparent reason.  I presume these should be -b even if they were
> not redundant?
>

Why is this being discussed on this list when this has nothing to do 
with dracut?

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
