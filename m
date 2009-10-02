From: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: handling mdmon in the initramfs
Date: Fri, 2 Oct 2009 12:05:41 +1000
Message-ID: <19141.24565.657477.284252@notabene.brown>
References: <4AC53A0D.6060806@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: message from Dan Williams on Thursday October 1
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ciechanowski, Ed" <ed.ciechanowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Labun, Marcin" <Marcin.Labun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Patelczyk, Maciej" <maciej.patelczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On Thursday October 1, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> Hi,
> 
> As I learned from Hans and Harald at Plumbers, mdadm and mdmon currently 
> have a few sharp edges when being handled in the initramfs environment. 
>   In talking over some proposed fixes there was a question about the 
> full set of requirements.  Here is a rundown of the problems and 
> proposed solutions...

Thanks for this.

> 
> Problem 1: Ensuring mdmon is active while writes may be in flight
> The kernel will block writes to member disks that have failed and all 
> writes while the array is not in the 'active' state.  For these reasons 
> mdmon is needed in the initramfs because some file systems write to the 
> backing device, even when mounting read-only, to recover their journal.
> 
> However, once that is done Neil points out that mdmon will not be needed 
> again until the filesystem is mounted read-write.  Even if the array 
> goes degraded as a result of running the startup scripts the kernel will 
> allow reads to pass, so we may not need rigid 100% mdmon coverage.
> 
> Two strategies for this situation are to stop mdmon after mounting the 
> rootfs, or just let it be terminated as a result of starting a new 
> instance from the final rootfs.  The latter approach brings up the 
> question of how to communicate with the initramfs-mdmon-instance to make 
> sure we do not end up with two mdmon instances servicing the same 
> container.  The proposed solution here is to switch to 
> abstract-namespace-sockets removing the need to drop a socket file.

What exactly do you mean by "abstract-namespace-sockets"??

I would much rather just down mdmon before pivot_root while everything
is read-only, and start it up again afterwards.

> 
> Problem 2: Discovery / Assembly
> Several issues have forced dracut to punt on using mdadm -I.  Instead 
> dracut copies mdadm.conf to the initramfs and uses mdadm -As after a 
> udevadm --settle.  One low hanging issue is the fact that non-rootfs 
> arrays may only be partially assembled when dracut discovers and 
> switches to the final rootfs.  Upon switching the in-progress map file 
> is lost.  Moving /var/run/mdadm/map to /dev/.mdadm/map would appear to 
> solve this issue.

mdadm already uses /dev/.mdadm.map if /var/run is not writable.  So is
this a solved problem, or do we need some other way to force mdadm not
to use /var/run too early.

Thanks,
NeilBrown


> 
> There was also a report about an udev event storm during incremental 
> assembly, but I am not clear on the sequence of events?
> 
> Any other missed requirements or problems with the proposed solutions?
> 
> Thanks,
> Dan
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
