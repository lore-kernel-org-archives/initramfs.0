From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Hibernate broke?
Date: Wed, 17 Jun 2009 09:22:59 -0500
Message-ID: <6BF4DEAE-2459-4C00-98A5-9CDD7EFD303D@gmail.com>
References: <4A386ECD.1070906@redhat.com> <20090617133706.GC85083@redhat.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=9KHGIwMwUnWX7it6/0zbpj+6sOx7RtkRnCMiyK3wihc=;
        b=P8cO2c2ML2LIDZ/knX9YRRncypedBYcpMYx8XZXrUHqQQ2sI/DTLu8CLJ/b5ejHvL0
         g3FEuznDocM7IYQUy2HFPZVFhTMc1YTyayFAKgPxT2zCRYX7RYedfOJPRCFwKyM+ojlr
         8XX3GveL5X05B5cOhx4pwhvWq+Qpl0Go7E0wY=
In-Reply-To: <20090617133706.GC85083-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Jun 17, 2009, at 8:37 AM, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Wednesday, June 17 2009, Warren Togami said:
>> My understanding is that if you hibernate, it somehow writes  
>> something
>> recongnized by grub upon the next boot so it knows to boot the same
>> kernel & initrd with additional cmdline parameters to resume.
>
> Not entirely true -- on hibernate, we do a grub bootonce to force you
> back into the same kernel you're already booted into.  The initrd then
> as one of its first steps looks at the swap partition (... which in  
> the
> Fedora case, is specified as part of the initramfs with support for an
> override in /proc/cmdline) and if its a swsusp partition, we resume  
> from it.

Dracut just looks for the resume= parameter, and writes a udev rule  
that fires when the device is found if the parameter was on the  
commandline.

>
>
>> Any idea what is going on here?  Did this ever work with dracut  
>> before?
>
> Unless someone added it when I wasn't looking, no one has added the
> support to dracut for the resume bits
>

I did way back in the day as a mount hook. I have not tested it since  
it was turned into a dynamically generated udev rule.

> Jeremy
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
