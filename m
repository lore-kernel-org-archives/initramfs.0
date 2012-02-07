From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/7] fix fstab-sys module check
Date: Tue, 07 Feb 2012 12:15:24 +0100
Message-ID: <4F3107CC.7000105@redhat.com>
References: <20120202075956.GA12414@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120202075956.GA12414-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Am 02.02.2012 08:59, schrieb Dave Young:
> If /etc/fstab.sys does not exist installing fstab-sys module will fail.
> Fix this by checking use_fstab and fstab_lines as well
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut                                |    2 +-
>  modules.d/95fstab-sys/module-setup.sh |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: dracut/dracut
> ===================================================================
> --- dracut.orig/dracut
> +++ dracut/dracut
> @@ -598,7 +598,7 @@ done
>  export initdir dracutbasedir dracutmodules drivers \
>      fw_dir drivers_dir debug no_kernel kernel_only \
>      add_drivers mdadmconf lvmconf filesystems \
> -    use_fstab libdir usrlibdir fscks nofscks cttyhack \
> +    use_fstab fstab_lines libdir usrlibdir fscks nofscks cttyhack \
>      stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
>      debug host_fs_types host_devs sshkey
>  
> Index: dracut/modules.d/95fstab-sys/module-setup.sh
> ===================================================================
> --- dracut.orig/modules.d/95fstab-sys/module-setup.sh
> +++ dracut/modules.d/95fstab-sys/module-setup.sh
> @@ -3,7 +3,7 @@
>  # ex: ts=8 sw=4 sts=4 et filetype=sh
>  
>  check() {
> -    test -f /etc/fstab.sys
> +    test -f /etc/fstab.sys || [[ -n $use_fstab  ||  -n $fstab_lines ]]
>  }
>  
>  depends() {
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

pushed
