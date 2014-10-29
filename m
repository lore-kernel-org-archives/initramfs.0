From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] 40network: Copy the customize dhcp config
Date: Wed, 29 Oct 2014 14:14:36 +0100
Message-ID: <5450E83C.2010107@redhat.com>
References: <1414391591-2828-1-git-send-email-mhuang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414391591-2828-1-git-send-email-mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 27.10.2014 07:33, Minfei Huang wrote:
> It is not available to valid the customize dhcp config
> /etc/dhclient.conf in the initram environment.
> 
> Dracut uses the default follow config to construct the initramfs.
> 
> request subnet-mask, broadcast-address, time-offset, routers,
>         domain-name, domain-name-servers, domain-search, host-name,
>         root-path, interface-mtu;
> 
> Copy the customize config to make the config availably in the
> initram environment.
> 
> Signed-off-by: Minfei Huang <mhuang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/module-setup.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
> index ae1f43f..55bee4c 100755
> --- a/modules.d/40network/module-setup.sh
> +++ b/modules.d/40network/module-setup.sh
> @@ -79,7 +79,8 @@ install() {
>      inst_script "$moddir/netroot.sh" "/sbin/netroot"
>      inst_script "$moddir/dhclient-script.sh" "/sbin/dhclient-script"
>      inst_simple "$moddir/net-lib.sh" "/lib/net-lib.sh"
> -    inst_simple "$moddir/dhclient.conf" "/etc/dhclient.conf"
> +    inst_simple -H "/etc/dhclient.conf"
> +    cat "$moddir/dhclient.conf" >> "${initdir}/etc/dhclient.conf"
>      inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
>      inst_hook pre-udev 60 "$moddir/net-genrules.sh"
>      inst_hook cmdline 91 "$moddir/dhcp-root.sh"
> 

Thanks! Pushed
