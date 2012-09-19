From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] ismounted fix
Date: Wed, 19 Sep 2012 09:59:06 -0400
Message-ID: <20120919135906.GE31860@redhat.com>
References: <20120917100103.GA18640@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120917100103.GA18640-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Mon, Sep 17, 2012 at 06:01:03PM +0800, Dave Young wrote:
> 
> ismounted handles both find-by-dev and find-by-mnt, but there's two issues:
> 1. for find-by-dev, it use readlink to get the canonical dev name, but
>    lvm is different with other devices, the canonical name for lvm devices
>    are symlinks like /dev/mapper/vg-lv00
> 2. for nfs mounting, just use [ -b $dev ] is not enough, it need being handled
>    seperately.
> 
> Per Karel Zak's suggestion, findmnt util is suitable for this purpose, it
> handles these cases well, so just use findmnt instead of implement all the
> logic by ourselves. Thanks, Karel.

This patch looks reasonable to me. Harald, are you fine with it?

Vivek
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/99base/dracut-lib.sh   |   19 +------------------
>  modules.d/99base/module-setup.sh |    2 +-
>  2 files changed, 2 insertions(+), 19 deletions(-)
> 
> --- dracut.orig/modules.d/99base/dracut-lib.sh
> +++ dracut/modules.d/99base/dracut-lib.sh
> @@ -452,27 +452,10 @@ udevproperty() {
>      fi
>  }
>  
> -find_mount() {
> -    local dev mnt etc wanted_dev
> -    wanted_dev="$(readlink -e -q $1)"
> -    while read dev mnt etc; do
> -        [ "$dev" = "$wanted_dev" ] && echo "$dev" && return 0
> -    done < /proc/mounts
> -    return 1
> -}
> -
>  # usage: ismounted <mountpoint>
>  # usage: ismounted /dev/<device>
>  ismounted() {
> -    if [ -b "$1" ]; then
> -        find_mount "$1" > /dev/null && return 0
> -        return 1
> -    fi
> -
> -    while read a m a; do
> -        [ "$m" = "$1" ] && return 0
> -    done < /proc/mounts
> -    return 1
> +    findmnt "$1" > /dev/null
>  }
>  
>  wait_for_if_up() {
> --- dracut.orig/modules.d/99base/module-setup.sh
> +++ dracut/modules.d/99base/module-setup.sh
> @@ -13,7 +13,7 @@ depends() {
>  
>  install() {
>      local _d
> -    dracut_install mount mknod mkdir pidof sleep chroot \
> +    dracut_install mount mknod mkdir pidof sleep chroot findmnt\
>          sed ls flock cp mv dmesg rm ln rmmod mkfifo umount readlink setsid
>      inst $(command -v modprobe) /sbin/modprobe
>  
