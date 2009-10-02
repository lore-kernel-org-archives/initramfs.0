From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: handling mdmon in the initramfs
Date: Thu, 01 Oct 2009 19:52:33 -0700
Message-ID: <4AC56AF1.5030801@intel.com>
References: <4AC53A0D.6060806@intel.com> <19141.24565.657477.284252@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19141.24565.657477.284252-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Ciechanowski, Ed" <ed.ciechanowski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Labun, Marcin" <Marcin.Labun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Patelczyk, Maciej" <maciej.patelczyk-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Neil Brown wrote:
>> Two strategies for this situation are to stop mdmon after mounting the 
>> rootfs, or just let it be terminated as a result of starting a new 
>> instance from the final rootfs.  The latter approach brings up the 
>> question of how to communicate with the initramfs-mdmon-instance to make 
>> sure we do not end up with two mdmon instances servicing the same 
>> container.  The proposed solution here is to switch to 
>> abstract-namespace-sockets removing the need to drop a socket file.
> 
> What exactly do you mean by "abstract-namespace-sockets"??

Harald pointed me to this.  It's the hack that udev uses for its control 
socket [1].  You create a unix domain socket as usual but make the first 
character of the file name a NULL byte.

> 
> I would much rather just down mdmon before pivot_root while everything
> is read-only, and start it up again afterwards.
> 
>> Problem 2: Discovery / Assembly
>> Several issues have forced dracut to punt on using mdadm -I.  Instead 
>> dracut copies mdadm.conf to the initramfs and uses mdadm -As after a 
>> udevadm --settle.  One low hanging issue is the fact that non-rootfs 
>> arrays may only be partially assembled when dracut discovers and 
>> switches to the final rootfs.  Upon switching the in-progress map file 
>> is lost.  Moving /var/run/mdadm/map to /dev/.mdadm/map would appear to 
>> solve this issue.
> 
> mdadm already uses /dev/.mdadm.map if /var/run is not writable.  So is
> this a solved problem, or do we need some other way to force mdadm not
> to use /var/run too early.

So you are talking about commit cf3a3d78 [2].  I think the problem is 
that /var/run/mdadm/map is writable in dracut so we never fall back to 
/dev/.mdadm.map.  Any reason to not make /dev/.mdadm.map the first 
location to try?

Thanks,
Dan

[1]: 
http://git.kernel.org/?p=linux/hotplug/udev.git;a=blob;f=libudev/libudev-ctrl.c;h=e47b2b66#l65

[2]: http://neil.brown.name/git?p=mdadm;a=commitdiff;h=cf3a3d78

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
