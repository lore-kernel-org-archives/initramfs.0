From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Hibernate broke?
Date: Wed, 17 Jun 2009 11:11:57 -0400
Message-ID: <4A3907BD.8010800@redhat.com>
References: <4A386ECD.1070906@redhat.com> <4A38D168.6080909@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A38D168.6080909-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/17/2009 07:20 AM, Harald Hoyer wrote:
>>
>> Any idea what is going on here? Did this ever work with dracut before?
>
>
> you could try to just overwrite the mkinitrd generated image and see, if
> that gets booted

Tried that.  It grub failed to jump directly into it during next boot. 
I'm not sure what is missing here.

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
