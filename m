From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 02/33] Update dracut manpage for GRUB Legacy and GRUB2
Date: Wed, 26 Nov 2014 13:32:16 +0800
Message-ID: <20141126053216.GE3505@darkstar.nay.redhat.com>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
 <1416495428-36978-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416495428-36978-3-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hare-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Dunn <sfalken-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>

On 11/20/14 at 03:56pm, Thomas Renninger wrote:
> From: Shawn Dunn <sfalken-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
> 
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  dracut.usage.asc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/dracut.usage.asc b/dracut.usage.asc
> index 9e788c1..1a79638 100644
> --- a/dracut.usage.asc
> +++ b/dracut.usage.asc
> @@ -99,9 +99,9 @@ raid with encryption and LVM on top), as long as you specify the correct
>  filesystem LABEL or UUID on the kernel command line for your root device, dracut
>  will find it and boot from it.
>  
> -The kernel command line usually can be configured in _/boot/grub/grub.conf_ or
> -_/boot/grub2/grub.cfg_, if grub is your bootloader and it also can be edited in
> -the real boot process in the grub menu.
> +The kernel command line usually can be configured in _/boot/grub/grub.conf_,
> +for GRUB legacy, or _/boot/grub2/grub.cfg_, for GRUB2 if grub is your
> +bootloader and it also can be edited in the real boot process in the grub menu.

In case you are enhance the documentation, how about add case for uefi boot

>  
>  The kernel command line can also be provided by the dhcp server with the
>  root-path option. See <<NetworkBoot>>.
> -- 
> 1.8.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
