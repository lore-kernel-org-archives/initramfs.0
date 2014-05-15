From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH 2/2] [RFC] Add tegra-drm/host1x case and ARM hostonly support
Date: Thu, 15 May 2014 08:35:13 +0200
Message-ID: <E40DA713-308E-4CC8-8CEF-D0FD9C74F159@dominion.thruhere.net>
References: <1400088897-3258-1-git-send-email-kwizart@gmail.com> <1400088897-3258-2-git-send-email-kwizart@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400088897-3258-2-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Op 14 mei 2014, om 19:34 heeft Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> het volgende geschreven:

> This is a wip version as plymouth still doesn't work for me
> 
> 1/ On arm, aliases use a different path (soc)
> 2/ host1x has the matching device aliases
> whereas tegra_drm has the crt_init symbol
> 3/ Others ARM drivers may behave similarly
> 4/ backlight and pwm_bl also need to be bundled.
> 
> I'm currenly testing with fedora kernel 3.14 or 3.15
> ---
> modules.d/50drm/module-setup.sh | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/50drm/module-setup.sh b/modules.d/50drm/module-setup.sh
> index e25fc9f..c3ca1e4 100755
> --- a/modules.d/50drm/module-setup.sh
> +++ b/modules.d/50drm/module-setup.sh
> @@ -51,14 +51,18 @@ installkernel() {
>         return 0
>     }
> 
> +    # Some modules don't have drm_crtc_init but modalias needed by hostonly detection
> +    local _drm_needed=$(find_kernel_modules_by_path drivers/gpu/{host1x,drm/{i2c,panel})

Unbalanced accolades.

> +
>     for _modname in $(find_kernel_modules_by_path drivers/gpu/drm \
> -        | drm_module_filter) ; do
> +        | drm_module_filter) $_drm_needed ; do
>         # if the hardware is present, include module even if it is not currently loaded,
>         # as we could e.g. be in the installer; nokmsboot boot parameter will disable
>         # loading of the driver if needed
>         if [[ $hostonly ]] && modinfo -F alias $_modname | sed -e 's,\?,\.,g' -e 's,\*,\.\*,g' \
> -            | grep -qxf - /sys/bus/pci/devices/*/modalias 2>/dev/null; then
> +            | grep -qxf - /sys/bus/{pci/devices,soc/devices/soc?}/*/modalias 2>/dev/null; then
>             hostonly='' instmods $_modname
> +            hostonly='' [[ $_modname == host1x ]] && instmods tegra-drm
>             continue
>         fi
>         instmods $_modname
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
