From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Issues with dracut and network device naming
Date: Fri, 28 Aug 2009 14:45:51 +0200
Message-ID: <4A97D17F.10405@bfh.ch>
References: <4A97CA1A.5080606@redhat.com> <4A97D0F9.9020302@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A97D0F9.9020302-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussion of Development and Customization of the Red Hat Linux
	Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>



Harald Hoyer wrote:
[snip]
>> So I would like to propose another solution for this, allow specifying
>> both an interface-name and a mac with ip=, and then have the dracut
>> generated rules do the rename and init. This way problems 3) and 4)
>> above are solved, and we can easily also write the mac address to
>> grub.conf from anaconda when generating the ip= cmdline.
> 
> yes, sane solution .. +1
Yes, +1 as well. I'd vote for not doing this inside the ip= parameter, 
but use something like ifname=iface:mac.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
