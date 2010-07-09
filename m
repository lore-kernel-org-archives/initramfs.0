From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] dracut-functions: info which udev rules are skipped
Date: Fri, 09 Jul 2010 15:48:44 +0200
Message-ID: <4C3728BC.6070107@redhat.com>
References: <20100705090647.30b3c2bc@etiriah> <20100705090847.4a2bcc7e@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100705090847.4a2bcc7e@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1254"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/05/2010 09:08 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> I found it useful.  Maybe help others debugging.
> ---
>   dracut-functions |    5 +++--
>   1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/dracut-functions b/dracut-functions
> index 9c2999a..0caf0d6 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -335,8 +335,9 @@ inst_rules() {
>       inst_dir "/lib/udev/rules.d"
>       inst_dir "$target"
>       for rule in "$@"; do
> -	rule=3D$(find_rule "$rule")&&  \
> -	    inst_simple "$rule" "$target/${rule##*/}"
> +	rule1=3D$(find_rule "$rule")&&  \
> +	    inst_simple "$rule1" "$target/${rule1##*/}" \
> +	    || dinfo "Skipping udev rule: $rule"
>       done
>   }
>

pushed
