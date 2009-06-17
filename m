From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Hibernate broke?
Date: Wed, 17 Jun 2009 09:37:07 -0400
Message-ID: <20090617133706.GC85083@redhat.com>
References: <4A386ECD.1070906@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A386ECD.1070906-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wednesday, June 17 2009, Warren Togami said:
> My understanding is that if you hibernate, it somehow writes something  
> recongnized by grub upon the next boot so it knows to boot the same  
> kernel & initrd with additional cmdline parameters to resume.

Not entirely true -- on hibernate, we do a grub bootonce to force you
back into the same kernel you're already booted into.  The initrd then
as one of its first steps looks at the swap partition (... which in the
Fedora case, is specified as part of the initramfs with support for an
override in /proc/cmdline) and if its a swsusp partition, we resume from it.

> Any idea what is going on here?  Did this ever work with dracut before?

Unless someone added it when I wasn't looking, no one has added the
support to dracut for the resume bits

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
