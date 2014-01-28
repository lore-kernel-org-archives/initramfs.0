From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-lib.sh: bugfix for pidof function
Date: Tue, 28 Jan 2014 15:37:12 +0100
Message-ID: <52E7C098.5050502@redhat.com>
References: <E86DFAF410366A40AD1683994061D9D608FDCB@CFWEX01.americas.cray.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E86DFAF410366A40AD1683994061D9D608FDCB-aOe8g7e11MUSZAcGdq5asVgOPcOSbvolAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Stig Telfer <stelfer-WVYJKLFxKCc@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 01/24/2014 04:19 PM, Stig Telfer wrote:
> It appears there is a simple substitution error in the pidof shell function which causes it to fail to find processes.  In my case, processes started by 95nfs are not terminated in the cleanup hook.  This causes knock-on effects disturbing the root filesystem service dependencies. 
> 
> Enjoy,
> Stig Telfer
> 
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index 85f7cdf..3f10bc1 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -969,7 +969,7 @@ if ! command -v pidof >/dev/null 2>/dev/null; then
>          for i in /proc/*/exe; do
>              [ -e "$i" ] || return 1
>              if [ -n "$_exe" ]; then
> -                [ "$i" -ef "$_cmd" ] || continue
> +                [ "$i" -ef "$_exe" ] || continue
>              else
>                  _rl=$(readlink -f "$i");
>                  [ "${_rl%/$_cmd}" != "$_rl" ] || continue
> 
> 

Thanks! Pushed.
