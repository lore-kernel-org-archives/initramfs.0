From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Date: Mon, 6 Apr 2020 13:20:42 +0200
Message-ID: <20200406112042.GC2520@zn.tnic>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan>
 <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan>
 <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic>
 <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586172046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mSBY02R5H9nBmCTjq2Il3qFMSY21p0ZEMvW/qkGc8UM=;
        b=qssMpFUq4EwfQolq4WjiBir2F2H3hcsAnbGJHyAh3x+bO/QI9cBC//xIX/GoKFWynvq6dq
        AyeeGgEuBJag/3o7V78r4loh2QXbMpvFUyweVJk5AaCfF+H8tOuqGj6N/5CbGcFLWavqIn
        tsoKCrlJ6OF5kibzOlZ0cTj1L+phbVk=
Content-Disposition: inline
In-Reply-To: <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Sergey Shatunov <me-fHUSW+XspFU@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-efi <linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Donovan Tremura <neurognostic-g/b1ySJe57IkP3XJZ0H8fw@public.gmane.org>, Harald Hoyer <harald-PnQE6hpDOpmlVyrhU4qvOw@public.gmane.org>

On Mon, Apr 06, 2020 at 11:11:21AM +0200, Ard Biesheuvel wrote:
> Yes, it is in the PE/COFF specification. [0]
> 
> The whole problem is that we are conflating 'loading a PE/COFF image'
> with 'copying a PE/COFF image into memory', which are not the same
> thing. It is not just the layout issue, we are running into other
> problems with things like UEFI secure boot and TPM-based measured
> boot, where the fact that omitting the standard LoadImage() boot
> service (which takes care of these things under the hood) means that
> you now have to do your own checks and measurements. These things are
> literally all over the place at the moment, shim, GRUB, systemd-boot
> etc, with no authoritative spec that describes which component should
> be doing what.

Sounds to me like what LoadImage() does is what the authoritative spec
should be. Perhaps we should write it down as "Do what LoadImage()
does... " and then enumerate the requirements.

> Commit ec93fc371f014a6fb483e3556061ecad4b40735c has the background, but ...

Nice, I like the aspect of letting firmware do only a minimum amount of
work. :)

> ... I'll look into updating the documentation as well.

Thanks!

> Note that this stuff is hot off the press, so there may be some issues
> lurking (like this one) that we hadn't thought of yet.

Right.

> Actually, it may be sufficient to #define __efistub_global to
> __section(.data) like we already do for ARM, to ensure that these
> global flags are always initialized correctly. (I'll wait for Sergey
> to confirm that the spurious enabling of the PCI DMA protection
> resulting from this BSS issue is causing the boot regression)

Cool, but let's not jinx it. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
