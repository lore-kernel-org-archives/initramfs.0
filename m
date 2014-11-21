From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 33/33] nfs: Add ip=... and root=nfs... parameters to internal
 dracut
Date: Fri, 21 Nov 2014 10:26:30 +0100
Message-ID: <546F0546.8080007@redhat.com>
References: <1416495428-36978-1-git-send-email-trenn@suse.de> <1416495428-36978-34-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-34-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: hare-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 20.11.2014 15:57, Thomas Renninger wrote:
>  cmdline
> 
> If the rootfs is an nfs mount, also know as nfsroot, add the correct
> parameter to the dracut cmdline.
> 
> Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
> ---
>  modules.d/95nfs/module-setup.sh | 46 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/modules.d/95nfs/module-setup.sh b/modules.d/95nfs/module-setup.sh
> index e1340b3..41c6ef7 100755
> --- a/modules.d/95nfs/module-setup.sh
> +++ b/modules.d/95nfs/module-setup.sh
> @@ -14,7 +14,6 @@ check() {
>          done
>          return 255
>      }
> -
>      return 0
>  }
>  
> @@ -29,14 +28,56 @@ installkernel() {
>      instmods nfs sunrpc ipv6 nfsv2 nfsv3 nfsv4 nfs_acl nfs_layout_nfsv41_files
>  }
>  
> +cmdline() {
> +    local nfs_device
> +    local nfs_options
> +    local nfs_root
> +    local nfs_address
> +    local lookup
> +    local ifname
> +
> +    ### nfsroot= ###
> +    nfs_device=$(findmnt -t nfs4 -n -o SOURCE /)
> +    if [ -n "$nfs_device" ];then
> +        nfs_root="root=nfs4:$nfs_device"
> +    else
> +        nfs_device=$(findmnt -t nfs -n -o SOURCE /)
> +        [ -z "$nfs_device" ] && return
> +        nfs_root="root=nfs:$nfs_device"
> +    fi
> +    nfs_options=$(findmnt -t nfs4,nfs -n -o OPTIONS /)
> +    [ -n "$nfs_options" ] && nfs_root="$nfs_root:$nfs_options"
> +    echo "$nfs_root"
> +
> +    ### ip= ###
> +    if [[ $nfs_device = [0-9]*\.[0-9]*\.[0-9]*.[0-9]* ]] || [[ $nfs_device = \[.*\] ]]; then
> +        nfs_address="$nfs_device"
> +    else
> +        lookup=$(host $(echo ${nfs_device%%:*})| head -n1)
> +        nfs_address=${lookup##* }
> +    fi
> +    ifname=$(ip -o route get to $nfs_address | sed -n 's/.*dev \([^ ]*\).*/\1/p')
> +    if [ -e /sys/class/net/$ifname/address ] ; then
> +        ifmac=$(cat /sys/class/net/$ifname/address)
> +        printf 'ifname=%s:%s ' ${ifname} ${ifmac}
> +    fi
> +
> +    printf 'ip=%s:static\n' ${ifname}
> +}
> +
>  # called by dracut
>  install() {
>      local _i
>      local _nsslibs
>      inst_multiple -o portmap rpcbind rpc.statd mount.nfs \
> -        mount.nfs4 umount rpc.idmapd sed /etc/netconfig
> +        mount.nfs4 umount rpc.idmapd sed /etc/netconfig host sed

Why "host" and "sed" ?? Just because it's used in cmdline() does not mean it
has to be installed in the initramfs?
