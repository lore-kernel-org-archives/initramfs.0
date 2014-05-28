From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: Do not stop installing drivers if one fails
Date: Wed, 28 May 2014 13:46:06 +0200
Message-ID: <5385CC7E.80106@redhat.com>
References: <3223446.4k6qIrFfuT@skinner>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3223446.4k6qIrFfuT@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07.05.2014 17:58, Thomas Renninger wrote:
> --add-drivers and --filesystems kernel drivers are added via:
> instmods -c
> The check option makes the function return if one driver could not get
> installed without trying to install further drivers which is bad.
> 
> The user is still informed ($_silent is by default no), but all modules
> passed to instmods are tried to be loaded, even if one fails.
> 
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> 
> Index: dracut-037/dracut-functions.sh
> ===================================================================
> --- dracut-037.orig/dracut-functions.sh
> +++ dracut-037/dracut-functions.sh
> @@ -1689,18 +1689,16 @@ instmods() {
>          if (($# == 0)); then  # filenames from stdin
>              while read _mod; do
>                  inst1mod "${_mod%.ko*}" || {
> -                    if [[ "$_check" == "yes" ]]; then
> -                        [[ "$_silent" == "no" ]] && dfatal "Failed to install module $_mod"
> -                        return 1
> +                    if [[ "$_check" == "yes" ]] && [[ "$_silent" == "no" ]]; then
> +                        dfatal "Failed to install module $_mod"
>                      fi
>                  }
>              done
>          fi
>          while (($# > 0)); do  # filenames as arguments
>              inst1mod ${1%.ko*} || {
> -                if [[ "$_check" == "yes" ]]; then
> -                    [[ "$_silent" == "no" ]] && dfatal "Failed to install module $1"
> -                    return 1
> +                if [[ "$_check" == "yes" ]] && [[ "$_silent" == "no" ]]; then
> +                    dfatal "Failed to install module $1"
>                  fi
>              }
>              shift
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Well that's the purpose of "-c". Maybe we should better fix the call with "-c"
and/or react to the return code.
