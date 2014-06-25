From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] write-ifcfg.sh: Don't overwrite network config in root
 filesystem
Date: Wed, 25 Jun 2014 11:51:10 +0200
Message-ID: <53AA9B8E.7020801@redhat.com>
References: <alpine.LFD.2.02.1406211239250.1876@bbs.intern>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.02.1406211239250.1876-GinJ0NHkz1PSbTvUbH3RCA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 21.06.2014 12:40, Gerhard Wiesinger wrote:
> This patch adds the possibility to keep the original
> network configuration specified in the root filesystem.
> This is necessary in situations with dual stack IPv4 and
> IPv6 configurations or different kind on nameservers
> (e.g. public ones at boot time, running a dns server
> on localhost later on).
> 
> Keeping original configuration can be activated by:
> networkstatic=yes
> on the kernel boot command line.
> 
> Signed-off-by: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>
> ---
>  modules.d/45ifcfg/write-ifcfg.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/modules.d/45ifcfg/write-ifcfg.sh b/modules.d/45ifcfg/write-ifcfg.sh
> index 803ae8e..033abe5 100755
> --- a/modules.d/45ifcfg/write-ifcfg.sh
> +++ b/modules.d/45ifcfg/write-ifcfg.sh
> @@ -277,7 +277,10 @@ echo "files /etc/sysconfig/network-scripts" >>
> /run/initramfs/rwtab
>  echo "files /var/lib/dhclient" >> /run/initramfs/rwtab
>  {
>      cp /tmp/net.* /run/initramfs/
> -    cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/resolv.conf
> -    copytree /tmp/ifcfg /run/initramfs/state/etc/sysconfig/network-scripts
> +    networkstatic="$(getarg networkstatic=)"
> +    if [ -z "${networkstatic}" ]; then
> +        cp /tmp/net.$netif.resolv.conf /run/initramfs/state/etc/resolv.conf
> +        copytree /tmp/ifcfg /run/initramfs/state/etc/sysconfig/network-scripts
> +    fi
>      cp /tmp/ifcfg-leases/* /run/initramfs/state/var/lib/dhclient
>  } > /dev/null 2>&1

I don't understand this. It only copies to /run/initramfs. If you want to keep
your original network configuration, just don't copy over the files from
/run/initramfs to your root filesystem.
