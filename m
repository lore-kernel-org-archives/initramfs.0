From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ifup: do not dhcp on network interface of secondary stack
Date: Fri, 13 Sep 2013 17:12:21 +0200
Message-ID: <52332B55.7050404@gmail.com>
References: <20130913142844.GD2070@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5OnAMJvq4ZlJ3F4mmF1W/VLXQlNBuxgL+eiVwedz/e4=;
        b=KpD222yxhvbpp8UqVZjo3k2p1k5nPZ+6UrNnstNPW/k5e48HSJYcqw7qaJ/gajF7TQ
         uHdLHb5LSqG3fe5XdJwq07SAKz7gnrCJ5nZ0zbLWUlJwhWxZumDe/Hg22iwA8UVcFHtO
         6XwUNH0CLQPlVSQ5UAImNDS4bMt/WlFQkIRA1Yx3ikuokkNFq7QC1kH2nF5pzK/wAhVZ
         GrUqUaNHJqkT/3kG+5bT08gLODDmxnPyT/AJ/7NNMUsB0I/Wwergq2gQk7MdSXsbQ3mp
         5AP2vjDiYVSts6+K0agyZL1Fdf9L4I91fngdR/OFGBy2WmT3x+S7PIRJbw3JcDLJ1bod
         /fSg==
In-Reply-To: <20130913142844.GD2070-UAAZkH0G2Ts1naxU1pY8ZxcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/13/2013 04:28 PM, WANG Chao wrote:
> Configure cmdline to:
>  ip=br0:dhcp bridge=br0:bond0 bond=bond0:eth0
> 
> By default ifup bond0 will run dhcp on bond0, which is wrong. bond0
> isn't the top interface. we should really run dhcp on br0.
> 
> So if we ifup an network interface on secondary stack, we should not
> dhcp. Fix this issue with this patch.
> ---
>  modules.d/40network/ifup.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
> index 3261647..9f6f449 100755
> --- a/modules.d/40network/ifup.sh
> +++ b/modules.d/40network/ifup.sh
> @@ -336,6 +336,13 @@ for p in $(getargs ip=); do
>      exit 0
>  done
>  
> +# netif isn't the top stack? Then we should exit here.
> +# eg. netif is bond0. br0 is on top of it. dhcp br0 is correct but dhcp
> +#     bond0 doesn't make sense.
> +if [ -n "$DO_BOND_SETUP" -o -n "$DO_TEAM_SETUP" -o -n "$DO_VLAN_SETUP" ]; then
> +    exit 0
> +fi
> +
>  # no ip option directed at our interface?
>  if [ ! -e /tmp/setup_net_${netif}.ok ]; then
>      do_dhcp -4
> 

pushed! thanks!
