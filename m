From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] mkinitrd-dracut.sh: fix stray "fi"
Date: Mon, 23 Aug 2010 22:33:05 +0200
Message-ID: <4C72DB01.80505@redhat.com>
References: <20100823175624.11190.66215.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100823175624.11190.66215.stgit@cooker>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

pushed

On 08/23/2010 07:56 PM, Andrey Borzenkov wrote:
>
>
> Signed-off-by: Andrey Borzenkov<arvidjaar-JGs/UdohzUI@public.gmane.org>
>
> ---
>
>   mkinitrd-dracut.sh |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
> index 15b39a6..320a9fe 100644
> --- a/mkinitrd-dracut.sh
> +++ b/mkinitrd-dracut.sh
> @@ -92,7 +92,6 @@ done
>
>   [[ $target&&  $kernel ]] || usage
>   [[ $img_vers ]]&&  target="$target-$kernel"
> -fi
>
>   if [[ $basicmodules ]]; then
>   	dracut $dracut_args --add-drivers "$basicmodules" "$target" "$kernel"
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
