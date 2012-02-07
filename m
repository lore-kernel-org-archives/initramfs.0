From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch] btrfs: fix two bugs in module-setup.sh
Date: Tue, 07 Feb 2012 12:14:43 +0100
Message-ID: <4F3107A3.5040303@redhat.com>
References: <1327917535-31293-1-git-send-email-xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1327917535-31293-1-git-send-email-xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 30.01.2012 10:58, schrieb Cong Wang:
> First, $host_fs_types is an array.
> Second, use strstr to match btrfs type.
> 
> Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
> diff --git a/modules.d/90btrfs/module-setup.sh b/modules.d/90btrfs/module-setup.sh
> index a141dda..135abc6 100755
> --- a/modules.d/90btrfs/module-setup.sh
> +++ b/modules.d/90btrfs/module-setup.sh
> @@ -13,8 +13,8 @@ check() {
>  
>      [[ $hostonly ]] || [[ $mount_needs ]] && {
>          local _found
> -        for fs in $host_fs_types; do
> -            [[ "$fs" = "|btrfs" ]] && _found="1"
> +        for fs in ${host_fs_types[@]}; do
> +            strstr "$fs" "\|btrfs" && _found="1"
>          done
>          [[ $_found ]] || return 1
>          unset _found
> 

pushed
