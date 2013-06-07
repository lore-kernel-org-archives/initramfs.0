From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-initqueue.service: Fix systemd start condition
Date: Fri, 07 Jun 2013 13:56:56 +0200
Message-ID: <51B1CA88.4060703@redhat.com>
References: <20130607095056.GA20100@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130607095056.GA20100-UAAZkH0G2Ts1naxU1pY8ZxcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/07/2013 11:50 AM, WANG Chao wrote:
> Scripts in dracut initqueue hooks are placed under
> /usr/lib/dracut/hooks/initqueue/*/ directory.
> 
> And also start initqueue service when kernel cmdline has
> rd.break=initqueue
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/98systemd/dracut-initqueue.service | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/98systemd/dracut-initqueue.service b/modules.d/98systemd/dracut-initqueue.service
> index f4c1dd4..61d3a7c 100644
> --- a/modules.d/98systemd/dracut-initqueue.service
> +++ b/modules.d/98systemd/dracut-initqueue.service
> @@ -15,8 +15,8 @@ After=systemd-udev-trigger.service
>  Wants=systemd-udev-trigger.service
>  ConditionPathExists=/etc/initrd-release
>  ConditionPathExists=|/lib/dracut/need-initqueue
> -ConditionPathExistsGlob=|/lib/dracut/hooks/initqueue/*.sh
> -ConditionKernelCommandLine=|rd.break=pre-mount
> +ConditionPathExistsGlob=|/lib/dracut/hooks/initqueue/*/*.sh
> +ConditionKernelCommandLine=|rd.break=initqueue
>  
>  [Service]
>  Environment=DRACUT_SYSTEMD=1
> 

Many thanks! Pushed!
