From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Hibernate broke?
Date: Wed, 17 Jun 2009 13:20:08 +0200
Message-ID: <4A38D168.6080909@redhat.com>
References: <4A386ECD.1070906@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A386ECD.1070906-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/17/2009 06:19 AM, Warren Togami wrote:
> I noticed today that hibernation is broken for dracut generated images.
> Fedora 11 mkinitrd generated initrd works just fine for me, but the
> dracut generated image of the same kernel is failing to resume.
>
> My system has root and swap both within an encrypted LVM vg.
>
> My understanding is that if you hibernate, it somehow writes something
> recongnized by grub upon the next boot so it knows to boot the same
> kernel & initrd with additional cmdline parameters to resume.
>
> When I hibernate from the mkinitrd initrd, the system shuts down. When I
> boot again, grub immediately jumps into that kernel bypassing the grub
> menu, asks for my passphrase to decrypt, then reads the frozen system
> from swap and resumes.
>
> When I hiberate from a dracut initrd, the system shuts down. When I boot
> up again, it goes to the full grub menu and seems unaware that it had
> hibernated.
>
> Any idea what is going on here? Did this ever work with dracut before?


you could try to just overwrite the mkinitrd generated image and see, if that 
gets booted
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
