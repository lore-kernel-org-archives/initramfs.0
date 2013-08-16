From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] network: also wait for ethernet interfaces to setup
Date: Fri, 16 Aug 2013 10:20:43 +0200
Message-ID: <520DE0DB.1000600@gmail.com>
References: <20130812084352.GA3445@dhcp16-109.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IWb7rrIeV7ihjaX7pAzJnUf2XteJat7DnbiVNu8CgB4=;
        b=0iCnLL8iKFhbUJa58AdgGQXGZT6MWgY1qr61bfQ2nFMerfnAaVv3y+JaZHG4umi3Ib
         g+L089+thjAX/Qbpx9c04s3kEe/OCF9TlnNY83+X31PqMfXx3LrBQmO2sRD3/jAms5KI
         LeFoeFrqnhDDYUZ01DyZVzKFYPbHjeccnFLpLvjtGGFqxUV2wnausQmDfIsOtk7XWcjr
         btFwmUefL2tcK7LaPkKRpqM2OUS+Bsci11l7a3/+RbCpDTb4HcXc3jivaYOgBOk48+77
         zfMFqqiT4Sq2bhiyosnfZGQ6nlP3KtM2Fd1JRFSYFp48NyXC/v5mXuhKtN8nQyUdlTgF
         6f7A==
In-Reply-To: <20130812084352.GA3445-ALckc1lQpMDv8MId6FTy5BcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/12/2013 10:43 AM, WANG Chao wrote:
> We only wait for master interfaces for bridge/bonding/team/vlan case.
> If none of these complex network is configured, we should wait for
> ethernet interface (bootdev) instead.
> ---
>  modules.d/40network/net-genrules.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/modules.d/40network/net-genrules.sh b/modules.d/40network/net-genrules.sh
> index f6b7d9a..31cd1e6 100755
> --- a/modules.d/40network/net-genrules.sh
> +++ b/modules.d/40network/net-genrules.sh
> @@ -74,7 +74,13 @@ command -v fix_bootif >/dev/null || . /lib/net-lib.sh
>          done
>          echo 'LABEL="net_end"'
>  
> -        for iface in $MASTER_IFACES; do
> +        if [ -n "$MASTER_IFACES" ]; then
> +            wait_ifaces=$MASTER_IFACES
> +        else
> +            wait_ifaces=$IFACES
> +        fi
> +
> +        for iface in $wait_ifaces; do
>              if [ "$bootdev" = "$iface" ] || [ "$NEEDNET" = "1" ]; then
>                  echo "[ -f /tmp/setup_net_${iface}.ok ]" >$hookdir/initqueue/finished/wait-$iface.sh
>              fi
> 

Thanks!

pushed
