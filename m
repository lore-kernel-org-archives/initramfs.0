From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
Date: Mon, 6 Apr 2020 18:59:36 +0200
Message-ID: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
References: <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan> <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic> <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
 <20200406112042.GC2520@zn.tnic> <20200406132215.GA113388@rani.riverdale.lan>
 <CAMj1kXG+34-bK1XuxX5VopkRt1SV1ewUAEmif+aQj5cJQ=9vbA@mail.gmail.com>
 <20200406160148.GB113388@rani.riverdale.lan> <CAMj1kXFKDWB9n0kWhXHLH0XP0O1v_0b=bFJad=kBvx2qVxqDcQ@mail.gmail.com>
 <20200406165243.GA303819@rani.riverdale.lan>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586192388;
        bh=BvXBikF5zktNf7QS73awek+bnt1KyWnIJgoxiHrD7qg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bvojjPgqEM28uYRBkGHErCClmCMsQ2DiE+7Pi978RWpcDGKOVIrwVbaYQnnmWQJZ8
         dnDWvM7McPg2QPRxpWyQ5OArkZ93zjd5mH7FNw4uKhTsIrpgRtvQXtPE3T2Gt9Pf9k
         a3AG6dqPpdZOyilBFQm1l+RGnL+1tLbn0SOHNFlU=
In-Reply-To: <20200406165243.GA303819@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>, hpa@zytor.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>, initramfs@vger.kernel.org, Donovan Tremura <neurognostic@protonmail.ch>, Harald Hoyer <harald@hoyer.xyz>

On Mon, 6 Apr 2020 at 18:52, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Apr 06, 2020 at 06:22:33PM +0200, Ard Biesheuvel wrote:
> >
> > > We could just pull the stub's bss section all into data with objcopy
> > > similar to what ARM64 does [1]? i.e. rename .bss to .bss.efistub and
> > > then pull that into .data in the linker script for the compressed
> > > kernel?
> > >
> >
> > I don't follow. I'm not aware of arm64 doing anything out of the
> > ordinary with .bss? Note that arm64 does not have a separate
> > decompressor, so the EFI stub is part of the kernel proper. This is
> > why sections are renamed to start with .init
>
> ARM64 renames the stub sections prefixing them with .init, and that
> includes .bss. The ARM64 linker script then puts .init.bss into the
> .init.data section. So I was suggesting doing something similar with the
> x86 stub, renaming .bss to .bss.efistub, and then putting that into
> .data via linker script.
>

OK, I see what you mean now. IIRC, putting that into .init.data was
simply because there was no way to selectively prefix sections, and
leave .bss alone.

But I guess we can combine all these different histories and
rationales into one coherent way of managing the stub's .bss.


> Anyway, I'll do the section annotation for now as that will be less
> churn and we can revisit this after that.
>
> >
> > > There is also this scary looking comment in gnu-efi's linker script:
> > >         /* the EFI loader doesn't seem to like a .bss section, so we stick
> > >            it all into .data: */
> > > I don't know what the history of that is.
> > >
> >
> > I don't remember, to be honest, but I'm pretty sure I copy-pasted that
> > from elsewhere at the time.
> >
> > > [1] As an aside, why doesn't ARM do this as well rather than using the
> > > section(.data) annotation?
> > >
> >
> > The ARM decompressor has this hideous hack, where text [and rodata]
> > executes straight from flash, and BSS is relocated into DRAM. In order
> > for this to work, it actually *requires* GOT indirections for BSS
> > items, to ensure that all BSS references use absolute addresses, which
> > can be relocated independently from the rest of the kernel image. This
> > is the reason ARM does not permit a .data section in the decompressor.
> > However, the EFI stub does not support execute in place from flash,
> > and so we can permit a .data section there. At the same time, we don't
> > support GOT indirections in the EFI stub, so we cannot use the BSS
> > section. So instead, we just put the few BSS pieces we have into .data
> > instead.
> >
>
> I see, thanks.
