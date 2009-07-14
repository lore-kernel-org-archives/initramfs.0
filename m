From: David Zeuthen <david-o55+BOBDEFg@public.gmane.org>
Subject: Re: RFC: mdadm and bringing up raid sets from initrd (dracut)
Date: Tue, 14 Jul 2009 10:30:47 -0400
Message-ID: <1247581847.1991.16.camel@localhost.localdomain>
References: <4A5C6501.3080607@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A5C6501.3080607-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Ledford <dledford-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Tue, 2009-07-14 at 12:59 +0200, Hans de Goede wrote:
> Currently the udev rules use incremental assembly like this:
> mdadm -I /dev/mdraid-member
> 
> There are 2 problems with this:
> 1) When doing this for native mdraid metadata arrays, if only
>     one disk is present the set never gets activated
> 2) When doing this for imsm metadata arrays, as soon as the
>     first disk is incrementally added, the set gets activated
>     in degraded mode and stays that way, the second disk
>     will get added to the container, but not to the actual
>     sets in the container

FWIW, this incremental assembly business in mdadm is actually not a very
good idea. At least not the current implementation. I'm not sure whether
it's still a Fedora-ism or whether it's something that's in upstream
mdadm yet. I'm talking about this udev rule

 /lib/udev/rules.d/65-md-incremental.rules:
 # This file causes block devices with Linux RAID (mdadm) signatures to
 # automatically cause mdadm to be run.
 # See udev(8) for syntax
 
 SUBSYSTEM=="block", ACTION=="add", ENV{ID_FS_TYPE}=="linux_raid_member", \
	IMPORT{program}="/sbin/mdadm --examine --export $tempnode", \
	RUN+="/bin/bash -c '[ ! -f /dev/.in_sysinit ] && mdadm -I $env{DEVNAME}'"

For example if the user plugs in a random old disk that happens to
contain half of a RAID1 mirror, then the incremental assembly bits sets
up an inert md-device and the user is now left to his own devices as to
sort this out when he's told by partitioning tools etc. that the disk
(or partition of) he just plugged in, is "busy" (it is claimed by the
inert md node).

I actually had to add some extra code to the GNOME Disk Utility bits to
handle such things (stop inert md devices) - makes the user experience
quite a bit worse since there's now an extra state to worry about. And
most current users don't use the UI bits yet for this so they get extra
confused when trying to use e.g. parted(8) or fdisk(8) on the device.

FWIW, I'd wish people would stop playing games like this. If you want to
do auto-assembly at the system-level, at the very least don't leave the
system in a state like this. For example, one way to do auto-assembly
without such bugs would be to use libudev to enumerate all md component
devices with the same MD_UUID. Then you count the number of components
and only start the array if the number of components equals MD_DEVICES.
That's much better than incrementally adding to an md device node that
might never get used.

I've complained to Doug about this already for Fedora but, since it's
still broken and, AFAICT, up it's way to upstream mdadm, it's worth
reiterating the complaint.

Thanks,
David

[1] : And, except for booting, it's not clear to me that you want to
have policy like auto-assembling RAID arrays at the system. I'd leave
such policy to desktop bits where the user can control it and the
software can actually interact with the user. And where it's easy to
turn off features like this.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
