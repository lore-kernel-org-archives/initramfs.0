From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add busybox shell replacements module
Date: Wed, 10 Nov 2010 15:50:31 +0100
Message-ID: <4CDAB137.6020204@redhat.com>
References: <20101108194933.89BE19D401B@zog.reactivated.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101108194933.89BE19D401B-k/4jFdqg8LLlyo9zxV8I99HuzzzSOjJt@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/08/2010 08:49 PM, Daniel Drake wrote:
> On the OLPC XO-1, there is a noticable delay during boot while the
> initramfs is loaded from disk and uncompressed, so we have an interest
> in making it small. We are also pushed for disk space.
>
> Using busybox instead of all the regular tools saves a lot of space.
> I have not tried every module but the basics are working with busybox's
> replacements. Our initramfs is now down to 1.9mb.
> ---
>   modules.d/05busybox/check   |    2 ++
>   modules.d/05busybox/install |   16 ++++++++++++++++
>   2 files changed, 18 insertions(+), 0 deletions(-)
>   create mode 100755 modules.d/05busybox/check
>   create mode 100755 modules.d/05busybox/install
>
> diff --git a/modules.d/05busybox/check b/modules.d/05busybox/check
> new file mode 100755
> index 0000000..06bd986
> --- /dev/null
> +++ b/modules.d/05busybox/check
> @@ -0,0 +1,2 @@
> +#!/bin/bash
> +exit 0
> diff --git a/modules.d/05busybox/install b/modules.d/05busybox/install
> new file mode 100755
> index 0000000..5252d03
> --- /dev/null
> +++ b/modules.d/05busybox/install
> @@ -0,0 +1,16 @@
> +#!/bin/bash
> +
> +inst busybox /sbin/busybox
> +
> +# List of shell programs that we use in other official dracut modules, that
> +# must be supported by the busybox installed on the host system
> +progs="echo grep usleep [ rmmod insmod mount uname umount setfont kbd_mode stty gzip bzip2 chvt readlink blkid dd losetup tr sed seq ps more cat rm free ping netstat vi ping6 fsck ip hostname basename mknod mkdir pidof sleep chroot ls cp mv dmesg mkfifo less ln modprobe"
> +
> +# FIXME: switch_root should be in the above list, but busybox version hangs
> +# (using busybox-1.15.1-7.fc14.i686 at the time of writing)
> +
> +for i in $progs; do
> +	path=$(find_binary "$i")
> +	ln -s /sbin/busybox "$initdir/$path"
> +done
> +

pushed
