From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/4] Use glob for libdir when installing multipath libraries.
Date: Wed, 25 Nov 2009 10:52:20 -0500
Message-ID: <4B0D52B4.5090501@redhat.com>
References: <4B0D4A9F.1090606@redhat.com> <1259162752-22372-2-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259162752-22372-2-git-send-email-pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 11/25/2009 10:25 AM, Peter Jones wrote:
> Use "/lib*/" not "/lib/" so it works when they're in /lib/multipath as
> well as when they're in /lib64/multipath
> ---
>  modules.d/90multipath/install |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/90multipath/install b/modules.d/90multipath/install
> index 9552918..4890825 100755
> --- a/modules.d/90multipath/install
> +++ b/modules.d/90multipath/install
> @@ -2,6 +2,12 @@ if [[ $hostonly ]]; then
>      inst /etc/multipath.conf
>  fi
>  
> +if ldd $(/sbin/multipath) |grep -q lib64; then

This is obviously wrong.

> +    LIBDIR="/lib64"
> +else
> +    LIBDIR="/lib"
> +fi
> +
>  for f in  \
>      /sbin/dmsetup \
>      /sbin/kpartx \
> @@ -11,8 +17,8 @@ for f in  \
>      /sbin/xdrgetuid \
>      /sbin/xdrgetprio \
>      /etc/xdrdevices.conf \
> -    /lib/libmultipath*  \
> -    /lib/multipath/* ;do 
> +    $(ls $LIBDIR/libmultipath* $LIBDIR/multipath/*) \
> +    	;do
>      inst $f
>  done
>  


-- 
        Peter

"I can imagine a world without war, without hate. I can imagine us
attacking it, because they'd never expect it."
