From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/7] source dracut-lib.sh in nfs cleanup script
Date: Tue, 07 Feb 2012 12:15:37 +0100
Message-ID: <4F3107D9.2010002@redhat.com>
References: <20120202080004.GA12418@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120202080004.GA12418-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Am 02.02.2012 09:00, schrieb Dave Young:
> nfsroot-cleanup.sh need source dracut-lib.sh for function incol2
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/95nfs/nfsroot-cleanup.sh |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: dracut/modules.d/95nfs/nfsroot-cleanup.sh
> ===================================================================
> --- dracut.orig/modules.d/95nfs/nfsroot-cleanup.sh
> +++ dracut/modules.d/95nfs/nfsroot-cleanup.sh
> @@ -2,6 +2,8 @@
>  # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
>  # ex: ts=8 sw=4 sts=4 et filetype=sh
>  
> +type incol2 >/dev/null 2>&1 || . /lib/dracut-lib.sh
> +
>  [ -f /tmp/nfs.rpc_pipefs_path ] && rpcpipefspath=`cat /tmp/nfs.rpc_pipefs_path`
>  [ -z "$rpcpipefspath" ] && rpcpipefspath=var/lib/nfs/rpc_pipefs
>  
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

pushed
