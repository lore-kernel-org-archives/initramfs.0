From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add a check file for multipath.
Date: Thu, 04 Mar 2010 13:42:06 +0100
Message-ID: <4B8FAA9E.4030106@redhat.com>
References: <4B59CAA9.3030301@redhat.com> <1264175800-6870-1-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264175800-6870-1-git-send-email-pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: 
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/22/2010 04:56 PM, Peter Jones wrote:
> If multipath isn't installed, don't use it.  If we're in hostonly mode,
> only install the multipath module if it's used for / .  Otherwise, if
> the user was dumb enough to install it, they get it during bootup.
> ---
>   modules.d/90multipath/check |   27 +++++++++++++++++++++++++++
>   1 files changed, 27 insertions(+), 0 deletions(-)
>   create mode 100755 modules.d/90multipath/check
>
> diff --git a/modules.d/90multipath/check b/modules.d/90multipath/check
> new file mode 100755
> index 0000000..d0cad4c
> --- /dev/null
> +++ b/modules.d/90multipath/check
> @@ -0,0 +1,27 @@
> +#!/bin/bash
> +
> +# if there's no multipath binary, no go.
> +which multipath>/dev/null 2>&1 || exit 1
> +
> +[[ $1 = -d ]]&&  exit 0
> +
> +. $dracutfunctions
> +[[ $debug ]]&&  set -x
> +
> +is_mpath() {
> +    [ -e /sys/dev/block/$1/dm/uuid ] || return 1
> +    [[ $(cat /sys/dev/block/$1/dm/uuid) =~ ^mpath- ]]&&  return 0
> +    return 1
> +}
> +
> +# If we're in hostonly mode, do mpath if we appear to be using it for /
> +if [[ $hostonly ]]; then
> +    rootdev=$(find_root_block_device)
> +    if [[ $rootdev ]]; then
> +        check_block_and_slaves is_mpath "$rootdev"&&  exit 0
> +    fi
> +    exit 1
> +fi
> +
> +# the user installed it, they get it...
> +exit 0


pushed, long time ago..

commit 3d45f9bba994ecd99d8bb7378c7a4dbac1d141fe
