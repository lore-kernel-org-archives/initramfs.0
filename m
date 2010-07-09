From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-functions: cosmetic changes to inst_rules
Date: Fri, 09 Jul 2010 15:48:05 +0200
Message-ID: <4C372895.8030208@redhat.com>
References: <20100705112521.37ec8c65@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100705112521.37ec8c65@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/05/2010 11:25 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> ---
>   dracut-functions |    9 +++++----
>   1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/dracut-functions b/dracut-functions
> index 0caf0d6..be6b2e9 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -331,13 +331,14 @@ find_rule() {
>   # udev rules always get installed in the same place, so
>   # create a function to install them to make life simpler.
>   inst_rules() {
> -    local target=3D/etc/udev/rules.d
> +    local target=3D/etc/udev/rules.d rule found
> +
>       inst_dir "/lib/udev/rules.d"
>       inst_dir "$target"
>       for rule in "$@"; do
> -	rule1=3D$(find_rule "$rule")&&  \
> -	    inst_simple "$rule1" "$target/${rule1##*/}" \
> -	    || dinfo "Skipping udev rule: $rule"
> +        found=3D$(find_rule "$rule")&&  \
> +            inst_simple "$found" "$target/${found##*/}" \
> +            || dinfo "Skipping udev rule: $rule"
>       done
>   }
>
pushed
