From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [BUGFIX Patch] fix a wrong usage of vinfo in init.sh
Date: Tue, 29 May 2012 10:20:04 +0200
Message-ID: <4FC486B4.8090506@redhat.com>
References: <1338278814-8603-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338278814-8603-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Am 29.05.2012 10:06, schrieb Cong Wang:
> vinfo() reads input from stdin, not from arguments.
> 
> This is a regression introduced by:
> 
> 	commit 982d59afea5eac202c8a47f09d06d240af753a24
> 	Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 	Date:   Tue May 22 14:52:36 2012 +0200
> 
> 	    drop 10rpmversion module and introduce /etc/initrd-release
> 
> 
> Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> ---
> diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
> index b8736ec..1146a86 100755
> --- a/modules.d/99base/init.sh
> +++ b/modules.d/99base/init.sh
> @@ -90,7 +90,7 @@ else
>  fi
>  
>  [ -f /etc/initrd-release ] && . /etc/initrd-release
> -[ -n "$VERSION" ] && vinfo "dracut-$VERSION"
> +[ -n "$VERSION" ] && echo "dracut-$VERSION" | vinfo
>  
>  source_conf /etc/conf.d
>  

Thanks! even simpler:

-[ -n "$VERSION" ] && vinfo "dracut-$VERSION"
+[ -n "$VERSION" ] && info "dracut-$VERSION"
