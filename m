From: Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
Date: Mon, 6 Apr 2020 11:11:21 +0200
Message-ID: <CAMj1kXHAieZDvPKfjF=J+G=QVS+=XS-b4RP_=mjCEFEB_E_+Qw@mail.gmail.com>
References: <20200109150218.16544-1-nivedita@alum.mit.edu> <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan> <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
 <20200406035110.GA3241052@rani.riverdale.lan> <CAMj1kXEUhyv886CjyKvjw2F12WaZxZRUWF6t_XzP4C2TJPdpeg@mail.gmail.com>
 <20200406084738.GA2520@zn.tnic>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586164293;
        bh=IEKnLroPOXhZZoEjwk2Sy7qHL1p/3PpX8cAZjySktEg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x9/XnaHxSYASdAnWEA1KJzzEgemj3vDGBjEXM3ZS/mXiYMEt9DQ0mPtb0MiA+/29Y
         +kCeLxo9TBIfyZSeU3y51QeFqzPHoFJwv+7AsMuW4PnVgUifoqVMoKIWZOPhq55kOi
         pVVdq0uKWDmwPU73ZYVXd9jmL6nD/cuzCdeXqVa8=
In-Reply-To: <20200406084738.GA2520-Jj63ApZU6fQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Sergey Shatunov <me-fHUSW+XspFU@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-efi <linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Donovan Tremura <neurognostic-g/b1ySJe57IkP3XJZ0H8fw@public.gmane.org>, Harald Hoyer <harald-PnQE6hpDOpmlVyrhU4qvOw@public.gmane.org>

On Mon, 6 Apr 2020 at 10:47, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org> wrote:
>
> On Mon, Apr 06, 2020 at 09:32:47AM +0200, Ard Biesheuvel wrote:
> > The EFI handover protocol strikes again :-(
> >
> > It seems we did not include any guidance in the documentation in
> > Documentation/x86/boot.rst regarding zero-initializing BSS, and come
> > to think of it, we don't include any other requirements either, i.e.,
> > regarding placement wrt section alignment etc. This is a serious bug.
> > Even though EFI usually lays out PE/COFF images in files the exact way
> > they appear in memory, this is not actually required by the spec. Most
> > notably, the virtual size can be smaller than the file size, and the
> > loader is expected to zero-initialize the difference as well.
>
> Is that expectation stated explicitly somewhere?
>

Yes, it is in the PE/COFF specification. [0]

The whole problem is that we are conflating 'loading a PE/COFF image'
with 'copying a PE/COFF image into memory', which are not the same
thing. It is not just the layout issue, we are running into other
problems with things like UEFI secure boot and TPM-based measured
boot, where the fact that omitting the standard LoadImage() boot
service (which takes care of these things under the hood) means that
you now have to do your own checks and measurements. These things are
literally all over the place at the moment, shim, GRUB, systemd-boot
etc, with no authoritative spec that describes which component should
be doing what.

> > Since the EFI handover protocol should be considered deprecated at
> > this point (and is never going to be supported in upstream GRUB
> > either, for instance), I would recommend the systemd-boot developers
> > to start looking into deprecating this as well, and switch to the
> > ordinary PE/COFF entry point, and use the new initrd callback protocol
> > for initrd loading.
>
> Any pointers to that new initrd callback protocol?
>

Commit ec93fc371f014a6fb483e3556061ecad4b40735c has the background, but ...

> In any case, I'd really appreciate a patch to boot.rst formulating those
> requirements so that they're written down and people can find them.
>

... I'll look into updating the documentation as well. Note that this
stuff is hot off the press, so there may be some issues lurking (like
this one) that we hadn't thought of yet.

OVMF and u-boot already have implementations of this initrd loading
approach. A GRUB version is under discussion.

> > On the Linux/x86 side, we should at least add some code to the EFI
> > handover protocol entry point to zero initialize BSS, and ensure that
> > it is either not needed in other places, or add the code to deal with
> > those as well.
>
> Sounds like a simple fix, if that would fix it.
>

Actually, it may be sufficient to #define __efistub_global to
__section(.data) like we already do for ARM, to ensure that these
global flags are always initialized correctly. (I'll wait for Sergey
to confirm that the spurious enabling of the PCI DMA protection
resulting from this BSS issue is causing the boot regression)



[0] https://docs.microsoft.com/en-us/windows/win32/debug/pe-format
