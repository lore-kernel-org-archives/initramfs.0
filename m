From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] Add vlan support in network module
Date: Mon, 21 May 2012 11:22:19 +0200
Message-ID: <4FBA094B.5040303@redhat.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337591686-31875-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

vconfig is deprecated. Please use iproute.

-           /sbin/vconfig add ${PHYSDEV} ${VID}
+           ip link add dev ${DEVICE} link ${PHYSDEV} type vlan id ${VID}

Am 21.05.2012 11:14, schrieb Cong Wang:
> From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This patch adds basic vlan support in network module.
> 
> The cmdline syntax for vlan is:
> 
> 	vlan=<vlanname>[:<phydevice>]
> 
> for an example:
> 
> 	vlan=eth0.2:eth0
> 
> or
> 	vlan=eth0.2
> 
> This is just the basic syntax, vlan has other styles of
> naming, like "vlan2". We need to extend the syntax in the future,
> this patch is just a starter. ;-)
> 
> TODO: Add doc for vlan= cmdline
> 
> Any comments?
> 
> Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
>  modules.d/40network/ifup.sh         |   18 +++++++++++++
>  modules.d/40network/module-setup.sh |    5 +++-
>  modules.d/40network/net-genrules.sh |    5 ++++
>  modules.d/40network/parse-vlan.sh   |   46 +++++++++++++++++++++++++++++++++++
>  4 files changed, 73 insertions(+), 1 deletions(-)
>  create mode 100644 modules.d/40network/parse-vlan.sh
> 
> diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
> index 71b869d..aab0dfc 100755
> --- a/modules.d/40network/ifup.sh
> +++ b/modules.d/40network/ifup.sh
> @@ -40,6 +40,17 @@ if [ -e /tmp/bridge.info ]; then
>      fi
>  fi
>  
> +if [ -e /tmp/vlan.info ]; then
> +    . /tmp/vlan.info
> +    if [ "$netif" = "$phydevice" ]; then
> +        if [ "$netif" = "$bondname" ] && [ -n "$DO_BOND_SETUP" ] ; then
> +            : # We need to really setup bond (recursive call)
> +        else
> +            netif="$vlanname"
> +        fi
> +    fi
> +fi
> +
>  # disable manual ifup while netroot is set for simplifying our logic
>  # in netroot case we prefer netroot to bringup $netif automaticlly
>  [ -n "$2" -a "$2" = "-m" ] && [ -z "$netroot" ] && manualup="$2"
> @@ -178,6 +189,13 @@ if [ "$netif" = "$bridgename" ] && [ ! -e /tmp/net.$bridgename.up ]; then
>      brctl addif $bridgename $ethname
>  fi
>  
> +if [ "$netif" = "$vlanname" ] && [ ! -e /tmp/net.$vlanname.up ]; then
> +    modprobe 8021q
> +    ip link set "$phydevice" up
> +    wait_for_if_up "$phydevice"
> +    vconfig add "$phydevice" "${vlanname##*.}"
> +fi
> +
>  # No ip lines default to dhcp
>  ip=$(getarg ip)
>  
> diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
> index d49b594..07cdc7f 100755
> --- a/modules.d/40network/module-setup.sh
> +++ b/modules.d/40network/module-setup.sh
> @@ -68,12 +68,14 @@ installkernel() {
>      instmods ipv6
>      # bonding
>      instmods bonding
> +    # vlan
> +    instmods 8021q
>  }
>  
>  install() {
>      local _arch _i _dir
>      dracut_install ip arping tr dhclient
> -    dracut_install -o brctl ifenslave
> +    dracut_install -o brctl ifenslave vconfig
>      inst "$moddir/ifup.sh" "/sbin/ifup"
>      inst "$moddir/netroot.sh" "/sbin/netroot"
>      inst "$moddir/dhclient-script.sh" "/sbin/dhclient-script"
> @@ -82,6 +84,7 @@ install() {
>      inst_hook pre-udev 50 "$moddir/ifname-genrules.sh"
>      inst_hook pre-udev 60 "$moddir/net-genrules.sh"
>      inst_hook cmdline 91 "$moddir/dhcp-root.sh"
> +    inst_hook cmdline 95 "$moddir/parse-vlan.sh"
>      inst_hook cmdline 96 "$moddir/parse-bond.sh"
>      inst_hook cmdline 97 "$moddir/parse-bridge.sh"
>      inst_hook cmdline 98 "$moddir/parse-ip-opts.sh"
> diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
> index 7176681..142634e 100755
> --- a/modules.d/40network/net-genrules.sh
> +++ b/modules.d/40network/net-genrules.sh
> @@ -31,6 +31,11 @@ fix_bootif() {
>          IFACES=${bondslaves%% *}
>      fi
>  
> +    if [ -e /tmp/vlan.info ]; then
> +        . /tmp/vlan.info
> +        IFACES=$phydevice
> +    fi
> +
>      ifup='/sbin/ifup $env{INTERFACE}'
>      [ -z "$netroot" ] && ifup="$ifup -m"
>  
> diff --git a/modules.d/40network/parse-vlan.sh b/modules.d/40network/parse-vlan.sh
> new file mode 100644
> index 0000000..efe7bfa
> --- /dev/null
> +++ b/modules.d/40network/parse-vlan.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +#
> +# Format:
> +#	vlan=<vlanname>[:<phydevice>]
> +#
> +
> +# return if vlan already parsed
> +[ -n "$vlanname" ] && return
> +
> +# Check if vlan parameter is valid
> +if getarg vlan= >/dev/null ; then
> +    if [ -z "$netroot" ] ; then
> +        die "No netboot configured, vlan is invalid"
> +    fi
> +    command -v vconfig >/dev/null 2>&1 || die "No 'vconfig' installed"
> +fi
> +
> +parsevlan() {
> +    local v=${1}:
> +    set --
> +    while [ -n "$v" ]; do
> +        set -- "$@" "${v%%:*}"
> +        v=${v#*:}
> +    done
> +
> +    unset vlanname phydevice
> +    case $# in
> +    1)  vlanname=$1; phydevice="${1%.*}" ;;
> +    2)  vlanname=$1; phydevice=$2 ;;
> +    *)  die "vlan= requires one or two parameters" ;;
> +    esac
> +}
> +
> +unset vlanname phydevice
> +
> +if getarg vlan >/dev/null; then
> +    # Read vlan= parameters if they exist
> +    vlan="$(getarg vlan=)"
> +    if [ ! "$vlan" = "vlan" ]; then
> +        parsevlan "$(getarg vlan=)"
> +    fi
> +
> +    echo "vlanname=\"$vlanname\"" > /tmp/vlan.info
> +    echo "phydevice=\"$phydevice\"" >> /tmp/vlan.info
> +    return
> +fi
