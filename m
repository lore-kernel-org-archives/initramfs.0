From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] Avoid generating udev rules for vlan interface
Date: Mon, 21 May 2012 11:25:11 +0200
Message-ID: <4FBA09F7.4030003@redhat.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com> <1337591686-31875-3-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337591686-31875-3-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Am 21.05.2012 11:14, schrieb Cong Wang:
> From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Vlan device has the same mac address with its physical device,
> if we generate udev rules for vlan NIC too, its physical device
> name will be override.
> 
> I used an ugly hack in ifname-genrules.sh, don't know if we have any
> better ways to fix this?
> 
> Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  modules.d/40network/ifname-genrules.sh |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/40network/ifname-genrules.sh b/modules.d/40network/ifname-genrules.sh
> index e188c88..b36f167 100755
> --- a/modules.d/40network/ifname-genrules.sh
> +++ b/modules.d/40network/ifname-genrules.sh
> @@ -10,7 +10,11 @@ fi
>  {
>      for p in $(getargs ifname=); do
>          parse_ifname_opts $p
> -        printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", ATTR{type}=="1", NAME="%s"\n' "$ifname_mac" "$ifname_if"
> +        #Hack: vlan device has the same mac address with its physical device
> +        [ -e /tmp/vlan.info ] && source /tmp/vlan.info
> +        if [ "$ifname_if" != "$vlanname" ]; then
> +            printf 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="%s", ATTR{type}=="1", NAME="%s"\n' "$ifname_mac" "$ifname_if"
> +        fi
>      done
>  
>      # Rename non named interfaces out of the way for named ones.

Maybe one of the /sys attributes indicate, that it is a vlan interface?
