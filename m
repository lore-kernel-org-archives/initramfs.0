From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Implement ACPI table overriding via initramfs
Date: Wed, 02 Oct 2013 12:58:11 +0200
Message-ID: <524BFC43.6070205@redhat.com>
References: <1380042177-66221-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380042177-66221-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/24/2013 07:02 PM, Thomas Renninger wrote:
> This code generalizes the early_cpio parts of the early microcode
> implementation.
> Then the acpi table overriding parts are added in the last patch.
> 
> Successfully tested.
> 
> Please consider to apply if people agree with the code.
> 
> Thanks,
> 
>         Thomas
> 
> [PATCH 1/3] dracut: Generlize microcode early cpio usage
> [PATCH 2/3] dracut: Do not create early_cpio if no suitable
> [PATCH 3/3] dracut: Implement ACPI table overriding
> 

pushed! Thanks!
