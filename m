From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Issues with dracut and network device naming
Date: Fri, 28 Aug 2009 17:25:26 +0200
Message-ID: <4A97F6E6.4040206@bfh.ch>
References: <4A97CA1A.5080606@redhat.com> <4A97D0F9.9020302@redhat.com> <4A97D17F.10405@bfh.ch> <4A97E6CA.2020200@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A97E6CA.2020200-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>



Hans de Goede wrote:
> Hi,
> 
> On 08/28/2009 02:45 PM, Seewer Philippe wrote:
>>
>> Harald Hoyer wrote:
>> [snip]
>>>> So I would like to propose another solution for this, allow specifying
>>>> both an interface-name and a mac with ip=, and then have the dracut
>>>> generated rules do the rename and init. This way problems 3) and 4)
>>>> above are solved, and we can easily also write the mac address to
>>>> grub.conf from anaconda when generating the ip= cmdline.
>>> yes, sane solution .. +1
>> Yes, +1 as well. I'd vote for not doing this inside the ip= parameter,
>> but use something like ifname=iface:mac.
>>
> 
> Hmm, I'm not so sure about that, it sure would be easier for the genrules
> script to have all the info in one place, instead of having to piece
> bits together.

Yes. But I think from a user's point of view, the ip= argument is 
already overloaded. ifname= (or whatever) would be much clearer and easier.

Regards,
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
