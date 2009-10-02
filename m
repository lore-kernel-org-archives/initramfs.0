From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: handling mdmon in the initramfs
Date: Fri, 02 Oct 2009 09:09:48 +0200
Message-ID: <4AC5A73C.1000503@redhat.com>
References: <4AC53A0D.6060806@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AC53A0D.6060806-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ciechanowski, Ed" <ed.ciechanowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Labun, Marcin" <Marcin.Labun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Patelczyk, Maciej" <maciej.patelczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Hi,

On 10/02/2009 01:23 AM, Dan Williams wrote:
> Hi,
>
> As I learned from Hans and Harald at Plumbers, mdadm and mdmon currently
> have a few sharp edges when being handled in the initramfs environment.
> In talking over some proposed fixes there was a question about the full
> set of requirements. Here is a rundown of the problems and proposed
> solutions...
>
> Problem 1: Ensuring mdmon is active while writes may be in flight
> The kernel will block writes to member disks that have failed and all
> writes while the array is not in the 'active' state. For these reasons
> mdmon is needed in the initramfs because some file systems write to the
> backing device, even when mounting read-only, to recover their journal.
>
> However, once that is done Neil points out that mdmon will not be needed
> again until the filesystem is mounted read-write. Even if the array goes
> degraded as a result of running the startup scripts the kernel will
> allow reads to pass, so we may not need rigid 100% mdmon coverage.
>

I'm not sure this is true, I had mdmon crashing on hand over from initramfs
-> real root (the malloc vs calloc thing) and IIRC, this causes to hang rc.sysinit
way before getting around the checking the filesystems. Notice that
checking the FS also requires R/W access!

This may have to do something with us calling "mdadm -As --run" from rc.sysinit
before checking the FS, maybe that wants to communicate with mdmon ?

> Two strategies for this situation are to stop mdmon after mounting the
> rootfs, or just let it be terminated as a result of starting a new
> instance from the final rootfs.

Ack, and I must say this is the solution I prefer, lets not try to play the
lets hope nothing needs mdmon before we restart it game, I've done too much
reboots of a hanging system due to mdmon crashing (about 70 I guess) to think
this is a good idea.

 > The latter approach brings up the
> question of how to communicate with the initramfs-mdmon-instance to make
> sure we do not end up with two mdmon instances servicing the same
> container. The proposed solution here is to switch to
> abstract-namespace-sockets removing the need to drop a socket file.
>
> Problem 2: Discovery / Assembly
> Several issues have forced dracut to punt on using mdadm -I. Instead
> dracut copies mdadm.conf to the initramfs and uses mdadm -As after a
> udevadm --settle. One low hanging issue is the fact that non-rootfs
> arrays may only be partially assembled when dracut discovers and
> switches to the final rootfs. Upon switching the in-progress map file is
> lost. Moving /var/run/mdadm/map to /dev/.mdadm/map would appear to solve
> this issue.
>
> There was also a report about an udev event storm during incremental
> assembly, but I am not clear on the sequence of events?
>

The problem is that assembly in general, causes a whole slew of udev change
events being emitted from the /dev/md# node. It would be nice if this could
be reduced somewhat. Esp as we do a "mdadm --detail --export" on each change
event. I've also seen the "mdadm --detail --export" not work (not return any
info) because (I think) the /dev/md# node was not ready yet.

Also see:
https://bugzilla.redhat.com/show_bug.cgi?id=523387

Note that the biggest problem is the partially assembled arrays when we
switch root though (and the "mdadm --detail --export" called from the udev
rules sometimes not working).

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
