From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 40network: Copy the customize dhcp config
Date: Fri, 12 Sep 2014 09:35:30 -0400
Message-ID: <20140912133530.GB32421@redhat.com>
References: <1410499671-31253-1-git-send-email-mhuang@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410499671-31253-1-git-send-email-mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Sep 12, 2014 at 01:27:51PM +0800, Minfei Huang wrote:
> It is not available to valid the following customize dhcp config
> /etc/dhclient.conf in the initram environment.
> 
> supersede domain-name "machine.test.group";
> supersede domain-name-servers 10.125.97.171, 10.126.98.43, 10.125.97.176;
> 
> The dracut doesnot acquire the customize dhcp config from
> /etc/dhclient.conf file when construct the initram image.
> 
> Copy the customize config to make the config availably in the
> initram environment by dhcp.
> 
> Signed-off-by: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Can you give more information about the problem here. Why only look
for "supercede" options only. What about rest of the options in
dhclient.conf?

Thanks
Vivek

> ---
>  modules.d/40network/module-setup.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
> index ae1f43f..76761f5 100755
> --- a/modules.d/40network/module-setup.sh
> +++ b/modules.d/40network/module-setup.sh
> @@ -67,6 +67,15 @@ installkernel() {
>          ecb arc4 bridge stp llc ipv6 bonding 8021q af_packet virtio_net
>  }
>  
> +setup_custom_dhclient() {
> +    _dhclient_file="/etc/dhclient.conf"
> +
> +    inst_simple "$moddir/dhclient.conf" "/etc/dhclient.conf"
> +
> +    [ ! -e $_dhclient_file ] && return
> +    cat $_dhclient_file | grep ^supersede >> ${initdir}/$_dhclient_file
> +}
> +
>  # called by dracut
>  install() {
>      local _arch _i _dir
> @@ -79,7 +88,7 @@ install() {
>      inst_script "$moddir/netroot.sh" "/sbin/netroot"
>      inst_script "$moddir/dhclient-script.sh" "/sbin/dhclient-script"
>      inst_simple "$moddir/net-lib.sh" "/lib/net-lib.sh"
> -    inst_simple "$moddir/dhclient.conf" "/etc/dhclient.conf"
> +    setup_custom_dhclient
>      inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
>      inst_hook pre-udev 60 "$moddir/net-genrules.sh"
>      inst_hook cmdline 91 "$moddir/dhcp-root.sh"
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
