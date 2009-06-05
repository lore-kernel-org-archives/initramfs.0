From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Don't use absolute path for ip, does not always work
Date: Fri, 5 Jun 2009 11:59:01 -0400
Message-ID: <20090605155900.GI5107@nostromo.devel.redhat.com>
References: <4A292D53.9080603@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A292D53.9080603-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said: 
> ---
> diff --git a/modules.d/40network/dhclient-script  
> b/modules.d/40network/dhclient-script
> index 1ee78fe..d283762 100755
> --- a/modules.d/40network/dhclient-script
> +++ b/modules.d/40network/dhclient-script
> @@ -69,7 +69,7 @@ setup_interface() {
>
>  case $reason in
>      PREINIT)
> -       run /sbin/ip link set $netif up
> +       run ip link set $netif up
>         ;;
>      BOUND)
>         setup_interface

Why does it not always work, unless you're breaking your initramfs?

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
