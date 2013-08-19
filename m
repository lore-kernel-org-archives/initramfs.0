From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] systemd: pre-pivot hooks runs after /sysroot is mounted
Date: Mon, 19 Aug 2013 15:51:19 +0200
Message-ID: <521222D7.7080702@redhat.com>
References: <20130816051328.GA30982@dhcp16-109.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130816051328.GA30982-ALckc1lQpMDv8MId6FTy5BcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/16/2013 07:13 AM, WANG Chao wrote:
> If rootflags=nofail, sysroot.mount won't strictly run "Before"
> initrd-root-fs.target. So we need to order dracut-pre-pivot after
> sysroot.mount.
> ---
>  modules.d/98systemd/dracut-pre-pivot.service | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/98systemd/dracut-pre-pivot.service b/modules.d/98systemd/dracut-pre-pivot.service
> index 56818b9..dd4e49b 100644
> --- a/modules.d/98systemd/dracut-pre-pivot.service
> +++ b/modules.d/98systemd/dracut-pre-pivot.service
> @@ -10,7 +10,7 @@
>  [Unit]
>  Description=dracut pre-pivot and cleanup hook
>  Documentation=man:dracut-pre-pivot.service(8)
> -After=initrd.target initrd-parse-etc.service
> +After=initrd.target initrd-parse-etc.service sysroot.mount
>  After=dracut-initqueue.service dracut-pre-mount.service dracut-mount.service
>  Before=initrd-cleanup.service
>  ConditionPathExists=/etc/initrd-release
> 

Thanks!

Pushed
