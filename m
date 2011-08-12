From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch] lsinitrd: display the size of initrd
Date: Fri, 12 Aug 2011 08:06:50 +0200
Message-ID: <4E44C2FA.4080709@redhat.com>
References: <1312181715-27796-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312181715-27796-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01.08.2011 08:55, Amerigo Wang wrote:
> It is useful to display the size of initrd in human-friendly form.
> 
> Signed-off-by: Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> ---
> diff --git a/lsinitrd b/lsinitrd
> index 3b9cc85..7da9f61 100755
> --- a/lsinitrd
> +++ b/lsinitrd
> @@ -41,7 +41,7 @@ if [[ $# -eq 2 ]]; then
>      exit $?
>  fi
>  
> -echo "$image:"
> +echo "$image: $(du -h $image | awk '{print $1}')"
>  echo "========================================================================"
>  $CAT "$image" | cpio --extract --verbose --quiet --to-stdout 'lib/dracut/dracut-*' 2>/dev/null
>  echo "========================================================================"
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

pushed
