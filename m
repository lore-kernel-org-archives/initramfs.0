From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4] Arch handles loading modules from udev in a somewhat
 customized manner.
Date: Wed, 09 Jun 2010 17:37:17 +0200
Message-ID: <4C0FB52D.6090700@redhat.com>
References: <4b22ffbe9ef3f55ac4fad54bd58f9cf9fc345b22.1275480426.git.victor.lowther@gmail.com> <f56b47cd2bdff0abe36728917c893c89c3dff406.1275480426.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f56b47cd2bdff0abe36728917c893c89c3dff406.1275480426.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/02/2010 02:07 PM, Victor Lowther wrote:
> ---
>   modules.d/95udev-rules/install         |    1 +
>   modules.d/95udev-rules/load-modules.sh |    6 ++++++
>   2 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/modules.d/95udev-rules/install b/modules.d/95udev-rules/install
> index 23693fe..e89acb5 100755
> --- a/modules.d/95udev-rules/install
> +++ b/modules.d/95udev-rules/install
> @@ -46,6 +46,7 @@ pcmcia-check-broken-cis \
>       [ -e /lib/udev/$i ]&&  dracut_install /lib/udev/$i
>   done
>
> +[ -f /etc/arch-release ]&&  inst "$moddir/load-modules.sh" /lib/udev/load-modules.sh
>
>   if ldd $(find_binary udevd) |grep -q /lib64/; then
>       dracut_install /lib64/libnss_files*
> diff --git a/modules.d/95udev-rules/load-modules.sh b/modules.d/95udev-rules/load-modules.sh
> new file mode 100755
> index 0000000..b592964
> --- /dev/null
> +++ b/modules.d/95udev-rules/load-modules.sh
> @@ -0,0 +1,6 @@
> +#!/bin/sh
> +# Implement blacklisting for udev-loaded modules
> +
> +modprobe -b "$@"
> +
> +# vim: set et ts=4:

pushed
