From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Date: Mon, 6 Apr 2020 19:21:02 +0200
Message-ID: <20200406172102.GF2520@zn.tnic>
References: <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan>
 <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan>
 <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic>
 <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
 <20200406112042.GC2520@zn.tnic>
 <20200406132215.GA113388@rani.riverdale.lan>
 <CAMj1kXG+34-bK1XuxX5VopkRt1SV1ewUAEmif+aQj5cJQ=9vbA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586193667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SvlsLYjk7+N+Zi3Q2er0ZEj5L9OiCRt8VPcz7ScDZKE=;
        b=mfypNZvvlyY+r+up9ukE9DGjblAgXh2d30KFKbtusE5t1QOSN8uHnxvS6f0NExmxrAj7cY
        fdeOi/I5GNxEg2h/n4TBzcJe6muphSe662lGoK7/wC8xUyqebdUuwvzbX+Rrr5M+l+aDVs
        2RkQ8rhtcnNd25eNI8HzVWqZeQV98ts=
Content-Disposition: inline
In-Reply-To: <CAMj1kXG+34-bK1XuxX5VopkRt1SV1ewUAEmif+aQj5cJQ=9vbA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
Cc: Sergey Shatunov <me-fHUSW+XspFU@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-efi <linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Donovan Tremura <neurognostic-g/b1ySJe57IkP3XJZ0H8fw@public.gmane.org>, Harald Hoyer <harald-PnQE6hpDOpmlVyrhU4qvOw@public.gmane.org>

On Mon, Apr 06, 2020 at 03:29:18PM +0200, Ard Biesheuvel wrote:
> > What do you think of the other problem -- that's actually worse to fix,
> > as it won't just be when kaslr is disabled, the startup_64 code will do
> > relocation to the end of init_size and clobber the initrd before getting
> > to the kaslr code, so it will break as soon as the firmware loads the
> > "unified kernel image" at a 2Mb-aligned address. The only thing I can
> > think of is to just unconditionally call efi_relocate_kernel if we were
> > entered via handover_entry?
> >
> 
> Yes, that seems to be the most robust approach.

The commit in question is this one:

d5cdf4cfeac9 ("efi/x86: Don't relocate the kernel unless necessary")

I presume?

I'm guessing it can simply be reverted as it doesn't fix a bug but it is
just an optimization... provided I'm not missing something, of course.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
