From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] ismounted fix
Date: Mon, 17 Sep 2012 17:23:22 +0800
Message-ID: <20120917092322.GA16406@darkstar.nay.redhat.com>
References: <20120917080034.GA15753@darkstar.nay.redhat.com>
 <20120917084322.GF13016@x2.net.home>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120917084322.GF13016-s5vVilr7EKH/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Hi,

Thanks for the comment

On Mon, Sep 17, 2012 at 10:43:22AM +0200, Karel Zak wrote:
> On Mon, Sep 17, 2012 at 04:00:34PM +0800, Dave Young wrote:
> > 
> > ismounted handles both find-by-dev and find-by-mnt, but there's two issues:
> > 1. for find-by-dev, it use readlink to get the canonical dev name, but
> >    lvm is different with other devices, lvm use the symlinks in /proc/mounts
> >    without converting to canonical name.
> 
> Well, dm-N are private DM names and should not be used anywhere in
> userspace. The official device name is /dev/mapper/<name> where the
> <name> is exported by /sys/block/dm-<N>/dm/name. You need something
> like:
> 
>  cn_device=$(cat /sys/block/${device##/dev/}/dm/name)

Good to know.

> 
> > 2. for nfs mounting, just use [ -b $dev ] is not enough, it need being handled
> >    seperately.
> > 
> > grep all current ismounted() user, they are all ismounted <mntdir>, so change
> > to split the ismounted <dev> to another function dev_ismounted. Afterwards
> > ismounted() should be converted to dir_ismounted.
> > 
> > in dev_ismounted, fix the dev name issue by using maj:min to comparing with
> > items in /proc/self/mountinfo. OTOH for nfs share just compare with the 1st
> > field of /proc/mounts.
> 
> Do you know about findmnt(1)? It's smaller than stat(1) and provides
> all necessary functionality ;-)

great! I never know this findmnt..

findmnt works well with both nfs and lvm, replace these logic with findmnt
looks more elegant. Will update this patch with findmnt.

> 
> > -find_mount() {
> > -    local dev mnt etc wanted_dev
> > -    wanted_dev="$(readlink -e -q $1)"
> > +# get_maj_min <device>
> > +# Prints the major and minor of a device node.
> > +# Example:
> > +# $ get_maj_min /dev/sda2
> > +# 8:2
> > +get_maj_min() {
> > +    local _dev
> > +    _dev=$(stat -L -c '$((0x%t)):$((0x%T))' "$1" 2>/dev/null)
> > +    _dev=$(eval "echo $_dev")
> > +    echo $_dev
> > +}
> > +
> > +find_mount_point() {
> > +    local _x majmin mnt wanted_majmin
> > +    wanted_majmin="$(get_maj_min $1)"
> > +    while read _x _x majmin _x mnt _x; do
> > +        [ "$majmin" = "$wanted_majmin" ] && echo "$mnt" && return 0
> 
> You should not expect that devno returned by stat(1) matches with
> devno in /proc/self/mountinfo. For example btrfs uses some pseudo-devnos
> (don't forget that btrfs is not strictly per-device filesystem):
> 
>   # ls -la /dev/sdb
>   brw-rw---- 1 root disk 8, 16 Sep 17 10:24 /dev/sdb
>                          ^^^^^
> 
>   # grep /dev/sdb /proc/self/mountinfo 
>   56 21 0:44 / /mnt/test rw,relatime - btrfs /dev/sdb rw,ssd,nospace_cache
>         ^^^^

Thanks for reminding, btrfs is special especially with multi devices.
I remember this devnos confuse lilo as well in my slackware so I have to use
a boot partition.

> 
> It's probably better to use a canonical device name.
> 
>   # findmnt /dev/sdb 
>   TARGET    SOURCE   FSTYPE OPTIONS
>   /mnt/test /dev/sdb btrfs  rw,relatime,ssd,nospace_cache
> 
> 
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>  http://karelzak.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
