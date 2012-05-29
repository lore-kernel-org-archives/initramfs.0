From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add anaconda-style option parsing to ip_to_var
Date: Tue, 29 May 2012 11:41:28 +0200
Message-ID: <4FC499C8.1080408@redhat.com>
References: <1337725867-9922-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337725867-9922-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 23.05.2012 00:31, schrieb Will Woods:
> Anaconda used arguments of the form:
> 
>   ip=<ip> gateway=<gw> netmask=<nm>
> 
> for static IP configuration. So if we get a value for "ip" that's an IP
> address, look for gateway= and netmask= and related args to fill in the
> ip config vars.
> ---
>  modules.d/40network/net-lib.sh |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
> index d6adda9..75ad5e3 100644
> --- a/modules.d/40network/net-lib.sh
> +++ b/modules.d/40network/net-lib.sh
> @@ -266,4 +266,18 @@ ip_to_var() {
>          4)  dev=$1; autoconf=$2; mtu=$3; macaddr=$4 ;;
>          *)  ip=$1; srv=$2; gw=$3; mask=$4; hostname=$5; dev=$6; autoconf=$7; mtu=$8; macaddr=$9 ;;
>      esac
> +    # anaconda-style argument cluster
> +    if strstr "$autoconf" "*.*.*.*"; then
> +        ip="$autoconf"
> +        gw=$(getarg gateway=)
> +        mask=$(getarg netmask=)
> +        hostname=$(getarg hostname=)
> +        dev=$(getarg ksdevice=)
> +        autoconf="none"
> +        mtu=$(getarg mtu=)
> +        case "$dev" in
> +            # ignore fancy values for ksdevice=XXX
> +            link|bootif|BOOTIF|ibft|*:*:*:*:*:*) dev="" ;;
> +        esac
> +    fi
>  }

pushed
