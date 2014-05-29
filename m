From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] network: add static route support
Date: Thu, 29 May 2014 14:27:27 +0800
Message-ID: <20140529062727.GI2068@darkstar.nay.redhat.com>
References: <1398678111-13601-1-git-send-email-bhe@redhat.com>
 <1398678111-13601-2-git-send-email-bhe@redhat.com>
 <20140505071214.GA24097@dhcp-16-116.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140505071214.GA24097-je1gSBvt1Tcx0jIIkfS+Ph/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 05/05/14 at 03:12pm, Baoquan He wrote:
> User may specify static route for a target address which is different
> than default gateway. The static route file could be like below:
> 
> 192.168.200.222 via 192.168.100.222 dev eth0
> 
> Or
> 
> ADDRESS0=192.168.200.0
> NETMASK0=255.255.255.0
> GATEWAY0=192.168.100.222

For the latter format ADDRESS0, I guess the '0' means the order number of nic.
But if it's renamed to anything else which is not ending with number how to
find the right card?

So how about use one uniform format like "192.168.200.222 via 192.168.100.222 dev eth0"?

Maybe always get the route item by 'ip' command instead of reading the route file?
Using ip command there's another possible advantage that no need to handle ipv6 specific
formats in route file if there's any different.

> 
> In this patch, port the static route hanling from ifup-routes of initscript
> component.
> 
> v1->v2:
>     Remove the commentary line checking code and "MATCH" pattern
> definition since dracut require posix syntax. Let's focus on the
> functionality of static route.
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/net-lib.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
> index a82f1a8..0d488b5 100755
> --- a/modules.d/40network/net-lib.sh
> +++ b/modules.d/40network/net-lib.sh
> @@ -103,6 +103,16 @@ setup_net() {
>      [ -e /tmp/net.$netif.resolv.conf ] && \
>          cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
>  
> +    #add static route if exist
> +    f="/etc/route-$netif"
> +    if [ -e "$f" ]; then
> +        if grep -Eq '^[[:space:]]*ADDRESS[0-9]+=' $f ; then
> +            handle_file $f $netif
> +        else
> +            handle_ip_file $f
> +        fi
> +    fi
> +

Suppose it's for static setup only, how about moving the code into do_static
in ifup.sh

>      # Handle STP Timeout: arping the default gateway.
>      # (or the root server, if a) it's local or b) there's no gateway.)
>      # Note: This assumes that if no router is present the
> @@ -517,6 +527,35 @@ find_iface_with_link() {
>      return 1
>  }
>  
> +handle_file () {
> +    . $1
> +    routenum=0
> +    while [ "x$(eval echo '$'ADDRESS$routenum)x" != "xx" ]; do
> +        eval $(ipcalc -p $(eval echo '$'ADDRESS$routenum) $(eval echo '$'NETMASK$routenum))
> +        line="$(eval echo '$'ADDRESS$routenum)/$PREFIX"
> +        if [ "x$(eval echo '$'GATEWAY$routenum)x" != "xx" ]; then
> +            line="$line via $(eval echo '$'GATEWAY$routenum)"
> +        fi
> +        line="$line dev $2"
> +        /sbin/ip route add $line
> +        routenum=$(($routenum+1))
> +    done
> +}
> +
> +handle_ip_file() {
> +    local f t type= file=$1 proto="-4"
> +    f=${file##*/}
> +    t=${f%%-*}
> +    type=${t%%6}
> +    if [ "$type" != "$t" ]; then
> +        proto="-6"
> +    fi
> +
> +    while read line; do
> +        /sbin/ip $proto $type add $line
> +    done < $file
> +}
> +
>  is_persistent_ethernet_name() {
>      case "$1" in
>          # udev persistent interface names
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
