From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: 90kernel-modules/module-setup.sh: add ehci-tegra.ko
 on arm
Date: Wed, 31 Jul 2013 16:02:54 +0200
Message-ID: <51F9190E.6090402@redhat.com>
References: <20130724020704.GK2034@redacted.bos.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130724020704.GK2034-nxOev/eQj6CGu0OVIAPS5KfLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kyle McMartin <kyle-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/24/2013 04:07 AM, Kyle McMartin wrote:
> kernel-tegra is now part of the base kernel package, so bits and pieces
> ended up modular, and as a result, if you boot off the internal USB, you
> drop to a dracut shell with no way of getting to root.
> 
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -47,7 +47,8 @@ installkernel() {
>          if [[ "$(uname -p)" == arm* ]]; then
>              # arm specific modules
>              hostonly='' instmods sdhci_esdhc_imx mmci sdhci_tegra mvsdio omap omapdrm \
> -                omap_hsmmc panel-tfp410 sdhci_dove ahci_platform pata_imx sata_mv
> +                omap_hsmmc panel-tfp410 sdhci_dove ahci_platform pata_imx sata_mv \
> +                ehci-tegra
>          fi
>  
>          # install virtual machine support


pushed, thanks!
