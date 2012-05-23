From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-lib.sh: add find_mount()
Date: Wed, 23 May 2012 09:31:55 +0200
Message-ID: <20120523073155.GE14560@x2.net.home>
References: <1337723769-5412-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1337723769-5412-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, May 22, 2012 at 05:56:09PM -0400, Will Woods wrote:
> Add a function to find the mount point for a given device.
> ---
>  modules.d/99base/dracut-lib.sh |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index 8a54a7a..b6168df 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -402,6 +402,7 @@ udevproperty() {
>      fi
>  }
>  
> +# check if a given directory is a mounted filesystem
>  ismounted() {
>      while read a m a; do
>          [ "$m" = "$1" ] && return 0
> @@ -409,6 +410,16 @@ ismounted() {
>      return 1
>  }
>  
> +# find mountpoint for the given device
> +find_mount() {
> +    local wanted_dev="$1"; [ -b "$1" ] && wanted_dev=$(readlink -e -q "$1")
> +    local dev mnt etc
> +    while read -r dev mnt etc; do
> +        [ "$dev" = "$wanted_dev" ] && echo $mnt && return 0
> +    done < /proc/mounts
> +    return 1
> +}

 or

    findmnt -n --source $1 -o TARGET


-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com
