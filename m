From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/7] add nobody group for rpc.idmapd
Date: Tue, 07 Feb 2012 12:15:31 +0100
Message-ID: <4F3107D3.3010803@redhat.com>
References: <20120202075959.GA12416@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120202075959.GA12416-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Am 02.02.2012 08:59, schrieb Dave Young:
> Add nobody group due to rpc.idmapd will fail to startup without nobody group
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/95nfs/module-setup.sh |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- dracut.orig/modules.d/95nfs/module-setup.sh	2012-02-02 15:40:25.000000000 +0800
> +++ dracut/modules.d/95nfs/module-setup.sh	2012-02-02 15:41:01.214407426 +0800
> @@ -69,6 +69,7 @@ install() {
>      egrep '^rpc:' /etc/passwd >> "$initdir/etc/passwd"
>      egrep '^rpcuser:' /etc/passwd >> "$initdir/etc/passwd"
>      #type -P nologin >/dev/null && dracut_install nologin
> +    egrep '^nobody:' /etc/group >> "$initdir/etc/group"
>      egrep '^rpc:' /etc/group >> "$initdir/etc/group"
>  
>      # rpc user needs to be able to write to this directory to save the warmstart
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

pushed
