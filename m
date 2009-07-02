From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Remove modules dependency
Date: Thu, 02 Jul 2009 18:48:04 +0200
Message-ID: <4A4CE4C4.7020208@redhat.com>
References: <20090702090615.44C0E9D405C@zog.reactivated.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090702090615.44C0E9D405C-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/02/2009 11:06 AM, Daniel Drake wrote:
> This makes it possible to build a dracut initramfs without modules,
> where all needed kernel drivers are built into the kernel image.
> ---
>   dracut                 |    8 +++++---
>   modules.d/99base/check |    4 ++--
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/dracut b/dracut
> index f10af83..6bd2374 100755
> --- a/dracut
> +++ b/dracut
> @@ -135,9 +135,11 @@ echo $mods_to_load
>   ## final stuff that has to happen
>
>   # generate module dependencies for the initrd
> -if ! /sbin/depmod -a -b "$initdir" $kernel; then
> -    echo "\"/sbin/depmod -a $kernel\" failed."
> -    exit 1
> +if [ -d "$initdir/lib/modules/$kernel" ]; then
> +    if ! /sbin/depmod -a -b "$initdir" $kernel; then
> +        echo "\"/sbin/depmod -a $kernel\" failed."
> +        exit 1
> +    fi
>   fi
>
>   # make sure that library links are correct and up to date
> diff --git a/modules.d/99base/check b/modules.d/99base/check
> index 5c3bc51..1128497 100755
> --- a/modules.d/99base/check
> +++ b/modules.d/99base/check
> @@ -1,3 +1,3 @@
>   #!/bin/bash
> -[[ $1 = -d ]]&&  echo udev-rules kernel-modules
> -exit 0
> \ No newline at end of file
> +[[ $1 = -d ]]&&  echo udev-rules
> +exit 0

pushed
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
