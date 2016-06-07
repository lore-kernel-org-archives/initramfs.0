From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] network/net-lib.sh: delete duplicated DNS items from
 "/etc/resolv.conf"
Date: Tue, 7 Jun 2016 11:16:04 +0200
Message-ID: <17728b53-1a4c-91bb-734e-9fb743ccab1b@redhat.com>
References: <1461665111-7385-1-git-send-email-xlpang@redhat.com>
 <1461665111-7385-2-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461665111-7385-2-git-send-email-xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kdump-team-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 26.04.2016 um 12:05 schrieb Xunlei Pang:
> Users can pass the DNS information throught "nameserver=" cmdline,
> there maybe duplicated inputs.
> 
> "/etc/resolv.conf" have some restrictions on the number of DNS items
> effective, so make sure that this file contains no duplicated items.
> 
> We achieve this by simply making the file have no duplicated lines.
> 
> Signed-off-by: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/module-setup.sh | 2 +-
>  modules.d/40network/net-lib.sh      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/40network/module-setup.sh b/modules.d/40network/module-setup.sh
> index 4bf93cc..53b4b60 100755
> --- a/modules.d/40network/module-setup.sh
> +++ b/modules.d/40network/module-setup.sh
> @@ -23,7 +23,7 @@ installkernel() {
>  # called by dracut
>  install() {
>      local _arch _i _dir
> -    inst_multiple ip arping dhclient sed
> +    inst_multiple ip arping dhclient sed awk
>      inst_multiple -o ping ping6
>      inst_multiple -o brctl
>      inst_multiple -o teamd teamdctl teamnl
> diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
> index 31f1a56..005ad1b 100755
> --- a/modules.d/40network/net-lib.sh
> +++ b/modules.d/40network/net-lib.sh
> @@ -120,7 +120,7 @@ setup_net() {
>      [ -e /tmp/dhclient.$netif.dhcpopts ] && . /tmp/dhclient.$netif.dhcpopts
>      # set up resolv.conf
>      [ -e /tmp/net.$netif.resolv.conf ] && \
> -        cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
> +        awk '!array[$0]++' /tmp/net.$netif.resolv.conf > /etc/resolv.conf
>      [ -e /tmp/net.$netif.gw ]            && . /tmp/net.$netif.gw
>  
>      # add static route
> 

Thanks! Pushed, although replaced awk with a shell function
