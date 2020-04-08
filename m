From: Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
Date: Wed, 8 Apr 2020 09:49:15 +0200
Message-ID: <CAMj1kXGPOZ6zWtgGScLy0ECrTtf1yhngDTNE1chW-MQw3XQp9Q@mail.gmail.com>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu> <20200408074334.GA21886@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586332167;
        bh=LFSPRKgmR8auwK03bWcZlzXa6g+J6cxGqFZeIyDLWBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M4A3XfdLzGoCqjFphZs46oHKHPvNRNyaxBpA9xZOfsoCACHV49gh3cMPEQj0HjuuH
         K5KQp0P7ZX1Za5RsThorpN36rb8kGaUgiaq32dYWGNm/PIEGD7Xe4ymWpTMGYbdsuu
         gSRBrZ2r52eMPpBPRm9gCBQCDV5PL1qvhKb/3sxc=
In-Reply-To: <20200408074334.GA21886-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, daniel.kiper-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Leif Lindholm <leif-e2DmVA6dwcVWk0Htik3J/w@public.gmane.org>
Cc: Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Sergey Shatunov <me-fHUSW+XspFU@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-efi <linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Donovan Tremura <neurognostic-g/b1ySJe57IkP3XJZ0H8fw@public.gmane.org>, Harald Hoyer <harald-PnQE6hpDOpmlVyrhU4qvOw@public.gmane.org>

(add Peter, Leif and Daniel)

On Wed, 8 Apr 2020 at 09:43, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> On 04/06/20 at 02:06pm, Arvind Sankar wrote:
> > Commit
> >
> >   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
> >   bzImage")
> >
> > removed the .bss section from the bzImage.
> >
> > However, while a PE loader is required to zero-initialize the .bss
> > section before calling the PE entry point, the EFI handover protocol
> > does not currently document any requirement that .bss be initialized by
> > the bootloader prior to calling the handover entry.
> >
> > When systemd-boot is used to boot a unified kernel image [1], the image
> > is constructed by embedding the bzImage as a .linux section in a PE
> > executable that contains a small stub loader from systemd together with
> > additional sections and potentially an initrd. As the .bss section
> > within the bzImage is no longer explicitly present as part of the file,
> > it is not initialized before calling the EFI handover entry.
> > Furthermore, as the size of the embedded .linux section is only the size
> > of the bzImage file itself, the .bss section's memory may not even have
> > been allocated.
>
> I did not follow up the old report, maybe I missed something. But not
> sure why only systemd-boot is mentioned here.  I also have similar issue
> with early efi failure.  With these two patches applied, it works well
> then.
>
> BTW, I use Fedora 31 + Grub2
>

OK, so I take it this means that GRUB's PE/COFF loader does not
zero-initialize BSS either? Does it honor the image size in memory if
it exceeds the file size?
