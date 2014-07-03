From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] modsign: do not hardcode path to keyctl
Date: Thu, 03 Jul 2014 14:10:55 +0200
Message-ID: <53B5484F.2070504@redhat.com>
References: <E1WUcqK-0008KG-Ty@secretive.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1WUcqK-0008KG-Ty-7GBPmfXo8GgjmsMGrRdz4w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 31.03.2014 15:56, Alexander Tsoy wrote:
> https://bugs.gentoo.org/show_bug.cgi?id=506094
> ---
>  modules.d/03modsign/module-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/03modsign/module-setup.sh b/modules.d/03modsign/module-setup.sh
> index 09285d3..cc0e241 100755
> --- a/modules.d/03modsign/module-setup.sh
> +++ b/modules.d/03modsign/module-setup.sh
> @@ -29,7 +29,7 @@ depends() {
>  # called by dracut
>  install() {
>      inst_dir /lib/modules/keys
> -    inst_binary /usr/bin/keyctl
> +    inst_binary keyctl
>  
>      inst_hook pre-trigger 01 "$moddir/load-modsign-keys.sh"
>  
> 

thanks! pushed
