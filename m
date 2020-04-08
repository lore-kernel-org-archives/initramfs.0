From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
Date: Wed, 8 Apr 2020 15:43:34 +0800
Message-ID: <20200408074334.GA21886@dhcp-128-65.nay.redhat.com>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586331831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cA+LU9MO2IhF0ttoEQMdBEQPoe9aDl0ajatYj/omepg=;
        b=HtH9F7RFAT/c417X4mfi42GaO7T6D+7bhApsciJvecCNmZ5oOGXz7/6TSS5iXSSRy/T2Xl
        Gl/apum64VEfJdVanuObZLuZhAgHkKrKvbcL2BINdrjamj/4LNDW6coehzkwlIzfDyWFnZ
        2LRsc7CaWYEnTc3i1NsliBrLg6T6/HI=
Content-Disposition: inline
In-Reply-To: <20200406180614.429454-1-nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
Cc: Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Sergey Shatunov <me-fHUSW+XspFU@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-efi <linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Donovan Tremura <neurognostic-g/b1ySJe57IkP3XJZ0H8fw@public.gmane.org>, Harald Hoyer <harald-PnQE6hpDOpmlVyrhU4qvOw@public.gmane.org>

On 04/06/20 at 02:06pm, Arvind Sankar wrote:
> Commit
> 
>   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
>   bzImage")
> 
> removed the .bss section from the bzImage.
> 
> However, while a PE loader is required to zero-initialize the .bss
> section before calling the PE entry point, the EFI handover protocol
> does not currently document any requirement that .bss be initialized by
> the bootloader prior to calling the handover entry.
> 
> When systemd-boot is used to boot a unified kernel image [1], the image
> is constructed by embedding the bzImage as a .linux section in a PE
> executable that contains a small stub loader from systemd together with
> additional sections and potentially an initrd. As the .bss section
> within the bzImage is no longer explicitly present as part of the file,
> it is not initialized before calling the EFI handover entry.
> Furthermore, as the size of the embedded .linux section is only the size
> of the bzImage file itself, the .bss section's memory may not even have
> been allocated.

I did not follow up the old report, maybe I missed something. But not
sure why only systemd-boot is mentioned here.  I also have similar issue
with early efi failure.  With these two patches applied, it works well
then.

BTW, I use Fedora 31 + Grub2

> 
> In particular, this can result in efi_disable_pci_dma being true even
> when it was not specified via the command line or configuration option,
> which in turn causes crashes while booting on some systems.
> 
> To avoid issues, place all EFI stub global variables into the .data
> section instead of .bss. As of this writing, only boolean flags for a
> few command line arguments and the sys_table pointer were in .bss and
> will now move into the .data section.
> 
> [1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images
> 
> Signed-off-by: Arvind Sankar <nivedita-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
> Reported-by: Sergey Shatunov <me-fHUSW+XspFU@public.gmane.org>
> Fixes: 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
> ---
>  drivers/firmware/efi/libstub/efistub.h  | 2 +-
>  drivers/firmware/efi/libstub/x86-stub.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index cc90a748bcf0..67d26949fd26 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -25,7 +25,7 @@
>  #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
>  #endif
>  
> -#ifdef CONFIG_ARM
> +#if defined(CONFIG_ARM) || defined(CONFIG_X86)
>  #define __efistub_global	__section(.data)
>  #else
>  #define __efistub_global
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 8d3a707789de..e7af6d2eddbf 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -20,7 +20,7 @@
>  /* Maximum physical address for 64-bit kernel with 4-level paging */
>  #define MAXMEM_X86_64_4LEVEL (1ull << 46)
>  
> -static efi_system_table_t *sys_table;
> +static efi_system_table_t *sys_table __efistub_global;
>  extern const bool efi_is64;
>  extern u32 image_offset;
>  
> -- 
> 2.24.1
> 

Thanks
Dave

