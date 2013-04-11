From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] [40network] Fix ifup.sh to always execute initqueue/online
 hook after bringing up an interface
Date: Thu, 11 Apr 2013 17:44:08 +0200
Message-ID: <5166DA48.20803@redhat.com>
References: <1365694894-7926-1-git-send-email-devurandom@gmx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365694894-7926-1-git-send-email-devurandom-hi6Y0CQ0nG0@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 11.04.2013 17:41, schrieb Dennis Schridde:
> ---
>  modules.d/40network/ifup.sh | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
> index 526251f..13be22a 100755
> --- a/modules.d/40network/ifup.sh
> +++ b/modules.d/40network/ifup.sh
> @@ -307,19 +307,13 @@ for p in $(getargs ip=); do
>              do_static ;;
>      esac
>  
> -    case $autoconf in
> -        dhcp|on|any|dhcp6)
> -            ;;
> -        *)
> -            if [ $? -eq 0 ]; then
> -                setup_net $netif
> -                source_hook initqueue/online $netif
> -                if [ -z "$manualup" ]; then
> -                    /sbin/netroot $netif
> -                fi
> -            fi
> -            ;;
> -    esac
> +    if [ $? -eq 0 ]; then
> +        setup_net $netif
> +        source_hook initqueue/online $netif
> +        if [ -z "$manualup" ]; then
> +            /sbin/netroot $netif
> +        fi
> +    fi
>  
>      break
>  done
> 

IIRC, that is done, as soon as the dhcp client gets an IP
