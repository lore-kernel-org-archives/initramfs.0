From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 08/10] put back the nfs mount in the udev event
Date: Mon, 6 Jul 2009 10:39:17 +0200
Message-ID: <4A51B835.1050302@bfh.ch>
References: <1246639520-3094-1-git-send-email-harald@redhat.com> <1246639520-3094-9-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246639520-3094-9-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Harald Hoyer wrote:
> it solves the following case:
> 
> root=/dev/nfs nfsroot=server:/path
> 
> - the server could be reachable on any interface
> - any interface can get an IP by dhcp
> - only one IP is allowed to mount the root

Thanks.

For the record, some further explanations:

If netroot is in "guess-the-interface-mode", netroot calls the
root-handler for each interface that has a useable IP configuration. If
the root-handler fails, the interface is deconfigured so that the next
interface netroot tries does not suffer from side-effects.

This is accomplished by depending on mount-handlers having an exit-code
telling us whether mounting (would) succeed or not. For devicefile based 
network mounts, this isn't a problem since we need to call some sort of
client-utility that makes the device nodes available (or not if
contacting the server fails). For network-filesystems like NFS that do
not use devicefiles, the actual mount call is needed.


> ---
>  modules.d/95nfs/nfsroot |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
> index 5f5b08f..0add977 100755
> --- a/modules.d/95nfs/nfsroot
> +++ b/modules.d/95nfs/nfsroot
> @@ -142,9 +142,9 @@ if [ "$nfs" = "nfs4" ]; then
>      [ -z "$(pidof rpc.idmapd)" ] && rpc.idmapd
>  
>      # XXX Should we loop here?
> -    echo mount -t nfs4 -o$options${nfslock+,$nfslock} \
> -	$server:$path $NEWROOT > /mount/01-$$-nfs4.sh
> -    [ -e /dev/root ] || >/dev/root
> +    mount -t nfs4 -o$options${nfslock+,$nfslock} \
> +	$server:$path $NEWROOT \
> +	&& { [ -e /dev/root ] || >/dev/root ; }
>  else
>      # NFSv{2,3} doesn't support using locks as it requires a helper to transfer
>      # the rpcbind state to the new root
> @@ -152,7 +152,6 @@ else
>          warn "Locks unsupported on NFSv{2,3}, using nolock" 1>&2
>  
>      # XXX Should we loop here?
> -    echo mount -t nfs -o$options${options:+,}nolock $server:$path $NEWROOT \
> -        > /mount/01-$$-nfs.sh
> -    [ -e /dev/root ] || >/dev/root
> +    mount -t nfs -o$options${options:+,}nolock $server:$path $NEWROOT \
> +	&& { [ -e /dev/root ] || >/dev/root ; }
>  fi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
