From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] modules: base: include wc utility
Date: Tue, 7 Jul 2015 13:17:25 +0200
Message-ID: <559BB545.2020005@redhat.com>
References: <87h9pxjfv7.fsf@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87h9pxjfv7.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Nicolai Stange <nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 24.06.2015 17:17, Nicolai Stange wrote:
> Commit cfa365a32d47 ("lvm: Don't activate LVs with activationskip set")
> introduces a usage of the wc utility.
> 
> Make it available in the initramfs through the base module.
> 
> Signed-off-by: Nicolai Stange <nicstange-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  modules.d/99base/module-setup.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
> index bbc68ba..5b89028 100755
> --- a/modules.d/99base/module-setup.sh
> +++ b/modules.d/99base/module-setup.sh
> @@ -16,7 +16,8 @@ install() {
>      local _d
>  
>      inst_multiple mount mknod mkdir sleep chroot chown \
> -        sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink setsid
> +        sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink setsid \
> +        wc
>      inst $(command -v modprobe) /sbin/modprobe
>  
>      inst_multiple -o findmnt less kmod
> 

fixed by reverting the lvm patch :)
