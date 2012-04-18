From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch] network: move the kill-dhclient.sh hook later
Date: Wed, 18 Apr 2012 13:57:41 +0800
Message-ID: <4F8E57D5.7090200@redhat.com>
References: <1334669111-17575-1-git-send-email-xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334669111-17575-1-git-send-email-xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 04/17/2012 09:25 PM, Cong Wang wrote:

> kdump module uses a pre-pivot hook too, it needs networking, so
> do not kill dhclient so early. kdump hook needs to find a place
> where all needed fs are mounted meanwhile networking works too.


There's still below hooks need consider if you want to move:

90crypt/module-setup.sh:    inst_hook pre-pivot 30
"$moddir/crypt-cleanup.sh"
95iscsi/module-setup.sh:    inst_hook pre-pivot 90
"$moddir/cleanup-iscsi.sh"


> 
> Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
> diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
> index c91f164..1a7d206 100755
> --- a/modules.d/40network/module-setup.sh
> +++ b/modules.d/40network/module-setup.sh
> @@ -85,7 +85,7 @@ install() {
>      inst_hook cmdline 97 "$moddir/parse-bridge.sh"
>      inst_hook cmdline 98 "$moddir/parse-ip-opts.sh"
>      inst_hook cmdline 99 "$moddir/parse-ifname.sh"
> -    inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
> +    inst_hook pre-pivot 98 "$moddir/kill-dhclient.sh"
>  
>      _arch=$(uname -m)
>  
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
