From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iscsi_firmware manpage fix
Date: Mon, 3 Nov 2014 13:20:04 +0800
Message-ID: <20141103052004.GD2816@darkstar.nay.redhat.com>
References: <20141103034010.GA4811@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141103034010.GA4811-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I had no chance to test the patch, just found the problem by reviewing code.
So it definitely need your careful review.

On 11/03/14 at 11:40am, Dave Young wrote:
> 
> Seems iscsi_firmware means rd.iscsi.firmware=1, so the manpage should be wrong
> 
> Also add '-d' in parse-iscsi script since it's depracated. 
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.cmdline.7.asc                 |    2 +-
>  modules.d/95iscsi/parse-iscsiroot.sh |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- dracut.orig/dracut.cmdline.7.asc
> +++ dracut/dracut.cmdline.7.asc
> @@ -972,7 +972,7 @@ iscsi_in_username:: rd.iscsi.in.username
>  
>  iscsi_in_password:: rd.iscsi.in.password
>  
> -iscsi_firmware:: rd.iscsi.firmware=0
> +iscsi_firmware:: rd.iscsi.firmware=1
>  
>  rd_NO_PLYMOUTH:: rd.plymouth=0
>  
> --- dracut.orig/modules.d/95iscsi/parse-iscsiroot.sh
> +++ dracut/modules.d/95iscsi/parse-iscsiroot.sh
> @@ -20,7 +20,7 @@ if [ -z "$netroot" ]; then
>      [ "${netroot%%:*}" = "iscsi" ] || unset netroot
>  fi
>  [ -z "$iscsiroot" ] && iscsiroot=$(getarg iscsiroot=)
> -[ -z "$iscsi_firmware" ] && getargbool 0 rd.iscsi.firmware -y iscsi_firmware && iscsi_firmware="1"
> +[ -z "$iscsi_firmware" ] && getargbool 0 rd.iscsi.firmware -d -y iscsi_firmware && iscsi_firmware="1"
>  
>  [ -n "$iscsiroot" ] && [ -n "$iscsi_firmware" ] && die "Mixing iscsiroot and iscsi_firmware is dangerous"
>  
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
