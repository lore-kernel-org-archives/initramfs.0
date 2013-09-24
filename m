From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: Implement ACPI table overriding via initramfs
Date: Tue, 24 Sep 2013 13:44:16 -0400
Message-ID: <20130924174416.GB14328@phenom.dumpdata.com>
References: <1380042177-66221-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380042177-66221-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Sep 24, 2013 at 07:02:54PM +0200, Thomas Renninger wrote:
> This code generalizes the early_cpio parts of the early microcode
> implementation.
> Then the acpi table overriding parts are added in the last patch.
> 
> Successfully tested.
> 
> Please consider to apply if people agree with the code.

They look good to me (aka Reviewed-by..). Thought I would say
you should also add a patch to document this in the manual and
the docs.


> 
> Thanks,
> 
>         Thomas
> 
> [PATCH 1/3] dracut: Generlize microcode early cpio usage
> [PATCH 2/3] dracut: Do not create early_cpio if no suitable
> [PATCH 3/3] dracut: Implement ACPI table overriding
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
