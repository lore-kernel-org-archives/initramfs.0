From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Do not override user specified initramfs image name
Date: Wed, 13 Mar 2013 08:17:18 +0100
Message-ID: <514027FE.9090600@redhat.com>
References: <CAKzfqkfwg_tW70VJbmgKg-Vs3O2DWLX36o0bMZhYvTL9U9QCRQ@mail.gmail.com> <513EDF30.7090408@redhat.com> <CAKzfqkeUkknOwONqZkuZ8c56+5iNLxigLv+K70sSDXuvPaabZg@mail.gmail.com> <513F42EC.5030800@redhat.com> <513FDAF4.9030908@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <513FDAF4.9030908-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 13.03.2013 02:48, schrieb Dave Young:
> 
> 
> The code section for setting default initramfs image name is only for
> the case that user has not specified image name argument.
> 
> Moving the code to else section of below:
> 
> if [[ "$1" ]]; then
> ...
> else
> ...
> fi
> 
> Also remove the typo of trailing '}'
> 
> Reported-by: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> diff --git a/lsinitrd.sh b/lsinitrd.sh
> index 7a09423..fe723f7 100755
> --- a/lsinitrd.sh
> +++ b/lsinitrd.sh
> @@ -54,23 +54,23 @@ if [[ "$1" ]]; then
>          usage
>          exit 1
>      fi
> -fi
> -
> -[[ -f /etc/machine-id ]] && read MACHINE_ID < /etc/machine-id
> -
> -if [[ $MACHINE_ID ]] && ( [[ -d /boot/${MACHINE_ID} ]] || [[ -L /boot/${MACHINE_ID} ]] ); then
> -    image="/boot/${MACHINE_ID}/${KERNEL_VERSION}/initrd"
>  else
> -    image="/boot/initramfs-${KERNEL_VERSION}.img}"
> -fi
> +    [[ -f /etc/machine-id ]] && read MACHINE_ID < /etc/machine-id
>  
> -if ! [[ -f "$image" ]]; then
> -    {
> +    if [[ $MACHINE_ID ]] && ( [[ -d /boot/${MACHINE_ID} ]] || [[ -L /boot/${MACHINE_ID} ]] ); then
> +        image="/boot/${MACHINE_ID}/${KERNEL_VERSION}/initrd"
> +    else
> +        image="/boot/initramfs-${KERNEL_VERSION}.img"
> +    fi
> +
> +    if ! [[ -f "$image" ]]; then
> +        {
>          echo "No <initramfs file> specified and the default image '$image' cannot be accessed!"
>          echo
> -    } >&2
> -    usage
> -    exit 1
> +        } >&2
> +        usage
> +        exit 1
> +    fi
>  fi
>  
>  CAT=zcat
> 

see
http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=727e68d0b5cb93eb6c6e00f0541b8519657a2597
and
http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=d928724c3cf464a495c11162042951887b80f5e6

already committed on 2013-03-11

