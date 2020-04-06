From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Date: Mon, 6 Apr 2020 09:22:15 -0400
Message-ID: <20200406132215.GA113388@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan>
 <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan>
 <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic>
 <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
 <20200406112042.GC2520@zn.tnic>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cuhjb+a9vABf0xMYhIXhtlft1e/hgk3xK+XP54N7ens=;
        b=sJzMZufcD34AmiyiMprFJO0RFheJcLI4hyj6FwC+Nj7e0iIU15QOznCGvz5MOFuRQd
         Q3XUDXrjd9vzgPVSQqV2ruw+LDckTqbR5t8UxdpWE6zCqKDPE9SF2rGOYsfW/0qB2K37
         WefY6hCzrEmRb4t+XLEXV/uxe8zsYNA2EBY+ZV88HEusUxVwcXTFz12pS+O2Dmph0Cm7
         Hl3Moy5a+2/FfVnahvtgNTt5p0G/ZT/uMAMCOqwWQgJmKPGRm0W5Yljugi1BJodcp0qi
         ROdXgM7s6DHFfHDe65AAFyRnd6NG+Xve6w8kggsG2lbjj0YoC/tHLXsKAt5krgcDa16l
         53AQ==
Content-Disposition: inline
In-Reply-To: <20200406112042.GC2520@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Sergey Shatunov <me@prok.pw>, hpa@zytor.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>, initramfs@vger.kernel.org, Donovan Tremura <neurognostic@protonmail.ch>, Harald Hoyer <harald@hoyer.xyz>

On Mon, Apr 06, 2020 at 01:20:42PM +0200, Borislav Petkov wrote:
> On Mon, Apr 06, 2020 at 11:11:21AM +0200, Ard Biesheuvel wrote:
> > Yes, it is in the PE/COFF specification. [0]
> > 
> > The whole problem is that we are conflating 'loading a PE/COFF image'
> > with 'copying a PE/COFF image into memory', which are not the same
> > thing. It is not just the layout issue, we are running into other
> > problems with things like UEFI secure boot and TPM-based measured
> > boot, where the fact that omitting the standard LoadImage() boot
> > service (which takes care of these things under the hood) means that
> > you now have to do your own checks and measurements. These things are
> > literally all over the place at the moment, shim, GRUB, systemd-boot
> > etc, with no authoritative spec that describes which component should
> > be doing what.
> 
> Sounds to me like what LoadImage() does is what the authoritative spec
> should be. Perhaps we should write it down as "Do what LoadImage()
> does... " and then enumerate the requirements.
> 
> > Commit ec93fc371f014a6fb483e3556061ecad4b40735c has the background, but ...
> 
> Nice, I like the aspect of letting firmware do only a minimum amount of
> work. :)
> 
> > ... I'll look into updating the documentation as well.
> 
> Thanks!
> 
> > Note that this stuff is hot off the press, so there may be some issues
> > lurking (like this one) that we hadn't thought of yet.
> 
> Right.
> 
> > Actually, it may be sufficient to #define __efistub_global to
> > __section(.data) like we already do for ARM, to ensure that these
> > global flags are always initialized correctly. (I'll wait for Sergey
> > to confirm that the spurious enabling of the PCI DMA protection
> > resulting from this BSS issue is causing the boot regression)

Yeah I thought of that as the easiest fix, but it might be safer to
explicitly zero-init in efi_main to avoid future problems in case
someone adds another variable in bss and isn't aware of this obscure
requirement. We actually already have sys_table in bss, but that one is
always initialized. There's also other globals that aren't annotated
(but not in bss by virtue of having initializers). What do you think?

What do you think of the other problem -- that's actually worse to fix,
as it won't just be when kaslr is disabled, the startup_64 code will do
relocation to the end of init_size and clobber the initrd before getting
to the kaslr code, so it will break as soon as the firmware loads the
"unified kernel image" at a 2Mb-aligned address. The only thing I can
think of is to just unconditionally call efi_relocate_kernel if we were
entered via handover_entry?

> 
> Cool, but let's not jinx it. :-)
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
