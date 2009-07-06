From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC ONLY 1/5] netroot: remove unused hook
Date: Mon, 6 Jul 2009 14:56:17 +0200
Message-ID: <4A51F471.7040100@bfh.ch>
References: <cover.1246656269.git.dave@thedillows.org> <bd4d79bc048ad3944156f86eafb62cf4bc29b1f9.1246656269.git.dave@thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bd4d79bc048ad3944156f86eafb62cf4bc29b1f9.1246656269.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

David Dillow wrote:
> The netroot hook is no longer used.
> ---
> This is a left over from before Philippe's multinic work.

I intentionally left the hook in there to give other modules the option 
   to add a hook to between successful and completed interface 
configuration and actual mount/login calls.

Most of the stuff that I was thinking about that could go in there can 
now go inside pre-mount. But if someone needs port authentication or 
similar stuff, this needs to run between interface configuration and 
mount/login. I think the hook should stay.

> 
>  dracut                      |    2 +-
>  modules.d/40network/netroot |    3 ---
>  2 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/dracut b/dracut
> index f10af83..c71cc63 100755
> --- a/dracut
> +++ b/dracut
> @@ -102,7 +102,7 @@ if [[ -f $outfile && ! $force ]]; then
>      exit 1
>  fi
>  
> -hookdirs="cmdline pre-udev pre-trigger netroot pre-mount pre-pivot mount emergency"
> +hookdirs="cmdline pre-udev pre-trigger pre-mount pre-pivot mount emergency"
>  
>  readonly initdir=$(mktemp -d -t initramfs.XXXXXX)
>  trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
> diff --git a/modules.d/40network/netroot b/modules.d/40network/netroot
> index f719d93..645bbba 100755
> --- a/modules.d/40network/netroot
> +++ b/modules.d/40network/netroot
> @@ -92,9 +92,6 @@ done
>  [ -e /tmp/net.$netif.hostname ]    && . /tmp/net.$netif.hostname
>  [ -e /tmp/net.$netif.resolv.conf ] && cp -f /tmp/net.$netif.resolv.conf /etc/resolv.conf
>  
> -# Source netroot hooks before we start the handler
> -source_all netroot
> -
>  # Run the handler; don't store the root, it may change from device to device
>  # XXX other variables to export?
>  if $handler $netif $netroot $NEWROOT; then
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
