From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] usrmount: always install
Date: Wed, 11 Dec 2013 14:39:19 +0100
Message-ID: <52A86B07.2010202@redhat.com>
References: <E1VjXM1-00015c-6l@secretive.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1VjXM1-00015c-6l-7GBPmfXo8GgjmsMGrRdz4w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/21/2013 05:33 PM, Alexander Tsoy wrote:
> /usr should be mounted by initramfs even if /sbin/init lives in /
> ---
>  modules.d/98usrmount/module-setup.sh | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/modules.d/98usrmount/module-setup.sh b/modules.d/98usrmount/module-setup.sh
> index d8a0ec2..31a6229 100755
> --- a/modules.d/98usrmount/module-setup.sh
> +++ b/modules.d/98usrmount/module-setup.sh
> @@ -4,10 +4,7 @@
>  
>  # called by dracut
>  check() {
> -    local _init
>      [[ $mount_needs ]] && return 1
> -    _init=$(readlink -f /sbin/init)
> -    [[ "$_init" == "${_init##/usr}" ]] && return 255
>      return 0
>  }
>  
> 

Thanks! Pushed
