From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 11:40:19 -0500
Message-ID: <20090206164019.GD552@redhat.com>
References: <20090205224808.18610.14957.stgit@dwillia2-linux.ch.intel.com> <20090205224920.18610.63979.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090205224920.18610.63979.stgit-p8uTFz9XbKjBPTuBivz2/GFmcEqAMTzPQQ4Iyu8u01E@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neilb-l3A5Bk7waGM@public.gmane.org, jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

On Thursday, February 05 2009, Dan Williams said:
> index 706127f..0294502 100755
> --- a/init
> +++ b/init
> @@ -46,6 +46,13 @@ mknod /dev/tty1 c 4 1
>  /sbin/udevd --daemon
>  /sbin/udevadm trigger
>  
> +# start any defined raid arrays
> +# we settle before assembling to hopefully prevent prematurely degrading arrays
> +if [ -f /etc/mdadm.conf ]; then
> +  /sbin/udevadm settle
> +  /sbin/mdadm -Asc /etc/mdadm.conf
> +fi
> +

RAID arrays should be getting started by udev rules, not by explicit
calls to mdadm in /init.  Yes, this means having proper integration with
udev for your kernel pieces.  But this ends up helping everything as it
will also let us lose the multiple redundant calls to things like mdadm
(and lvm, etc) throughout the boot process which should just be
occurring as devices show up.

> +# switch any mdmon instances to newroot
> +[ -f /etc/mdadm.conf ] && /sbin/mdmon /proc/mdstat $NEWROOT
> +

Is there a real need for mdmon to start prior to being in the real
rootfs?

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
