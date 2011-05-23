From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/5] 95fstab-sys: use det_fs and wrap_fsck
Date: Tue, 24 May 2011 01:05:07 +0200
Message-ID: <20110523230507.GC2659@nb.net.home>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info> <1305904167-14199-4-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1305904167-14199-4-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, May 20, 2011 at 05:09:25PM +0200, Michal Soltys wrote:
> +fstab_mount() {
> +    local _dev _mp _fs _opts _dump _pass _rest
>      test -e "$1" || return 1
>      info "Mounting from $1"
> -    while read dev mp type opts rest; do
> -	[ -z "${dev%%#*}" ]&& continue # Skip comment lines
> -	mount -v -t $type -o $opts $dev $NEWROOT/$mp
> -    done < $1 | vinfo
> +    while read _dev _mp _fs _opts _dump _pass _rest; do

 How does this code handle encoding in fstab? (e.g. /path/foo\x40bar)

> +        [ -z "${_dev%%#*}" ] && continue # Skip comment lines
> +        if [ ! -e "$_dev" ]; then
> +            warn "Device $_dev doesn't exist, skipping mount."
> +            continue
> +        fi
> +        if [ "$_pass" -gt 0 ] && ! strstr "$_opts" _netdev; then
> +            wrap_fsck "$_dev"
> +        fi
> +        _fs=$(det_fs "$_dev" "$_fs" /etc/fstab.sys)
> +        info "Mounting $_dev"
> +        mount -v -t $_fs -o $_opts $_dev $NEWROOT/$_mp 2>&1 | vinfo
> +    done < $1

 It means that fsck is not running in parallel if you have more
 devices in /ect/fstab.sys. Is it expected?

 It would be better to call one fsck instance for all devices
 
    fsck -T /dev/sda1 /dev/sda2 /dev/sdb1

 or use the "-l" option for more instances.

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com
