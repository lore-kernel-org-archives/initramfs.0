From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] dracut: add team device support
Date: Mon, 03 Dec 2012 11:11:45 +0800
Message-ID: <50BC1871.4050009@redhat.com>
References: <1352991509-31740-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352991509-31740-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 11/15/2012 10:58 PM, Cong Wang wrote:

> This patch adds the initial support for team device.
> A new cmdline team= is introduced for it.
> 
> Note, currently we don't support stacked devices
> on/under team, it is tricky and can be added on request.
> 
> Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
> Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/ifup.sh         |   20 +++++++++++++++
>  modules.d/40network/module-setup.sh |    4 ++-
>  modules.d/40network/net-genrules.sh |    5 ++++
>  modules.d/40network/parse-team.sh   |   45 +++++++++++++++++++++++++++++++++++
>  4 files changed, 73 insertions(+), 1 deletions(-)
>  create mode 100755 modules.d/40network/parse-team.sh
> 
> diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
> index db233de..d5ec4e0 100755
> --- a/modules.d/40network/ifup.sh
> +++ b/modules.d/40network/ifup.sh
> @@ -28,6 +28,15 @@ if [ -e /tmp/bond.info ]; then
>      done
>  fi
>  
> +if [ -e /tmp/team.info ]; then
> +    . /tmp/team.info
> +    for slave in $teamslaves ; do
> +        if [ "$netif" = "$slave" ] ; then
> +            netif=$teammaster
> +        fi
> +    done
> +fi
> +
>  # bridge this interface?
>  if [ -e /tmp/bridge.info ]; then
>      . /tmp/bridge.info
> @@ -167,6 +176,17 @@ if [ -e /tmp/bond.info ]; then
>      fi
>  fi
>  
> +if [ -e /tmp/team.info ]; then
> +    . /tmp/team.info
> +    if [ "$netif" = "$teammaster" ] && [ ! -e /tmp/net.$teammaster.up ] ; then
> +        # team needs slaves to be down
> +        for slave in $teamslaves ; do
> +            ip link set $slave down
> +        done
> +        teamd -d -f /etc/teamd/$teammaster.conf
> +        ip link set $teammaster up
> +    fi
> +fi
>  
>  # XXX need error handling like dhclient-script
>  
> diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
> index da0f447..f2a8f73 100755
> --- a/modules.d/40network/module-setup.sh
> +++ b/modules.d/40network/module-setup.sh
> @@ -64,7 +64,7 @@ installkernel() {
>      { find_kernel_modules_by_path drivers/net; if [ "$_arch" = "s390" -o "$_arch" = "s390x" ]; then find_kernel_modules_by_path drivers/s390/net; fi; } \
>          | net_module_filter | instmods
>  
> -    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding 8021q af_packet virtio_net
> +    instmods =drivers/net/phy ecb arc4 bridge stp llc ipv6 bonding 8021q af_packet virtio_net =drivers/net/team



40network installs all related kernel modules. This will create a big
initramfs though some of them are not used at all.

I'm thinking it's better to conditionally install them. In the long run
maybe network module should be splited to to multiple modules.

And for now I think it's better to install them only if there's team
related user space tools in running system.


>  }
>  
>  install() {
> @@ -72,6 +72,7 @@ install() {
>      dracut_install ip arping dhclient sed
>      dracut_install -o ping ping6
>      dracut_install -o brctl
> +    dracut_install -o teamd teamdctl teamnl
>      inst_script "$moddir/ifup.sh" "/sbin/ifup"
>      inst_script "$moddir/netroot.sh" "/sbin/netroot"
>      inst_script "$moddir/dhclient-script.sh" "/sbin/dhclient-script"
> @@ -82,6 +83,7 @@ install() {
>      inst_hook cmdline 91 "$moddir/dhcp-root.sh"
>      inst_hook cmdline 95 "$moddir/parse-vlan.sh"
>      inst_hook cmdline 96 "$moddir/parse-bond.sh"
> +    inst_hook cmdline 96 "$moddir/parse-team.sh"
>      inst_hook cmdline 97 "$moddir/parse-bridge.sh"
>      inst_hook cmdline 98 "$moddir/parse-ip-opts.sh"
>      inst_hook cmdline 99 "$moddir/parse-ifname.sh"
> diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
> index 6a58ab5..f5cd200 100755
> --- a/modules.d/40network/net-genrules.sh
> +++ b/modules.d/40network/net-genrules.sh
> @@ -34,6 +34,11 @@ fi
>          IFACES+=" ${bondslaves%% *}"
>      fi
>  
> +    if [ -e /tmp/team.info ]; then
> +        . /tmp/team.info
> +        IFACES+=" ${teamslaves}"
> +    fi
> +
>      if [ -e /tmp/vlan.info ]; then
>          . /tmp/vlan.info
>          IFACES+=" $phydevice"
> diff --git a/modules.d/40network/parse-team.sh b/modules.d/40network/parse-team.sh
> new file mode 100755
> index 0000000..182a5b7
> --- /dev/null
> +++ b/modules.d/40network/parse-team.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +#
> +# Format:
> +#       team=<teammaster>:<teamslaves>
> +#
> +#       teamslaves is a comma-separated list of physical (ethernet) interfaces
> +#
> +
> +# return if team already parsed
> +[ -n "$teammaster" ] && return
> +
> +# Check if team parameter is valid
> +if getarg team= >/dev/null ; then
> +    :
> +fi


I do not understand why there's above checking, looks like it's useless.
At the bottom of this file it's also checked.

Is it intend to do some checking about the user space tools existence in
if ... fi?

> +
> +# We translate list of slaves to space-separated here to mwke it easier to loop over them in ifup
> +parseteam() {
> +    local v=${1}:
> +    set --
> +    while [ -n "$v" ]; do
> +        set -- "$@" "${v%%:*}"
> +        v=${v#*:}
> +    done
> +
> +    unset teammaster teamslaves
> +    case $# in
> +    2)  teammaster=$1; teamslaves=$(str_replace "$2" "," " ") ;;
> +    *)  die "team= requires two parameters" ;;
> +    esac
> +}
> +
> +unset teammaster teamslaves
> +
> +if getarg team>/dev/null; then
> +    # Read team= parameters if they exist
> +    team="$(getarg team=)"
> +    if [ ! "$team" = "team" ]; then
> +        parseteam "$(getarg team=)"
> +    fi
> +    # Make it suitable for initscripts export
> +    echo "teammaster=$teammaster" > /tmp/team.info
> +    echo "teamslaves=\"$teamslaves\"" >> /tmp/team.info
> +    return
> +fi



-- 
Thanks
Dave
