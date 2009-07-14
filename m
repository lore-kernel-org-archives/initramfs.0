From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] Tell the kernel to forget about partitions found
	on raw imsm raid disks
Date: Wed, 15 Jul 2009 01:02:19 +0200
Message-ID: <20090714230219.GA5766@nb.net.home>
References: <1247603083-3513-1-git-send-email-hdegoede@redhat.com> <1247603083-3513-2-git-send-email-hdegoede@redhat.com> <1247603083-3513-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1247603083-3513-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


 Hi Hans,

On Tue, Jul 14, 2009 at 10:24:43PM +0200, Hans de Goede wrote:
> This patch currently assumes this new utility (code included) will become
> part of udev and will live in /lib/udev, for now it is probably a good idea

 I hope not. The utility duplicate partx(8) / delpart(8) code.

> --- a/modules.d/90mdraid/65-md-incremental-imsm.rules
> +++ b/modules.d/90mdraid/65-md-incremental-imsm.rules
> @@ -6,5 +6,6 @@ SUBSYSTEM=="block", ACTION=="add", \
>         ENV{ID_FS_TYPE}=="linux_raid_member|isw_raid_member", \
>         TEST!="/tmp/.mdraid_start-%k", \
> 	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
>+	RUN+="/lib/udev/rm_partitions $env{DEVNAME}", \

 + RUN+=/sbin/partx -d $env{DEVNAME}", \

> +static int remove_partitions(const char *device_node)
> +{
> +	struct blkpg_partition part = { 0, };
> +	struct blkpg_ioctl_arg io = {
> +		.op = BLKPG_DEL_PARTITION,
> +		.datalen = sizeof(part),
> +		.data = &part,
> +	};
> +
> +	int fd = open(device_node, O_RDWR);
> +	if (fd < 0) {
> +		fprintf(stderr, "Error opening %s: %s\n", device_node,
> +			strerror(errno));
> +		return -1;
> +	}
> +
> +	/* There is no way to enumerate partitions */

 /proc/partitions or /sys/block/<disk>/<disk>[N] or at least 
 use the limit from /sys/block/<disk>/range.

 Unfortunately, partx is also blind and does not use any precisely
 defined list/range of partitions.

> +	for (part.pno = 1; part.pno <= 256; part.pno++) {
> +		if (ioctl(fd, BLKPG, &io) < 0 && errno != ENXIO &&
> +				(part.pno < 16 || errno != EINVAL)) {
> +			fprintf(stderr,
> +				"Error removing part %d from %s: %s\n",
> +				part.pno, device_node,
> +				strerror(errno));
> +			return -1;
> +		}
> +	}


    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
