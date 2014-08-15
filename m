From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-functions: get_persistent_dev() fall back to the
 original name
Date: Fri, 15 Aug 2014 12:37:17 +0200
Message-ID: <53EDE2DD.8070409@redhat.com>
References: <1406557588-22484-1-git-send-email-chaowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406557588-22484-1-git-send-email-chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 28.07.2014 16:26, WANG Chao wrote:
> In case of raw disk/partition, ex. /dev/vda1, which doesn't contain any
> filesystem on it. get_persistent_dev() would return empty. Now fix it to
> return its original name, /dev/vda1 in above case. So that we don't have
> to check its return string every time.
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut-functions.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/dracut-functions.sh b/dracut-functions.sh
> index 6cdfea0..b07063f 100755
> --- a/dracut-functions.sh
> +++ b/dracut-functions.sh
> @@ -388,6 +388,7 @@ get_persistent_dev() {
>              return
>          fi
>      done
> +    echo $1
>  }
>  
>  expand_persistent_dev() {
> 

pushed, but added a patch to use printf instead of echo
