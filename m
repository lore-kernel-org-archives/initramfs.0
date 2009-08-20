From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 20/18] Abstract out vol_id vs. blkid usage
Date: Thu, 20 Aug 2009 11:44:20 +0200
Message-ID: <20090820094420.GA6653@nb.net.home>
References: <59c88f499f404429ea331252bd6ad8c9d537f7d3.1250738566.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59c88f499f404429ea331252bd6ad8c9d537f7d3.1250738566.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Aug 19, 2009 at 10:25:01PM -0500, Victor Lowther wrote:
> Since different distros may or may not use vol_id in udev, and blkid
> is generally replacing vol_id, abstract them out into a function which
> tries to use vol_id first and blkid second, on the assumption that
> blkid can take over for vol_id if vol_id is no longer there.
> ---
>  dracut-functions         |   11 +++++++++++
>  modules.d/90crypt/check  |    2 +-
>  modules.d/90dmraid/check |    2 +-
>  modules.d/90lvm/check    |    4 ++--
>  modules.d/90mdraid/check |    2 +-
>  5 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/dracut-functions b/dracut-functions
> index 1df2045..655d311 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -48,6 +48,17 @@ derror() {
>      [[ -w $dracutlogfile ]] && echo "E: $@" >>"$dracutlogfile"
>  }
>  
> +get_fs_type() (
> +    if [[ -x /lib/udev/vol_id ]]; then
> +	eval /usr/udev/vol_id --export $1
> +	echo $ID_FS_TYPE
> +    elif find_binary >/dev/null; then
> +	blkid -o value -s TYPE $1

 This is to expensive, the blkid(8) supports two modes: low-level and
 high-level. The low-level mode together with "-o udev" is replacement
 of vol_id.
 
 get_fs_type() (

    if [[ -x /lib/udev/vol_id ]]; then
        eval /usr/udev/vol_id --export $1
    elif find_binary >/dev/null; then
        eval blkid -p -o udev $1
    else
        return 1
    fi
    echo $ID_FS_TYPE
 )
 
> -is_crypt() { /lib/udev/vol_id /dev/block/$1 |grep -q crypto_LUKS; }
> +is_crypt() { [[ $(get_fs_type /dev/block/$1) = crypto_LUKS ]]; }

> -is_dmraid() { /lib/udev/vol_id /dev/block/$1 |grep -v linux_raid_member | \
> +is_dmraid() { get_fs_type /dev/block/$1 |grep -v linux_raid_member | \
>      grep -q _raid_member; }

> -is_lvm() { /lib/udev/vol_id /dev/block/$1 |grep -q LVM2_member; }
> +is_lvm() { [[ $(get_fs_type /dev/block/$1) = LVM2_member ]]; }

> -is_mdraid() { /lib/udev/vol_id /dev/block/$1 |egrep -q '(linux|isw)_raid'; }
> +is_mdraid() { get_fs_type /dev/block/$1 |egrep -q '(linux|isw)_raid'; }

 Note that blkid -p and vol_id allows to probe for raids only. It
 should be faster than probe always for all filesystems.

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
