From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] Wait for logical interface to be up
Date: Tue, 09 Apr 2013 11:04:04 +0800
Message-ID: <51638524.4000508@redhat.com>
References: <cover.1365413867.git.bhe@redhat.com> <9100182be23fd2ec4e42f0ba667bc09cab6ca056.1365413867.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9100182be23fd2ec4e42f0ba667bc09cab6ca056.1365413867.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 04/08/2013 05:47 PM, Baoquan He wrote:
> If bootdev is logical interface like bond, bridge or vlan, we need
> wait them up.
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/net-genrules.sh |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
> index 05fa5f3..be2f811 100755
> --- a/modules.d/40network/net-genrules.sh
> +++ b/modules.d/40network/net-genrules.sh
> @@ -25,6 +25,7 @@ fi
>      if [ -e /tmp/bridge.info ]; then
>          . /tmp/bridge.info
>          IFACES="$IFACES ${ethnames%% *}"
> +        MASTER_IFACES="$MASTER_IFACES $bridgename"
>      fi
>  
>      # bond: attempt only the defined interface (override bridge defines)
> @@ -35,16 +36,19 @@ fi
>          . "$i"
>          # It is enough to fire up only one
>          IFACES="$IFACES ${bondslaves%% *}"
> +        MASTER_IFACES="$MASTER_IFACES ${bondname}"
>      done
>  
>      if [ -e /tmp/team.info ]; then
>          . /tmp/team.info
>          IFACES="$IFACES ${teamslaves}"
> +        MASTER_IFACES="$MASTER_IFACES ${teammaster}"
>      fi
>  
>      if [ -e /tmp/vlan.info ]; then
>          . /tmp/vlan.info
>          IFACES="$IFACES $phydevice"
> +        MASTER_IFACES="$MASTER_IFACES ${vlanname}"
>      fi
>  
>      if [ -z "$IFACES" ]; then
> @@ -56,7 +60,7 @@ fi
>      fi
>  
>      ifup='/sbin/ifup $env{INTERFACE}'
> -    [ -z "$netroot" ] && ifup="$ifup -m"
> +    [ -z "$netroot" ] && ifup="$ifup -m"

Please remove change in above line.., otherwise these two patches looks
good to me.


>  
>      # BOOTIF says everything, use only that one
>      BOOTIF=$(getarg 'BOOTIF=')
> @@ -74,6 +78,11 @@ fi
>              fi
>          done
>  
> +        for iface in $MASTER_IFACES; do
> +            if [ "$bootdev" = "$iface" ]; then
> +                echo "[ -f /tmp/setup_net_${iface}.ok ]" >$hookdir/initqueue/finished/wait-$iface.sh
> +            fi
> +        done
>      # Default: We don't know the interface to use, handle all
>      # Fixme: waiting for the interface as well.
>      else
> 


-- 
Thanks
Dave

