From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 7/7] do not check dev node exist for fstab-sys mounting
Date: Tue, 07 Feb 2012 12:15:50 +0100
Message-ID: <4F3107E6.3040104@redhat.com>
References: <20120202080011.GA12422@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120202080011.GA12422-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Am 02.02.2012 09:00, schrieb Dave Young:
> in case nfs mounting do not check if $_dev exist
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/95fstab-sys/mount-sys.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: dracut/modules.d/95fstab-sys/mount-sys.sh
> ===================================================================
> --- dracut.orig/modules.d/95fstab-sys/mount-sys.sh
> +++ dracut/modules.d/95fstab-sys/mount-sys.sh
> @@ -11,7 +11,7 @@ fstab_mount() {
>      info "Mounting from $1"
>      while read _dev _mp _fs _opts _dump _pass _rest; do
>          [ -z "${_dev%%#*}" ] && continue # Skip comment lines
> -        if [ ! -e "$_dev" ]; then
> +        if [[ ! "$_fs" =~ "nfs" ]] && [ ! -e "$_dev" ]; then
>              warn "Device $_dev doesn't exist, skipping mount."
>              continue
>          fi
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

pushed
