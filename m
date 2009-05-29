From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: plymouth working for anybody with F-11?
Date: Fri, 29 May 2009 09:27:59 +0200
Message-ID: <4A1F8E7F.6080201@redhat.com>
References: <4A1F6351.8070908@redhat.com> <4A1F6550.4070400@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A1F6550.4070400-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/29/2009 06:32 AM, Warren Togami wrote:
> On 05/29/2009 12:23 AM, Warren Togami wrote:
>> Is plymouth working for anyone with F-11 right now?
>>
>> In my case it seems to fail to load the KMS kernel module (intel.ko in
>> my case) prior to plymouth splash is executed.
>>
>
> Another problem is it seems to still use default.so.
>
> [[ -f ${LIBDIR}/plymouth/default.so ]] && inst
> ${LIBDIR}/plymouth/default.so
>
> The plymouth in F-11 seems to no longer use the default.so symlink. It
> seems to be copying the default "charge" theme into the image, but
> without the required two-step.so plugin.
>
> BTW, why are we using our own plymouth-populate-initrd instead of using
> plymouth's own /usr/libexec/plymouth/plymouth-populate-initrd, which
> presumably would do the right thing for its own version of plymouth?
> (Didn't try it yet.)

/usr/libexec/plymouth/plymouth-populate-initrd should/will be fixed to use 
dracut syntax and will be used, as soon as dracut replaces mkinitrd.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
