From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch RFC 6/6] Wait for interface up at the early stage
Date: Thu, 29 Nov 2012 16:09:17 +0800
Message-ID: <50B7182D.7000304@redhat.com>
References: <20121108034018.789330224@redhat.com> <20121108034317.844374819@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121108034317.844374819-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 11/08/2012 11:40 AM, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org wrote:

> In case long delay of network driver initqueue will exit before net dev is
> ready. We have no chance to setup it then.
> For dhcp, when we finish the setup there will be a setup_net_<dev>.ok. Doing
> same for static ip case. Also add a check to initqueue when we generate udev
> rules to ensure it's early enough.
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/ifup.sh         |    1 +
>  modules.d/40network/net-genrules.sh |    3 +++
>  2 files changed, 4 insertions(+)
> 
> --- dracut.orig/modules.d/40network/net-genrules.sh
> +++ dracut/modules.d/40network/net-genrules.sh
> @@ -49,14 +49,17 @@ fi
>      if [ -n "$BOOTIF" ] ; then
>          BOOTIF=$(fix_bootif "$BOOTIF")
>          printf 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="%s", RUN+="%s"\n' "$BOOTIF" "/sbin/initqueue --onetime $ifup"
> +        echo "[ -f /tmp/setup_net_${BOOTIF}.ok ]" >$hookdir/initqueue/finished/wait-${BOOTIF}.sh
>  
>      # If we have to handle multiple interfaces, handle only them.
>      elif [ -n "$IFACES" ] ; then
>          for iface in $IFACES ; do
>              printf 'SUBSYSTEM=="net", ENV{INTERFACE}=="%s", RUN+="%s"\n' "$iface" "/sbin/initqueue --onetime $ifup"
> +            echo "[ -f /tmp/setup_net_${iface}.ok ]" >$hookdir/initqueue/finished/wait-$iface.sh


Above waiting is only necessary for bootdev. For example of bonding
device, it should not wait for the slaves.

Will update 5/6 and 6/6 and resend this series.

>          done
>  
>      # Default: We don't know the interface to use, handle all
> +    # Fixme: waiting for the interface as well.
>      else
>          printf 'SUBSYSTEM=="net", RUN+="%s"\n' "/sbin/initqueue --onetime $ifup" > /etc/udev/rules.d/91-default-net.rules
>      fi
> --- dracut.orig/modules.d/40network/ifup.sh
> +++ dracut/modules.d/40network/ifup.sh
> @@ -109,6 +109,7 @@ do_static() {
>      [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
>      [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
>  
> +    > /tmp/setup_net_${netif}.ok
>      return 0
>  }
>  
> 



-- 
Thanks
Dave
