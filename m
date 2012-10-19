From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 40network/ifup.sh: do_static() and do_ipv6auto return
 0 if no errors.
Date: Fri, 19 Oct 2012 13:00:07 +0200
Message-ID: <508132B7.5090801@redhat.com>
References: <1350549808-8891-1-git-send-email-chaowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350549808-8891-1-git-send-email-chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 18.10.2012 10:43, schrieb WANG Chao:
> Commit a0be1ed removes some lines from do_static() and do_ipv6auto().
> 
> When $hostname is empty, do_static() and do_ipv6auto() will return 1
> and fails to run setup_net at the last of ifup.sh
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/40network/ifup.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
> index 95289c9..db233de 100755
> --- a/modules.d/40network/ifup.sh
> +++ b/modules.d/40network/ifup.sh
> @@ -88,6 +88,8 @@ do_ipv6auto() {
>      wait_for_if_up $netif
>  
>      [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
> +
> +    return 0
>  }
>  
>  # Handle static ip configuration
> @@ -108,6 +110,8 @@ do_static() {
>  
>      [ -n "$gw" ] && echo ip route add default via $gw dev $netif > /tmp/net.$netif.gw
>      [ -n "$hostname" ] && echo "echo $hostname > /proc/sys/kernel/hostname" > /tmp/net.$netif.hostname
> +
> +    return 0
>  }
>  
>  # loopback is always handled the same way
> 

https://admin.fedoraproject.org/updates/dracut-024-5.git20121019.fc18
