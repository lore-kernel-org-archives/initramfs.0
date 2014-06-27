From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2] network: add static route support
Date: Fri, 27 Jun 2014 10:57:42 +0200
Message-ID: <53AD3206.2020601@redhat.com>
References: <1403856480-13745-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403856480-13745-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org


"_" or ":" as a seperator??? code and documentation seem to differ

Can we restrict this to network gateway dev ?

On 27.06.2014 10:08, Baoquan He wrote:
> User may specify static route for a target address which is different
> than default gateway, hence static route need be added.
> 
> Now add a cmdline parameter rd.route="" and the related operation to
> parse it. User can add static route by specify it in cmdline like:
> 
> rd.route="192.168.200.0/24:via:192.168.100.222:dev:ens10"
> ---
>  dracut.cmdline.7.asc           | 8 ++++++++
>  modules.d/40network/net-lib.sh | 9 +++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
> index 10550ee..87acc54 100644
> --- a/dracut.cmdline.7.asc
> +++ b/dracut.cmdline.7.asc
> @@ -528,6 +528,14 @@ interface name. Better name it "bootnet" or "bluesocket".
>      list of physical (ethernet) interfaces. Bridge without parameters assumes
>      bridge=br0:eth0
>  
> +**rd.route=**__<route-options>__::
> +    Add static route to route table with route options which are separated by
> +    underscore. Among them some are necessary, such as the destination prefix
> +    of the route, the address of the nexthop route, the output device name.
> +    It's like
> +    rd.route=192.168.200.0/24:via:192.168.100.222:dev:ens10
> +
> +
>  NFS
>  ~~~
>  **root=**\[_<server-ip>_:]__<root-dir>__[:__<nfs-options>__]::
> diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
> index a82f1a8..b428abb 100755
> --- a/modules.d/40network/net-lib.sh
> +++ b/modules.d/40network/net-lib.sh
> @@ -103,6 +103,15 @@ setup_net() {
>      [ -e /tmp/net.$netif.resolv.conf ] && \
>          cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
>  
> +    # add static route
> +    local _p _r
> +    for _p in $(getargs rd.route=); do
> +        if strstr "$_p" "$netif"; then
> +            _r=${_p//'_'/' '}
> +            ip route add $_r
> +        fi
> +    done
> +
>      # Handle STP Timeout: arping the default gateway.
>      # (or the root server, if a) it's local or b) there's no gateway.)
>      # Note: This assumes that if no router is present the
> 
