From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] resume/module-setup.sh: filter out empty resume= options
 in cmdline()
Date: Tue, 20 May 2014 13:30:19 +0200
Message-ID: <537B3CCB.70909@redhat.com>
References: <E1WlLlY-0007GR-QD@puleglot.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1WlLlY-0007GR-QD-C3g8GgeTu50ox3rIn2DAYQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 16.05.2014 19:12, Alexander Tsoy wrote:
> cmdline() prints empty "resume=" options for non-persistent swap
> devices, for example zram. Add a check for that.
> 
> This patch also fixes printf formatting and removes unused variables.
> ---
>  modules.d/95resume/module-setup.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/modules.d/95resume/module-setup.sh b/modules.d/95resume/module-setup.sh
> index ceb7855..b1b4684 100755
> --- a/modules.d/95resume/module-setup.sh
> +++ b/modules.d/95resume/module-setup.sh
> @@ -17,12 +17,12 @@ check() {
>  
>  # called by dracut
>  cmdline() {
> -    local _activated
> -    declare -A _activated
> +    local _resume
>  
>      for dev in "${!host_fs_types[@]}"; do
>          [[ ${host_fs_types[$dev]} =~ ^(swap|swsuspend|swsupend)$ ]] || continue
> -        printf "resume=%s " "$(shorten_persistent_dev "$(get_persistent_dev "$dev")")"
> +        _resume=$(shorten_persistent_dev "$(get_persistent_dev "$dev")")
> +        [[ -n ${_resume} ]] && printf " resume=%s" "${_resume}"
>      done
>  }
>  
> 

thanks!

http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=c4b529f50388474ceffa8c918d2722fc777eac0a
