From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH cleanups] livenet: simplify writing net.ifaces
Date: Wed, 26 Sep 2012 11:52:28 +0200
Message-ID: <5062D05C.40301@redhat.com>
References: <1348589458-13212-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348589458-13212-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 25.09.2012 18:10, schrieb Will Woods:
> commit db2b12f removed the rd.neednet argument and uses /tmp/net.ifaces
> instead. This means we don't need to mess with CMDLINE.
> ---
>  modules.d/90livenet/parse-livenet.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/modules.d/90livenet/parse-livenet.sh b/modules.d/90livenet/parse-livenet.sh
> index 365eca1..0e61870 100755
> --- a/modules.d/90livenet/parse-livenet.sh
> +++ b/modules.d/90livenet/parse-livenet.sh
> @@ -9,10 +9,7 @@
>  updates=$(getarg live.updates=)
>  if [ -n "$updates" ]; then
>      # make sure network comes up even if we're doing a local live device
> -    if [ -z "$netroot" ]; then
> -	echo > /tmp/net.ifaces
> -	unset CMDLINE
> -    fi
> +    [ -z "$netroot" ] && >> /tmp/net.ifaces
>      echo "$updates" > /tmp/liveupdates.info
>      echo '[ -e /tmp/liveupdates.done ]' > \
>          $hookdir/initqueue/finished/liveupdates.sh
> 

but commit 48dba7f9ace186871528eb4d83cd96e92e853c6c added it again :)
