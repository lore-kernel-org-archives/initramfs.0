From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ARM: update modules for ARM host only options
Date: Tue, 22 Jul 2014 14:29:45 +0200
Message-ID: <53CE5939.3000801@redhat.com>
References: <1405891204-12001-1-git-send-email-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405891204-12001-1-git-send-email-pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 20.07.2014 23:20, Peter Robinson wrote:
> ---
>  modules.d/90kernel-modules/module-setup.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
> index cc79b88..1ce133f 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -51,9 +51,10 @@ installkernel() {
>  
>          if [[ "$(uname -p)" == arm* ]]; then
>              # arm specific modules
> -            hostonly='' instmods omapdrm panel-tfp410
> -            instmods i2c-tegra gpio-regulator as3722-regulator \
> -                    phy-tegra-usb ehci-tegra sdhci-tegra
> +            hostonly='' instmods \
> +	        connector-hdmi connector-dvi encoder-tfp410 \
> +	        encoder-tpd12s015 i2c-tegra gpio-regulator \
> +		as3722-regulator orion-ehci ehci-tegra 
>          fi
>  
>          # install virtual machine support
> 

Thanks! Pushed
