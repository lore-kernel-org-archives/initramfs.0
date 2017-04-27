From: Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] arm64: mmc drivers
Date: Wed, 26 Apr 2017 22:12:30 -0500
Message-ID: <CAEFTgiwuMftYLJbyCXJLt3y=GjQRC1H0BjksngLugGggHGJOwg@mail.gmail.com>
References: <20170427025929.10982-1-lintonrjeremy@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=0qYtnm2v+WtFd/lidi0Ih5odPkoKkLi28AFnPAX6ERc=;
        b=ISL7G9fR5qZgR7xNsl/9ElIBJbR4vwqMhcnh9Sc6HvX+ULwTRnTmLiqpR46LAxtQfy
         0pIJP8MfaSfW4qrFiO4XuTvl/KNi2dEg9l2fU6i+X6T+4xVvg4AZjqUJ9xP1IbYX2vyY
         3sJpdgBtfRaAU3bWmAsbZrr2tkEwKOQ+CmykUrm93D8FeJPMh3tSX3364BdepM3ZIaZO
         IZmMfGfZMZy59V4JmkqvVbw4ga3JAGQOCQTb78rvGCjVDAsPfvcxs8fBhiJsPCxqWZIm
         Pt3/twkDhyuyb4jIBGjz5mO2PaPAnexnchtuwzGONwnX/cQS5lG9NsgTsMNVJIbCx2a3
         Ydgg==
In-Reply-To: <20170427025929.10982-1-lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

Having messed with this for the past couple hours, I'm not convinced
this solution is any better than the previous patch. What is basically
happening is that dw_mmc is utilizing mmc_add_host, which pulls it
into the initrd, but it has "dependencies" on other drivers
registering dw_mc_probe routines before it will register a mmc host.
The platform driver registers a dw_mmc_probe routine, but not before
the k3 driver registers via pltfm_register. Since the dw_mmc_k3 driver
get triggered via its OF/DT device description, it pulls in  the rest
of the stack in order to resolve all the missing symbols. So, maybe
the dw_mmc driver needs to be more monolithic, but good luck with
that...

So, in the end I think the previous version might be a more generic solution..



On Wed, Apr 26, 2017 at 9:59 PM, Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> It is common for arm64 devices to boot from mmc & sd devices
> we need to assure that those drivers make it to the initrd.
>
> Signed-off-by: Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  modules.d/90kernel-modules/module-setup.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
> index b1bced69..863ce932 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -25,10 +25,12 @@ installkernel() {
>
>         if [[ "$(uname -m)" == arm* || "$(uname -m)" == aarch64 ]]; then
>              # arm/aarch64 specific modules
> +            _blockfuncs+='|dw_mc_probe|dw_mci_pltfm_register'
>              instmods \
>                  "=drivers/clk" \
>                  "=drivers/dma" \
>                  "=drivers/i2c/busses" \
> +                "=drivers/mfd" \
>                  "=drivers/phy" \
>                  "=drivers/power" \
>                  "=drivers/regulator" \
> --
> 2.12.2
>
