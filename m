From: Daniel Kiper <daniel.kiper-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
Date: Tue, 14 Apr 2020 16:57:01 +0200
Message-ID: <20200414145701.p5ifnnimmuzgfqfh@tomti.i.net-space.pl>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu>
 <20200408074334.GA21886@dhcp-128-65.nay.redhat.com>
 <CAMj1kXGPOZ6zWtgGScLy0ECrTtf1yhngDTNE1chW-MQw3XQp9Q@mail.gmail.com>
 <20200409143910.GA727557@rani.riverdale.lan>
 <CAMj1kXEm=E6B+kjZktG=sBPLQ=_HFfUz6KFLskNGzRnuMjn0gA@mail.gmail.com>
 <20200409163530.GA785575@rani.riverdale.lan>
 <20200410144758.GC936997@rani.riverdale.lan>
 <CAMj1kXHMQgnmdoA+qKLGa=gYg4J2p-DU3-K1LiM=AT61pi+Fvw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=b2jGMBSv5VYKK0ycmsBoTfvINxl10Rp8bqgANURivvc=;
 b=qx7Bq6xaDh/gt8p9w5Ak7EornJUpICn9xM5fA/BuKQelxzbHP8dCd8vdTARhWmdDr5Ik
 Zh4qispLg81l1IeMtGBXPwKWtCo1Qq8gF265hMmpqlr9uZcLagztJhh9qbPY6jWPc15V
 ihPR7urHZSMgqrBj9K2saoP6j84U/K1VfVO1BOGcRlcgGjwMS0LkBbiD7JTG9Q11raFn
 Qq3IDO2kGF/YbLIj5lRJMthrCri4CL6pEvzB4t528B9crb0n0mgksYqfTobKM3YP6Khy
 1atLPanPkT11yHEC3T1DsFe6T6JJon//dCy5jGQ1PTS27ifSC86wIc1qz3ThTlr+3Qkx 2A== 
Content-Disposition: inline
In-Reply-To: <CAMj1kXHMQgnmdoA+qKLGa=gYg4J2p-DU3-K1LiM=AT61pi+Fvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Leif Lindholm <leif-e2DmVA6dwcVWk0Htik3J/w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Sergey Shatunov <me-fHUSW+XspFU@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, X86 ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-efi <linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Donovan Tremura <neurognostic-g/b1ySJe57IkP3XJZ0H8fw@public.gmane.org>, Harald Hoyer <harald-PnQE6hpDOpmlVyrhU4qvOw@public.gmane.org>

On Fri, Apr 10, 2020 at 05:26:34PM +0200, Ard Biesheuvel wrote:
> On Fri, 10 Apr 2020 at 16:48, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org> wrote:
> > On Thu, Apr 09, 2020 at 12:35:30PM -0400, Arvind Sankar wrote:
> > > On Thu, Apr 09, 2020 at 04:47:55PM +0200, Ard Biesheuvel wrote:
> > > > On Thu, 9 Apr 2020 at 16:39, Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org> wrote:
> > > > >
> > > > > On Wed, Apr 08, 2020 at 09:49:15AM +0200, Ard Biesheuvel wrote:
> > > > > > (add Peter, Leif and Daniel)
> > > > > >
> > > > > > On Wed, 8 Apr 2020 at 09:43, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > > > > >
> > > > > > > On 04/06/20 at 02:06pm, Arvind Sankar wrote:
> > > > > > > > Commit
> > > > > > > >
> > > > > > > >   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
> > > > > > > >   bzImage")
> > > > > > > >
> > > > > > > > removed the .bss section from the bzImage.
> > > > > > > >
> > > > > > > > However, while a PE loader is required to zero-initialize the .bss
> > > > > > > > section before calling the PE entry point, the EFI handover protocol
> > > > > > > > does not currently document any requirement that .bss be initialized by
> > > > > > > > the bootloader prior to calling the handover entry.
> > > > > > > >
> > > > > > > > When systemd-boot is used to boot a unified kernel image [1], the image
> > > > > > > > is constructed by embedding the bzImage as a .linux section in a PE
> > > > > > > > executable that contains a small stub loader from systemd together with
> > > > > > > > additional sections and potentially an initrd. As the .bss section
> > > > > > > > within the bzImage is no longer explicitly present as part of the file,
> > > > > > > > it is not initialized before calling the EFI handover entry.
> > > > > > > > Furthermore, as the size of the embedded .linux section is only the size
> > > > > > > > of the bzImage file itself, the .bss section's memory may not even have
> > > > > > > > been allocated.
> > > > > > >
> > > > > > > I did not follow up the old report, maybe I missed something. But not
> > > > > > > sure why only systemd-boot is mentioned here.  I also have similar issue
> > > > > > > with early efi failure.  With these two patches applied, it works well
> > > > > > > then.
> > > > > > >
> > > > > > > BTW, I use Fedora 31 + Grub2
> > > > > > >
> > > > > >
> > > > > > OK, so I take it this means that GRUB's PE/COFF loader does not
> > > > > > zero-initialize BSS either? Does it honor the image size in memory if
> > > > > > it exceeds the file size?
> > > > >
> > > > > Dave, that comment was because the previous report was for systemd-boot
> > > > > stub.
> > > > >
> > > > > Ard, should I revise the commit message to make it clear it's not
> > > > > restricted to systemd-boot but anything using handover entry may be
> > > > > affected? Maybe just a "for example, when systemd-boot..." and then a
> > > > > line to say grub2 with the EFI stub patches is also impacted?
> > > > >
> > > >
> > > > Well, the fact the /some/ piece of software is used in production that
> > > > relies on the ill-defined EFI handover protocol is sufficient
> > > > justification, so I don't think it is hugely important to update it.
> > > >
> > > > > https://src.fedoraproject.org/rpms/grub2/blob/f31/f/0001-Add-support-for-Linux-EFI-stub-loading.patch#_743
> > > > >
> > > > > +  kernel_mem = grub_efi_allocate_pages_max(lh.pref_address,
> > > > > +                                          BYTES_TO_PAGES(lh.init_size));
> > > > >
> > > > > Looking at this, grub does allocate init_size for the image, but it
> > > > > doesn't zero it out.
> > > > >
> > > > > This call also looks wrong to me though. It allocates at max address of
> > > > > pref_address, which, if it succeeds, will guarantee that the kernel gets
> > > > > loaded entirely below pref_address == LOAD_PHYSICAL_ADDR. In native
> > > > > mode, if it weren't for the EFI stub copying the kernel again, this
> > > > > would cause the startup code to relocate the kernel into unallocated
> > > > > memory. On a mixed-mode boot, this would cause the early page tables
> > > > > setup prior to transitioning to 64-bit mode to be in unallocated memory
> > > > > and potentially get clobbered by the EFI stub.
> > > > >
> > > > > The first try to allocate pref_address should be calling
> > > > > grub_efi_allocate_fixed instead.
> > > >
> > > > Thanks Arvind. I'm sure the Fedora/RedHat folks on cc should be able
> > > > to get these logged somewhere.
> > >
> > > Ok. For dracut, the process for building the unified kernel image needs
> > > a check to make sure the kernel can fit in the space provided for it --
> > > there is 16MiB of space and the distro bzImage's are up to 10-11MiB in
> > > size, so there's some slack left at present.
> > >
> > > Additionally, in mixed-mode, the unified kernel images are quite likely
> > > to end up with early pgtables from startup_32 clobbering the initrd,
> > > independently of the recent kernel changes. Hopefully no-one actually
> > > uses these in mixed-mode.
> >
> > The grub EFI handover entry patch is busted in mixed-mode for another
> > reason -- while it allocates init_size, it doesn't use the correct
> > alignment. I tested on a Debian buster VM in mixed-mode (that was the
> > one I was able to get to install/boot with mixed-mode), and the early
> > pagetable from startup_32 ends up in unallocated memory due to the
> > rounding up of the bzImage address to account for kernel alignment. This
> > would be an existing problem prior to these patches.
> >
> > Should we try to handle this in the kernel? At some point KASLR is going
> > to pick that memory for the kernel and overwrite the pagetables I would
> > think, resulting in sporadic crashes that are almost unreproducible.
>
> Upstream GRUB does not implement the EFI handover protocol at all, and
> the distros all have their own GRUB forks that implement this along
> with mixed mode, secure boot, shim, measured boot etc.

Exactly...

> What you are saying is that GRUB forks turn out to exist that violate
> both the PE/COFF specification and the Linux/x86 boot protocol in a
> way that might break mixed mode, and nobody noticed until you happened
> to find it by code inspection. While I appreciate the effort, I think
> this is where I would like to draw the line, and say that there is
> only so much we can do to work around bugs in out-of-tree forks of
> other projects. So unless it can be done cleanly and without losing
> any of the benefits of the recent cleanup and optimization work, I'd
> say don't bother.

I fully agree!

Daniel
