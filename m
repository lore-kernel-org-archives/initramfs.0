From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ifup.sh: Add support for bridge over team and vlan tagged
 team
Date: Tue, 09 Apr 2013 10:53:32 +0200
Message-ID: <5163D70C.6090806@redhat.com>
References: <1364819680-1618-1-git-send-email-chaowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1364819680-1618-1-git-send-email-chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jpirko-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 01.04.2013 14:34, schrieb WANG Chao:
> Team is the same network stack as bonding. Therefore give ifup the ability to
> handle bridge over team and vlan tagged team as bonding too.
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/ifup.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
> index 582278f..815ab64 100755
> --- a/modules.d/40network/ifup.sh
> +++ b/modules.d/40network/ifup.sh
> @@ -46,6 +46,8 @@ if [ -e /tmp/bridge.info ]; then
>          if [ "$netif" = "$ethname" ]; then
>              if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
>                  : # We need to really setup bond (recursive call)
> +            elif [ "$netif" = "$teammaster" ] && [ -n "$DO_TEAM_SETUP" ] ; then
> +                : # We need to really setup team (recursive call)
>              else
>                  netif="$bridgename"
>                  use_bridge='true'
> @@ -59,6 +61,8 @@ if [ -e /tmp/vlan.info ]; then
>      if [ "$netif" = "$phydevice" ]; then
>          if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
>              : # We need to really setup bond (recursive call)
> +        elif [ "$netif" = "$teammaster" ] && [ -n "$DO_TEAM_SETUP" ] ; then
> +            : # We need to really setup team (recursive call)
>          else
>              netif="$vlanname"
>              use_vlan='true'
> @@ -212,6 +216,8 @@ if [ -e /tmp/bridge.info ]; then
>          for ethname in $ethnames ; do
>              if [ "$ethname" = "$bondname" ] ; then
>                  DO_BOND_SETUP=yes ifup $bondname -m
> +            elif [ "$ethname" = "$teammaster" ] ; then
> +                DO_TEAM_SETUP=yes ifup $teammaster -m
>              else
>                  linkup $ethname
>              fi
> @@ -235,6 +241,8 @@ if [ "$netif" = "$vlanname" ] && [ ! -e /tmp/net.$vlanname.up ]; then
>      modprobe 8021q
>      if [ "$phydevice" = "$bondname" ] ; then
>          DO_BOND_SETUP=yes ifup $phydevice -m
> +    elif [ "$phydevice" = "$teammaster" ] ; then
> +        DO_TEAM_SETUP=yes ifup $phydevice -m
>      else
>          linkup "$phydevice"
>      fi
> 

applied
