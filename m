From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv2] dracut-lib.sh: bugfix for pidof function
Date: Tue, 28 Jan 2014 15:37:27 +0100
Message-ID: <52E7C0A7.9050100@redhat.com>
References: <E86DFAF410366A40AD1683994061D9D608FE12@CFWEX01.americas.cray.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E86DFAF410366A40AD1683994061D9D608FE12-aOe8g7e11MUSZAcGdq5asVgOPcOSbvolAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Stig Telfer <stelfer-WVYJKLFxKCc@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 01/24/2014 04:48 PM, Stig Telfer wrote:
> In follow-up, the patch requires a second mod: kernel tasks have a /proc/.../exe that links to nothing and derails the for loop:
> 
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index 85f7cdf..05fb1e4 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -967,9 +967,9 @@ if ! command -v pidof >/dev/null 2>/dev/null; then
>          [ -z "$_cmd" ] && return 1
>          _exe=$(type -P "$1")
>          for i in /proc/*/exe; do
> -            [ -e "$i" ] || return 1
> +            [ -e "$i" ] || continue
>              if [ -n "$_exe" ]; then
> -                [ "$i" -ef "$_cmd" ] || continue
> +                [ "$i" -ef "$_exe" ] || continue
>              else
>                  _rl=$(readlink -f "$i");
>                  [ "${_rl%/$_cmd}" != "$_rl" ] || continue
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks! Pushed.
