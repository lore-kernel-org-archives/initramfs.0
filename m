From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2]dhclient initqueue hook fix
Date: Wed, 11 Jul 2012 16:14:49 +0800
Message-ID: <4FFD35F9.8040602@redhat.com>
References: <20120709065635.GA14094@dhcp-16-143.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120709065635.GA14094-je1gSBvt1Td3da3rpXeqgR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 07/09/2012 02:56 PM, Dave Young wrote:

> dhclient initqueue hook fix
> 
> setup_net is scheduled in initqueue, sometimes it does not get chance to run
> So the default route will not be set properly
> 
> Add a check in initqueue/finished to resolve this issue.


Hi, harald. Could you give comment for this patch?

This might be only related to manually bring up network. I'm not sure
though.

> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/dhclient-script.sh |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- dracut.orig/modules.d/40network/dhclient-script.sh
> +++ dracut/modules.d/40network/dhclient-script.sh
> @@ -81,9 +81,11 @@ case $reason in
>              echo "setup_net $netif"
>              echo "source_hook initqueue/online $netif"
>              [ -e /tmp/net.$netif.manualup ] || echo "/sbin/netroot $netif"
> +            echo "> /tmp/setup_net_$netif.ok"
>              echo "rm -f $hookdir/initqueue/setup_net_$netif.sh"
>          } > $hookdir/initqueue/setup_net_$netif.sh
>  
> +        echo "[ -f /tmp/setup_net_$netif.ok ]" > $hookdir/initqueue/finished/dhclient-$netif.sh
>          >/tmp/net.$netif.up
>          ;;
>      *) echo "dhcp: $reason";;
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks
Dave
